import 'package:pickpay/core/services/database_services.dart' show DatabaseService;
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabaseService implements DatabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      if (documentId != null) {
        data['id'] = documentId; // Make sure 'id' is your primary key
        await _supabase.from(path).upsert(data);
      } else {
        await _supabase.from(path).insert(data);
      }
    } catch (e) {
      throw Exception("Error adding data: $e");
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  }) async {
    try {
      final queryBuilder = _supabase.from(path).select();

      if (documentId != null) {
        final response = await queryBuilder.eq('id', documentId).single();
        return response;
      } else {
        if (query != null) {
          if (query['orderBy'] != null) {
            final field = query['orderBy'];
            final descending = query['descending'] ?? false;
            queryBuilder.order(field, ascending: !descending);
          }

          if (query['limit'] != null) {
            queryBuilder.limit(query['limit']);
          }
        }

        final response = await queryBuilder;
        return response;
      }
    } catch (e) {
      throw Exception("Error getting data: $e");
    }
  }

  @override
  Future<bool> ckeckIfDataExists({
    required String path,
    required String documentId,
  }) async {
    try {
      final response = await _supabase
          .from(path)
          .select('id')
          .eq('id', documentId)
          .maybeSingle();
      return response != null;
    } catch (e) {
      throw Exception("Error checking data: $e");
    }
  }
}
