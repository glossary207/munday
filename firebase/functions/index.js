const functions = require("firebase-functions");
const admin = require("firebase-admin");
const axios = require("axios").default;
admin.initializeApp();

const kFcmTokensCollection = "fcm_tokens";
const kPushNotificationsCollection = "ff_push_notifications";
const kUserPushNotificationsCollection = "ff_user_push_notifications";
const firestore = admin.firestore();

const kPushNotificationRuntimeOpts = {
  timeoutSeconds: 540,
  memory: "2GB",
};

const kInstagramFetchRuntimeOpts = {
  timeoutSeconds: 60,
  memory: "256MB",
};

exports.addFcmToken = functions
  .region("asia-east1")
  .https.onCall(async (data, context) => {
    if (!context.auth) {
      return "Failed: Unauthenticated calls are not allowed.";
    }
    const userDocPath = data.userDocPath;
    const fcmToken = data.fcmToken;
    const deviceType = data.deviceType;
    if (
      typeof userDocPath === "undefined" ||
      typeof fcmToken === "undefined" ||
      typeof deviceType === "undefined" ||
      userDocPath.split("/").length <= 1 ||
      fcmToken.length === 0 ||
      deviceType.length === 0
    ) {
      return "Invalid arguments encoutered when adding FCM token.";
    }
    if (context.auth.uid != userDocPath.split("/")[1]) {
      return "Failed: Authenticated user doesn't match user provided.";
    }
    const existingTokens = await firestore
      .collectionGroup(kFcmTokensCollection)
      .where("fcm_token", "==", fcmToken)
      .get();
    var userAlreadyHasToken = false;
    for (var doc of existingTokens.docs) {
      const user = doc.ref.parent.parent;
      if (user.path != userDocPath) {
        // Should never have the same FCM token associated with multiple users.
        await doc.ref.delete();
      } else {
        userAlreadyHasToken = true;
      }
    }
    if (userAlreadyHasToken) {
      return "FCM token already exists for this user. Ignoring...";
    }
    await getUserFcmTokensCollection(userDocPath).doc().set({
      fcm_token: fcmToken,
      device_type: deviceType,
      created_at: admin.firestore.FieldValue.serverTimestamp(),
    });
    return "Successfully added FCM token!";
  });

exports.sendPushNotificationsTrigger = functions
  .region("asia-east1")
  .runWith(kPushNotificationRuntimeOpts)
  .firestore.document(`${kPushNotificationsCollection}/{id}`)
  .onCreate(async (snapshot, _) => {
    try {
      // Ignore scheduled push notifications on create
      const scheduledTime = snapshot.data().scheduled_time || "";
      if (scheduledTime) {
        return;
      }

      await sendPushNotifications(snapshot);
    } catch (e) {
      console.log(`Error: ${e}`);
      await snapshot.ref.update({ status: "failed", error: `${e}` });
    }
  });

exports.sendUserPushNotificationsTrigger = functions
  .region("asia-east1")
  .runWith(kPushNotificationRuntimeOpts)
  .firestore.document(`${kUserPushNotificationsCollection}/{id}`)
  .onCreate(async (snapshot, _) => {
    try {
      // Ignore scheduled push notifications on create
      const scheduledTime = snapshot.data().scheduled_time || "";
      if (scheduledTime) {
        return;
      }

      // Don't let user-triggered notifications to be sent to all users.
      const userRefsStr = snapshot.data().user_refs || "";
      if (userRefsStr) {
        await sendPushNotifications(snapshot);
      }
    } catch (e) {
      console.log(`Error: ${e}`);
      await snapshot.ref.update({ status: "failed", error: `${e}` });
    }
  });

async function sendPushNotifications(snapshot) {
  const notificationData = snapshot.data();
  const title = notificationData.notification_title || "";
  const body = notificationData.notification_text || "";
  const imageUrl = notificationData.notification_image_url || "";
  const sound = notificationData.notification_sound || "";
  const parameterData = notificationData.parameter_data || "";
  const targetAudience = notificationData.target_audience || "";
  const initialPageName = notificationData.initial_page_name || "";
  const userRefsStr = notificationData.user_refs || "";
  const batchIndex = notificationData.batch_index || 0;
  const numBatches = notificationData.num_batches || 0;
  const status = notificationData.status || "";

  if (status !== "" && status !== "started") {
    console.log(`Already processed ${snapshot.ref.path}. Skipping...`);
    return;
  }

  if (title === "" || body === "") {
    await snapshot.ref.update({ status: "failed" });
    return;
  }

  const userRefs = userRefsStr === "" ? [] : userRefsStr.trim().split(",");
  var tokens = new Set();
  if (userRefsStr) {
    for (var userRef of userRefs) {
      const userTokens = await firestore
        .doc(userRef)
        .collection(kFcmTokensCollection)
        .get();
      userTokens.docs.forEach((token) => {
        if (typeof token.data().fcm_token !== undefined) {
          tokens.add(token.data().fcm_token);
        }
      });
    }
  } else {
    var userTokensQuery = firestore.collectionGroup(kFcmTokensCollection);
    // Handle batched push notifications by splitting tokens up by document
    // id.
    if (numBatches > 0) {
      userTokensQuery = userTokensQuery
        .orderBy(admin.firestore.FieldPath.documentId())
        .startAt(getDocIdBound(batchIndex, numBatches))
        .endBefore(getDocIdBound(batchIndex + 1, numBatches));
    }
    const userTokens = await userTokensQuery.get();
    userTokens.docs.forEach((token) => {
      const data = token.data();
      const audienceMatches =
        targetAudience === "All" || data.device_type === targetAudience;
      if (audienceMatches && typeof data.fcm_token !== undefined) {
        tokens.add(data.fcm_token);
      }
    });
  }

  const tokensArr = Array.from(tokens);
  var messageBatches = [];
  for (let i = 0; i < tokensArr.length; i += 500) {
    const tokensBatch = tokensArr.slice(i, Math.min(i + 500, tokensArr.length));
    const messages = {
      notification: {
        title,
        body,
        ...(imageUrl && { imageUrl: imageUrl }),
      },
      data: {
        initialPageName,
        parameterData,
      },
      android: {
        notification: {
          ...(sound && { sound: sound }),
        },
      },
      apns: {
        payload: {
          aps: {
            ...(sound && { sound: sound }),
          },
        },
      },
      tokens: tokensBatch,
    };
    messageBatches.push(messages);
  }

  var numSent = 0;
  await Promise.all(
    messageBatches.map(async (messages) => {
      const response = await admin.messaging().sendEachForMulticast(messages);
      numSent += response.successCount;
    }),
  );

  await snapshot.ref.update({ status: "succeeded", num_sent: numSent });
}

