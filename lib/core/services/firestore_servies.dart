import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pickpay/core/services/database_services.dart';

class FireStoreService implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  // addData responsible for adding data to database
  Future<void> addData(
      {required String path, required Map<String, dynamic> data}) async{

       await firestore.collection(path).add(data);

       
  }
}
