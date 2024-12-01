import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Styles/colors.dart';
import '../../core/components/components.dart';
import '../../core/controllers/bloc/cubit.dart';
import '../../core/controllers/bloc/states.dart';
import '../../core/styles/icon_broken.dart';


class EditPostScreen extends StatelessWidget {
  EditPostScreen({super.key});
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var cubit = SocialCubit.get(context);
        var now = DateTime.now();
        return ConditionalBuilder(
          condition: userModel != null,
          builder: (context) {
            return Scaffold(
              appBar: defaultAppBar(
                context: context,
                title: 'Create Post',
                actions: [
                  defaultTextButton(text: 'Post', function: () {
                    if(cubit.postImage == null ) {
                      cubit.createPost(text: textController.text, dateTime: now.toString()).then((value) {
                        Navigator.pop(context);
                      });
                    } else{
                      cubit.uploadPostImage(text: textController.text, dateTime: now.toString()).then((value) {
                        Navigator.pop(context);
                      });
                    }

                  }),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if (state is SocialCreatePostLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SocialCreatePostLoadingState)
                      const SizedBox(
                        height: 15.0,
                      ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(
                            userModel!.image!,
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          userModel.name!,
                          style: TextStyle(
                            fontSize: 16.0,
                            height: 1.6,
                            color: SocialCubit.get(context).isDark? Colors.white :Colors.black, //change color here according to theme mode
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        style: Theme.of(context).inputDecorationTheme.hintStyle,
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: 'what is in your mind...',
                          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if(SocialCubit.get(context).postImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 180.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(cubit.postImage!),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0),
                            child: CircleAvatar(
                              backgroundColor: defaultColor,
                              radius: 17.0,
                              child: IconButton(
                                onPressed: () {
                                  cubit.removePostImage();
                                },
                                splashRadius: 21.0,
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: (){
                              cubit.getPostImage();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconBroken.Image,
                                ),
                                SizedBox(width: 5.0,),
                                Text('Add Photo'),
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          child: defaultTextButton(
                              text: '#tags',
                              function: (){}
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) {
            return Scaffold(
              appBar: AppBar(),

            );
          },
        );
      },
    );
  }
}
