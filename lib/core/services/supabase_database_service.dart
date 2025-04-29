// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../../models/product_model.dart';
// import 'database_service.dart';

// class SupabaseDatabaseService implements DatabaseService {
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
//   Future getData({
//     required String path,
//     String? documentId,
//     Map<String, dynamic>? query,
//   }) async {
//     final queryBuilder = supabase.from(path).select();
//     if (documentId != null) {
//       return queryBuilder.eq('id', documentId).single();
//     }
//     return queryBuilder;
//   }

//   @override
//   Future<bool> ckeckIfDataExists({
//     required String path,
//     required String documentId,
//   }) async {
//     final result = await supabase.from(path).select().eq('id', documentId);
//     return (result as List).isNotEmpty;
//   }

//   @override
//   Future<List<Product>> fetchProducts() async {
//     final response = await supabase.from('products').select();
//     return (response as List)
//         .map((json) => Product.fromJson(json))
//         .toList();
//   }
// }
