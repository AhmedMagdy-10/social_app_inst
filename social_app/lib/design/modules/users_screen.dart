import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/helper/navigator_to.dart';
import 'package:social_app/design/modules/setting_screen.dart';

import 'package:social_app/design/widgets/custom_circle_avatar.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final TextEditingController searchController = TextEditingController();
  final GlobalKey formKey = GlobalKey();
  var searchName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
            height: 40,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchName = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                label: const Text('Search'),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 18,
                ),
              ),
            )),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .orderBy('name')
              .startAt([searchName]).endAt(["$searchName\uf8ff"]).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];

                  return ListTile(
                    onTap: () {
                      navigatorPushTo(context, const SettingView());
                    },
                    leading: customCircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(data['image']),
                    ),
                    title: Text(data['name']),
                    subtitle: Text(data['bio']),
                  );
                },
                itemCount: snapshot.data!.docs.length);
          }),
    );
  }
}
