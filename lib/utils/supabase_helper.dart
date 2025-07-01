import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  final SupabaseClient _client = Supabase.instance.client;

  /// ------------------------------
  /// GROUPS
  /// ------------------------------

  Future<void> addGroup(String name) async {
    await _client.from('groups').insert({
      'name': name,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> fetchAllGroups() async {
    final data = await _client.from('groups').select().order('created_at');
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> deleteGroup(String groupId) async {
    // Optional: delete all ideas in that group first to maintain integrity
    await _client.from('ideas').delete().eq('group_id', groupId);

    // Then delete the group
    await _client.from('groups').delete().eq('id', groupId);
  }

  /// ------------------------------
  /// IDEAS
  /// ------------------------------

  Future<void> addIdea({
    required String groupId,
    required String title,
    String? description,
  }) async {
    await _client.from('ideas').insert({
      'group_id': groupId,
      'title': title,
      'description': description ?? '',
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> fetchIdeasForGroup(String groupId) async {
    final data = await _client
        .from('ideas')
        .select()
        .eq('group_id', groupId)
        .order('created_at');

    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> deleteIdea(String ideaId) async {
    await _client.from('ideas').delete().eq('id', ideaId);
  }

  /// ------------------------------
  /// Update idea (optional)
  /// ------------------------------
  Future<void> updateIdea({
    required String ideaId,
    required String title,
    String? description,
  }) async {
    await _client.from('ideas').update({
      'title': title,
      'description': description ?? '',
    }).eq('id', ideaId);
  }
}
