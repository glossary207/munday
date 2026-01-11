# Developer Guide: The Antigravity Workflow

This guide explains how to develop in the `Munday` project using our Supabase architecture.

## 1. Environment Setup
- **VS Code**: Install recommended extensions (Prompt will appear on open).
- **Flutter**: Ensure you are on the latest stable channel.
- **Supabase**: Config is in `lib/backend/supabase/supabase_config.dart`.

## 2. The Firestore Shim
We are using a **Shim Layer** to mimic Firestore updates while using Supabase.
- **Location**: `lib/backend/supabase/firestore_shim.dart`
- **Usage**: You can use `FirebaseFirestore.instance` (aliased) or `SupabaseFirestore.instance`.
- **Key Classes**:
  - `DocumentReference`: Handles update/set/delete.
  - `Query`: Handles filtering.
  - `FieldValue`: Supports `.arrayUnion`, `.arrayRemove`, `.increment`.

## 3. New Features (The "Antigravity" Way)
For new features that require data access, **do not** add global functions to `backend.dart`. Instead, use the **Repository Pattern**.

### Step 1: Create a Repository
App folder: `lib/backend/repositories/`

Example:
```dart
class UserRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getActiveUsers() async {
    return await _client.from('users').select().eq('status', 'active');
  }
}
```

### Step 2: Use in UI
Instantiate the repository in your widget or Action block.

## 4. Troubleshooting
- **Build Errors**: Run `flutter pub get`.
- **iOS Signing**: Check `ios/Runner.entitlements` if you have signing issues.
