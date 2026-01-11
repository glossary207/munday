import 'package:supabase_flutter/supabase_flutter.dart';

Future<Map<String, dynamic>> makeCloudCall(
  String callName,
  Map<String, dynamic> input,
) async {
  try {
    final response =
        await Supabase.instance.client.functions.invoke(callName, body: input);
    // Response data is dynamic. Supabase Functions return data directly.
    return response.data is Map
        ? Map<String, dynamic>.from(response.data as Map)
        : {};
  } catch (e) {
    print('Cloud call error:${callName} $e');
  }
  return {};
}
