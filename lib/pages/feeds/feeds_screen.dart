import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/components/components.dart';
import '../../core/controllers/bloc/cubit.dart';
import '../../core/controllers/bloc/states.dart';
import '../../core/styles/icon_broken.dart';


class FeedsScreen extends StatelessWidget {
  FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is  SocialGetPostsSuccessState){}
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var model = SocialCubit.get(context).userModel;
        var posts =SocialCubit.get(context).posts;
        return ConditionalBuilder(
          condition: posts.isNotEmpty,
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  if (!(model!.isEmailVerified!))
                    Container(
                      height: 45.0,
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade200,
                        //borderRadius: const BorderRadiusDirectional.all(Radius.circular(7.0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(IconBroken.Info_Circle),
                          const SizedBox(width: 12.0),
                          Expanded(
                              child: Text(
                            'Please Verify Your Email',
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                          defaultTextButton(
                            text: 'verify email',
                            function: () {
                              cubit.verifyEmail();
                            },
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // Card(
                  //   elevation: 4.0,
                  //   margin:
                  //       const EdgeInsetsDirectional.only(bottom: 8.0, top: 1.0),
                  //   child: Stack(
                  //     alignment: AlignmentDirectional.bottomEnd,
                  //     children: [
                  //       Image(
                  //         width: double.infinity,
                  //         height: 180.0,
                  //         fit: BoxFit.cover,
                  //         image: NetworkImage(
                  //             'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Text(
                  //           'Communicate With Friends',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .titleSmall
                  //               ?.copyWith(
                  //                 color: Colors.white,
                  //               ), // same style as subtitle1
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildPostItem(
                          context: context,
                          model: posts[index],
                          index: index);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 9.0,
                    ),
                    itemCount: posts.length,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            );
          },
          fallback: (context) =>  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu,
                  color: SocialCubit.get(context).isDark? Colors.grey[400]: Colors.black45,  //black 45 for light theme , grey[400] for dark
                  size: 100.0,
                ),
                Text(
                  'No Posts Yet',
                  style: TextStyle(
                    color: SocialCubit.get(context).isDark? Colors.grey[400]: Colors.black45, //change color here according to theme mode
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
