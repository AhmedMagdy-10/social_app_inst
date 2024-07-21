import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:social_app/logic/cubits/SearchCubit/search_states.dart';

class SocialSearchCubit extends Cubit<SocialSearchStates> {
  SocialSearchCubit() : super(SearchInitailStates());
  List<Map<String, dynamic>> searchResult = [];
  Future<List<Map<String, dynamic>>> getSearchUser(
      {required String searchName}) async {
    final users = FirebaseFirestore.instance.collection('users');

    final QuerySnapshot snapshot =
        await users.where('name', isEqualTo: searchName).get();

    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.forEach((element) {
        searchResult.add(element.data() as Map<String, dynamic>);
      });
      return searchResult;
    } else {
      return [];
    }
  }
}
