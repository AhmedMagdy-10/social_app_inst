import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/design/widgets/custom_circle_avatar.dart';

import 'package:social_app/design/widgets/reused_form_field.dart';
import 'package:social_app/logic/cubits/SearchCubit/search_cubit.dart';
import 'package:social_app/logic/cubits/SearchCubit/search_states.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  final GlobalKey formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialSearchCubit(),
      child: BlocConsumer<SocialSearchCubit, SocialSearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      reusedTextField(
                        label: const Text('UserName'),
                        prefix: const Icon(Icons.search_outlined),
                        controller: searchController,
                        onSubmitted: (String text) {
                          BlocProvider.of<SocialSearchCubit>(context)
                              .getSearchUser(searchName: searchController.text);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is SearchLoadingStates)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is SearchSuccessStates)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => Row(
                              children: [
                                customCircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                    BlocProvider.of<SocialSearchCubit>(context)
                                        .searchResult[index]['image'],
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  BlocProvider.of<SocialSearchCubit>(context)
                                      .searchResult[index]['name'],
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            separatorBuilder: (context, index) => Container(
                              color: Colors.grey[300],
                              height: 1.5,
                              width: double.infinity,
                            ),
                            itemCount:
                                BlocProvider.of<SocialSearchCubit>(context)
                                    .searchResult
                                    .length,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
