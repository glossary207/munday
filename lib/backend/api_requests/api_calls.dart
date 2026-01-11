import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_commons/api_requests/api_manager.dart';

export 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Stripe API Group Code

class StripeAPIGroup {
  static String getBaseUrl() => 'https://api.stripe.com/v1/';
  static Map<String, String> headers = {};
  static CreatePaymentLinkCall createPaymentLinkCall = CreatePaymentLinkCall();
}

class CreatePaymentLinkCall {
  Future<ApiCallResponse> call({
    String? successfulUrl = 'https://google.com',
    String? cancelUrl = 'https://google.com',
    String? priceID = '20',
    String? mode = 'payment',
    String? paymentMethodTypes = 'promptpay',
    String? token = 'sk_live_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
  }) async {
    final baseUrl = StripeAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Create Payment Link',
      apiUrl: '${baseUrl}checkout/sessions',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Basic ${token}',
      },
      params: {
        'payment_method_types': paymentMethodTypes,
        'success_url': successfulUrl,
        'cancel_url': cancelUrl,
        'line_items[][price]': priceID,
        'line_items[][quantity]': 1,
        'line_items[][currency]': "thb",
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Stripe API Group Code

class CreatecheckoutoneCall {
  static Future<ApiCallResponse> call({
    String? uid = '0NfxRkPczdTP4UKidAnHsGUwJeg2',
    String? email = 'offtradingview@gmail.com',
    String? storeId = 'GgKwVGbRCuUUkMHXb1wV',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'createcheckoutone',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/createStripeCheckoutSession1',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'uid': uid,
        'email': email,
        'store_id': storeId,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic respon(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
  static String? url(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.url''',
      ));
}

class CreatecheckouttwoCall {
  static Future<ApiCallResponse> call({
    String? uid = '',
    String? email = '',
    String? storeId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'createcheckouttwo',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/createStripeCheckoutSession2',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'uid': uid,
        'email': email,
        'store_id': storeId,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreatecheckoutthreeCall {
  static Future<ApiCallResponse> call({
    String? uid = '0NfxRkPczdTP4UKidAnHsGUwJeg2',
    String? email = '',
    String? storeId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'createcheckoutthree',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/createStripeCheckoutSession3',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'uid': uid,
        'email': email,
        'store_id': storeId,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ReadupdateCall {
  static Future<ApiCallResponse> call({
    List<String>? chatidList,
  }) async {
    final chatid = _serializeList(chatidList);

    return ApiManager.instance.makeApiCall(
      callName: 'readupdate',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/readupdate',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'chatid': chatid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteuserfromotheruserCall {
  static Future<ApiCallResponse> call({
    String? uid = 'P040ybmTWROd4S3o3KVHhMEfSzc2',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'deleteuserfromotheruser',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/deleteuserfromotheruser',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'uid': uid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteuserfromstoreCall {
  static Future<ApiCallResponse> call({
    String? uid = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'deleteuserfromstore',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/deleteuserfromstore',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'uid': uid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteroomCall {
  static Future<ApiCallResponse> call({
    String? uid = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'deleteroom',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/deleteroom',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'uid': uid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeletechatCall {
  static Future<ApiCallResponse> call({
    String? uid = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'deletechat',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/deletechat',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'uid': uid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteblockedchatCall {
  static Future<ApiCallResponse> call({
    String? blockedUid = '54oxKu6XQ0R2M4ot9UL4DbqNKv73',
    String? blockUid = 'Safb9Ptd5Bhs79ZpE3uzVh7QGO83',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'deleteblockedchat',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/deleteblockedchat',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'blocked_uid': blockedUid,
        'block_uid': blockUid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateonlinestatusCall {
  static Future<ApiCallResponse> call({
    String? uid = '',
    String? storeid = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'updateonlinestatus',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/updateOnlineStatus',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'uid': uid,
        'storeid': storeid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateofflinestatusCall {
  static Future<ApiCallResponse> call({
    String? uid = '',
    String? storeid = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'updateofflinestatus',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/updateOfflineStatus',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'uid': uid,
        'storeid': storeid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateotheruserviewCall {
  static Future<ApiCallResponse> call({
    List<String>? viewsList,
    String? storeid = '',
  }) async {
    final views = _serializeList(viewsList);

    return ApiManager.instance.makeApiCall(
      callName: 'updateotheruserview',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/updateotheruserview',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'views': views,
        'storeid': storeid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateprofileCall {
  static Future<ApiCallResponse> call({
    String? nameupdated = 'offyeiei',
    String? captionupdated = 'na',
    String? photoprofileupdated = 'na',
    String? storeid = 'Oe1i39Pq2uFsLs52xKWc',
    String? uid = '0NfxRkPczdTP4UKidAnHsGUwJeg2',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'updateprofile',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/updateuserprofile',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'nameupdated': nameupdated,
        'captionupdated': captionupdated,
        'photoprofileupdated': photoprofileupdated,
        'storeid': storeid,
        'uid': uid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteuserfromstoretwoCall {
  static Future<ApiCallResponse> call({
    String? uid = '',
    String? storeid = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'deleteuserfromstoretwo',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/deleteuserfromstore2',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'uid': uid,
        'storeid': storeid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SorttableCall {
  static Future<ApiCallResponse> call({
    String? uid = 'Jp1cW5PpBQgkLBBPeHALnz8nRjk2',
    String? tid = '6tP1zBkJs9uUgOlkpAI1',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'sorttable',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/sorttable',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'uid': uid,
        'tid': tid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PromptgenCall {
  static Future<ApiCallResponse> call({
    String? storeid = 'uoczHji5pgWccHn4vjur',
    int? price = 40,
    List<String>? tableNameList,
    String? uid = 'Jp1cW5PpBQgkLBBPeHALnz8nRjk2',
    int? seatamount = 4,
    double? ticketDate = 1731512690,
  }) async {
    final tableName = _serializeList(tableNameList);

    return ApiManager.instance.makeApiCall(
      callName: 'promptgen',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/promtpaygen',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'storeid': storeid,
        'amount': price,
        'table_name': tableName,
        'uid': uid,
        'seatamount': seatamount,
        'ticketDate': ticketDate,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SlipurlCall {
  static Future<ApiCallResponse> call({
    String? slipUrl =
        'https://firebasestorage.googleapis.com/v0/b/chatblack-6g2orl.appspot.com/o/qr_codes%2FIMG_0515.JPG?alt=media&token=932aa778-8251-4e01-bae7-0d2c5e2c224f',
    String? id = 'ogWhTkLMU2PFP9TNYqS9',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'slipurl',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/slipUrl',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'slipUrl': slipUrl,
        'id': id,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VerifytransactionCall {
  static Future<ApiCallResponse> call({
    String? id = 'ogWhTkLMU2PFP9TNYqS9',
    String? userAccNo = '0328',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'verifytransaction',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/verifytransaction',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'id': id,
        'user_acc_no': userAccNo,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TicketgenCall {
  static Future<ApiCallResponse> call({
    String? ticketid = 'ogWhTkLMU2PFP9TNYqS9',
    String? ownerid = 'Jp1cW5PpBQgkLBBPeHALnz8nRjk2',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ticketgen',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/ticketgenforHost',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'ticketid': ticketid,
        'ownerid': ownerid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateOnlineStatusCall {
  static Future<ApiCallResponse> call({
    String? uid = 'Jp1cW5PpBQgkLBBPeHALnz8nRjk2',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'updateOnlineStatus',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/updateOnlineStatus',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'uid': uid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateOfflineStatusCall {
  static Future<ApiCallResponse> call({
    String? uid = 'Jp1cW5PpBQgkLBBPeHALnz8nRjk2',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'updateOfflineStatus',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/updateOfflineStatus',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'uid': uid,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeletepeoplefromvenueCall {
  static Future<ApiCallResponse> call({
    String? uid = '',
    String? userinvenueid = '',
    int? datetodelete,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'deletepeoplefromvenue',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/deletepeoplefromvenue',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'uid': uid,
        'userinvenueid': userinvenueid,
        'datetodelete': datetodelete,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LogerrorCall {
  static Future<ApiCallResponse> call({
    String? err = 'off',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'logerror',
      apiUrl:
          'https://asia-southeast1-chatblack-6g2orl.cloudfunctions.net/logerror',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'err': err,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

String _toEncodable(dynamic item) {
  if (item is SupabaseDocRef) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