function getUserFcmTokensCollection(userDocPath) {
  return firestore.doc(userDocPath).collection(kFcmTokensCollection);
}

function getDocIdBound(index, numBatches) {
  if (index <= 0) {
    return "users/(";
  }
  if (index >= numBatches) {
    return "users/}";
  }
  const numUidChars = 62;
  const twoCharOptions = Math.pow(numUidChars, 2);

  var twoCharIdx = (index * twoCharOptions) / numBatches;
  var firstCharIdx = Math.floor(twoCharIdx / numUidChars);
  var secondCharIdx = Math.floor(twoCharIdx % numUidChars);
  const firstChar = getCharForIndex(firstCharIdx);
  const secondChar = getCharForIndex(secondCharIdx);
  return "users/" + firstChar + secondChar;
}

function getCharForIndex(charIdx) {
  if (charIdx < 10) {
    return String.fromCharCode(charIdx + "0".charCodeAt(0));
  } else if (charIdx < 36) {
    return String.fromCharCode("A".charCodeAt(0) + charIdx - 10);
  } else {
    return String.fromCharCode("a".charCodeAt(0) + charIdx - 36);
  }
}
exports.onUserDeleted = functions
  .region("asia-east1")
  .auth.user()
  .onDelete(async (user) => {
    let firestore = admin.firestore();
    let userRef = firestore.doc("users/" + user.uid);
  });

exports.getInstagramProfileInfo = functions
  .region("asia-southeast1")
  .runWith(kInstagramFetchRuntimeOpts)
  .https.onRequest(async (req, res) => {
    setCorsHeaders(res);

    if (req.method === "OPTIONS") {
      return res.status(204).send("");
    }

    const rawUsername =
      req.method === "POST" ? req.body?.username : req.query.username;
    const username = normalizeInstagramUsername(rawUsername);
    if (!username) {
      return res.status(400).json({
        error: "invalid_username",
        message: "Instagram username is missing or invalid.",
      });
    }

    try {
      const response = await axios.get(
        "https://www.instagram.com/api/v1/users/web_profile_info/",
        {
          params: { username },
          headers: {
            "x-ig-app-id": "936619743392459",
            "User-Agent":
              "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36",
            "Accept": "application/json, text/plain, */*",
            "Accept-Language": "en-US,en;q=0.9",
            "Referer": `https://www.instagram.com/${username}/`,
          },
          timeout: 15000,
        },
      );

      const user = response.data?.data?.user;
      if (!user) {
        return res.status(404).json({
          error: "not_found",
          message: "Instagram profile was not found.",
        });
      }

      return res.status(200).json({
        username: user.username || username,
        full_name: user.full_name || "",
        biography: user.biography || "",
        profile_pic_url: user.profile_pic_url_hd || user.profile_pic_url || "",
        followers_count: toNullableInt(user.edge_followed_by?.count),
        following_count: toNullableInt(user.edge_follow?.count),
      });
    } catch (error) {
      const upstreamStatus = error.response?.status || null;
      const message =
        error.response?.data?.message || error.message || "Unknown error";

      return res.status(upstreamStatus || 502).json({
        error: "instagram_fetch_failed",
        message,
        upstream_status: upstreamStatus,
      });
    }
  });

function setCorsHeaders(res) {
  res.set("Access-Control-Allow-Origin", "*");
  res.set("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
  res.set("Access-Control-Allow-Headers", "Content-Type");
}

function normalizeInstagramUsername(input) {
  if (typeof input !== "string") {
    return "";
  }

  let value = input.trim();
  if (!value) {
    return "";
  }

  value = value.replace(/^@+/, "");

  try {
    if (value.includes("instagram.com")) {
      const parsedUrl = new URL(
        value.startsWith("http") ? value : `https://${value}`,
      );
      value = parsedUrl.pathname.split("/").filter(Boolean)[0] || "";
    }
  } catch (_) {}

  value = value.replace(/^@+/, "").split(/[/?#]/)[0].trim();

  if (!/^[A-Za-z0-9._]{1,30}$/.test(value)) {
    return "";
  }

  return value;
}

function toNullableInt(value) {
  return Number.isFinite(value) ? Math.trunc(value) : null;
}
