import { createClient } from "npm:@supabase/supabase-js@2";

type VerificationPayload = {
  reservation_bill_id?: string;
  approved?: boolean;
  tx_ref?: string | null;
  slip_hash?: string | null;
};

const json = (status: number, body: Record<string, unknown>) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { "content-type": "application/json; charset=utf-8" },
  });

Deno.serve(async (request) => {
  if (request.method !== "POST") {
    return json(405, { error: "Method not allowed" });
  }

  const expectedSecret = Deno.env.get("SLIP_VERIFICATION_WEBHOOK_SECRET");
  const suppliedSecret = request.headers.get("x-verification-secret");
  if (!expectedSecret || !suppliedSecret || suppliedSecret !== expectedSecret) {
    return json(401, { error: "Unauthorized" });
  }

  let payload: VerificationPayload;
  try {
    payload = await request.json() as VerificationPayload;
  } catch {
    return json(400, { error: "Invalid JSON body" });
  }

  if (
    !payload.reservation_bill_id ||
    typeof payload.approved !== "boolean"
  ) {
    return json(400, {
      error: "reservation_bill_id and approved are required",
    });
  }

  const supabaseUrl = Deno.env.get("SUPABASE_URL");
  const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  if (!supabaseUrl || !serviceRoleKey) {
    return json(500, { error: "Service configuration is missing" });
  }

  const supabase = createClient(supabaseUrl, serviceRoleKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
  const { data, error } = await supabase.rpc("verify_reservation_payment", {
    p_reservation_bill_id: payload.reservation_bill_id,
    p_approved: payload.approved,
    p_tx_ref: payload.tx_ref ?? null,
    p_slip_hash: payload.slip_hash ?? null,
  });

  if (error) {
    console.error("verify_reservation_payment failed", error.code);
    return json(409, { error: error.message, code: error.code });
  }

  return json(200, { data });
});
