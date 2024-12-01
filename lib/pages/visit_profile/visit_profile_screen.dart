import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/components/components.dart';
import '../../core/controllers/visit_profile_cubit/visit_profile_cubit.dart';
import '../../core/controllers/visit_profile_cubit/visit_profile_states.dart';
import '../../core/styles/icon_broken.dart';



class VisitProfileScreen extends StatelessWidget {
  const VisitProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VisitCubit, VisitStates>(
      listener: (context, state) {
        if (state is RemoveUserVisitPostsSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var userVisitModel = VisitCubit.get(context).userVisitModel;
        // List<PostModel>? userVisitPosts = VisitCubit.get(context).userVisitPosts;
        return ConditionalBuilder(
          condition: VisitCubit.get(context).userVisitModel != null,
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
                  ),
                  onPressed: () {
                    VisitCubit.get(context).removeUserVisitPosts();
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 220.0,
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Container(
                              width: double.infinity,
                              height: 180.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    userVisitModel!.coverImage!,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: CircleAvatar(
                              radius: 61.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 58.0,
                                backgroundImage: NetworkImage(
                                  userVisitModel.image!,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      userVisitModel.name!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      userVisitModel.bio!, //use bodySmall instead of caption
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 28.0,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          bottom: 10.0, end: 15.0, start: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '${userVisitModel.noOfPosts}',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    'Posts',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '${userVisitModel.noOfFollowers}',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    'Followers',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '${userVisitModel.noOfFollowing}',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    'Following',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.grey,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '${userVisitModel.noOfFriends}',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    'Friends',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (VisitCubit.get(context).userVisitPosts != null)
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Posts',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 20.0,
                                ),
                          ),
                        ),
                      ),
                    if (VisitCubit.get(context).userVisitPosts == null)
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'No Posts yet',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 20.0,
                                ),
                          ),
                        ),
                      ),
                    if (VisitCubit.get(context).userVisitPosts != null)
                      const SizedBox(
                        height: 10.0,
                      ),
                    if (VisitCubit.get(context).userVisitPosts != null)
                      ListView.separated(
                        itemCount:
                            VisitCubit.get(context).userVisitPosts!.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildPostItem(
                            context: context,
                            model:
                                VisitCubit.get(context).userVisitPosts![index],
                            index: index,
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8.0,
                        ),
                      ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
