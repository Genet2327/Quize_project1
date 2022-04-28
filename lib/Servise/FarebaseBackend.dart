import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quize_project/Servise/Storage.dart';

import '../Model/AddQuatins.dart';
import '../Model/Quez.dart';
import 'auth.dart';

class FirestoreBackend implements Storage {
  static const _quize = 'quize';
  static const _users = 'users';
  static const _Quation = 'quation';

  // static const _description = 'description';

  @override
  Future<List<Quize>> getQuize() async {
    final userId = AuthServise.getUserId();
    if (userId == null) throw StateError('Not logged in');
    final result = await FirebaseFirestore.instance
        .collection(_users)
        .doc(userId)
        .collection(_quize)
        .get();
    //final ds = await FirebaseFirestore.instance.collection('tasks').get();
    List<Quize> x = result.docs.map((doc) {
      return Quize(
          QuizeTitle: doc.data()['QuizeTitle'].toString(),
          QuizeDescription: doc.data()['QuizeDescription'].toString(),
          id: doc.id);
    }).toList();

    return x;
  }

  Future<List<Quations>> getQuation(String? QuationId) async {
    final userId = AuthServise.getUserId();
    if (userId == null) throw StateError('Not logged in');
    final result = await FirebaseFirestore.instance
        .collection(_users)
        .doc(userId)
        .collection(_quize)
        .doc(QuationId)
        .collection(_Quation)
        .get();
    //final ds = await FirebaseFirestore.instance.collection('tasks').get();
    List<Quations> x = result.docs.map((doc) {
      return Quations(
          Quation: doc.data()['quation'].toString(),
          option1: doc.data()['option1'].toString(),
          option2: doc.data()['option2'].toString(),
          option3: doc.data()['option3'].toString(),
          option4: doc.data()['option4'].toString(),
          id: doc.id);
    }).toList();
   print(x);
    return x;
  }

  @override
  Future<Quize> insertQuize(String QuizeTitle, String QuizeDescription) async {
    final userId = AuthServise.getUserId();
    if (userId == null) throw StateError('Not logged in');
    await FirebaseFirestore.instance
        .collection(_users)
        .doc(userId)
        .collection(_quize)
        .add({'QuizeTitle': QuizeTitle, 'QuizeDescription': QuizeDescription});
    final result = await FirebaseFirestore.instance
        .collection(_users)
        .doc(userId)
        .collection(_quize)
        .get();
    Quize newQuize = result.docs.map((doc) {
      return Quize(
          QuizeTitle: doc.data()['QuizeTitle'].toString(),
          QuizeDescription: doc.data()['QuizeDescription'].toString(),
          id: doc.id);
    }).firstWhere((element) {
      return element.QuizeDescription == QuizeDescription ||
          element.QuizeTitle == QuizeTitle;
    });
    print(newQuize);
    return newQuize;
  }

  @override
  Future<void> insertQutions(String quation, String option1, String option2,
      String option3, String option4, String Id) async {
    String QuizeId = Id;
    final userId = AuthServise.getUserId();
    if (userId == null) throw StateError('Not logged in');
    await FirebaseFirestore.instance
        .collection(_users)
        .doc(userId)
        .collection(_quize)
        .doc(QuizeId)
        .collection(_Quation)
        .add({
      'quation': quation,
      'option1': option1,
      'option2': option2,
      'option3': option3,
    });

    final result = await FirebaseFirestore.instance
        .collection(_users)
        .doc(userId)
        .collection(_quize)
        .doc(QuizeId)
        .collection(_Quation)
        .get();
    //final ds = await FirebaseFirestore.instance.collection('tasks').get();
    List<Quations> x = result.docs.map((doc) {
      return Quations(
          Quation: doc.data()['Quation'].toString(),
          option1: doc.data()['option1'].toString(),
          option2: doc.data()['option2'].toString(),
          option3: doc.data()['option3'].toString(),
          option4: doc.data()['option4'].toString(),
          id: doc.id);
    }).toList();
  }

  getQuizeData(String quizeId) async {
    final userId = AuthServise.getUserId();
    return await FirebaseFirestore.instance
        .collection(_users)
        .doc(userId)
        .collection(_quize)
        .snapshots();
  }

  getQuationsData(String? id) async {
    final userId = AuthServise.getUserId();
    return await FirebaseFirestore.instance
        .collection(_users)
        .doc(userId)
        .collection(_quize)
        .doc(id)
        .collection(_Quation)
        .get();
  }
}
