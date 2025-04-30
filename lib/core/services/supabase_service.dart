// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'database_services.dart';

// class SupabaseService implements DatabaseService {
//   final supabase = Supabase.instance.client;

//   @override
//   Future<void> addData({
//     required String path,
//     required Map<String, dynamic> data,
//     String? documentId,
//   }) async {
//     await supabase.from(path).insert(data);
//   }

//   @override
//   Future<dynamic> getData({
//     required String path,
//     String? documentId,
//     Map<String, dynamic>? query,
//   }) async {
//     var queryBuilder = supabase.from(path).select();

// if (query != null) {
//   if (query.containsKey('limit') && query['limit'] is int) {
//     queryBuilder = queryBuilder.limit(query['limit'] as int);
//   }
//   if (query.containsKey('orderBy') && query['orderBy'] is String) {
//     queryBuilder = queryBuilder.order(
//       query['orderBy'] as String,
//       ascending: !(query['descending'] as bool? ?? false),
//     );
//   }
// }

//     final data = await queryBuilder;
//     return data;
//   }

//   @override
//   Future<bool> checkIfDataExists({
//     required String path,
//     required String documentId,
//   }) async {
//     final response = await supabase
//         .from(path)
//         .select()
//         .eq('id', documentId)
//         .maybeSingle();

//     return response != null;
//   }
// }
