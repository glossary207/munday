import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://xdhhlxpysugtzkqrtdzp.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhkaGhseHB5c3VndHprcXJ0ZHpwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYwODE0ODIsImV4cCI6MjA4MTY1NzQ4Mn0.WjtC3gW03KYsNexLS734sBJS-ZIKH4bKOmhKatoFPk8',
    );
  }
}
