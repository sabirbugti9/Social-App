import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Styles/colors.dart';
import 'package:social_app/models/message_model.dart';
import '../../core/components/components.dart';
import '../../core/controllers/bloc/cubit.dart';
import '../../core/controllers/bloc/states.dart';
import '../../core/controllers/visit_profile_cubit/visit_profile_cubit.dart';
import '../../core/styles/icon_broken.dart';
import '../../models/user_model.dart';
import '../visit_profile/visit_profile_screen.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModel? receiverModel;
  final messageController = TextEditingController();

  ChatDetailsScreen({Key? key, required this.receiverModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        // SocialCubit.get(context).getMessages(receiverId: receiverModel!.uId!);

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (BuildContext context, SocialStates state) {},
          builder: (BuildContext context, SocialStates state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                leading: IconButton(
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        VisitCubit.get(context)
                            .getUserVisitData(userId: receiverModel!.uId!)
                            .then((value) {
                          navigateTo(
                              context: context, widget: VisitProfileScreen());
                        });
                      },
                      child: CircleAvatar(
                        radius: 23.0,
                        backgroundImage: NetworkImage(
                          receiverModel!.image!,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        receiverModel!.name!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz_sharp,
                      size: 22.0,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              body: ConditionalBuilder(
                condition: receiverModel != null,
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).messages[index];
                              if (message.senderId ==
                                  SocialCubit.get(context).userModel?.uId) {
                                return buildMyMessage(message);
                              } else {
                                return buildMessageItem(message);
                              }
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 15.0,
                            ),
                            itemCount: SocialCubit.get(context).messages.length,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: const BorderRadiusDirectional.all(
                                Radius.circular(20.0)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: TextFormField(
                                    style: Theme.of(context)
                                        .inputDecorationTheme
                                        .hintStyle,
                                    controller: messageController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Write a message...',
                                      hintStyle: Theme.of(context)
                                          .inputDecorationTheme
                                          .hintStyle,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  SocialCubit.get(context).getMessageImage(
                                      dataTime: Timestamp.now(),
                                      receiverId: receiverModel!.uId!);
                                },
                                icon: const Icon(
                                  IconBroken.Image,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (messageController.text.isNotEmpty) {
                                    SocialCubit.get(context).sendMessage(
                                      receiverId: receiverModel!.uId!,
                                      dateTime: Timestamp.now(),
                                      text: messageController.text,
                                    );
                                  }
                                },
                                icon: const Icon(
                                  IconBroken.Send,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                fallback: (BuildContext context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessageItem(MessageModel messageModel) {
    return ConditionalBuilder(
      condition: messageModel.image == null,
      builder: (context) {
        return Align(
          alignment: AlignmentDirectional.centerStart,
          child: InkWell(
            onLongPress: () {
              showAlertDialog(context: context);
            },
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Colors.grey[600]?.withOpacity(0.8),
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              child: Text(
                messageModel.text,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
      fallback: (context) {
        return Align(
          alignment: AlignmentDirectional.centerStart,
          child: InkWell(
            onLongPress: () {
              showAlertDialog(context: context);
            },
            child: Container(
              width: 223.0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(15.0),
                  topStart: Radius.circular(15.0),
                  topEnd: Radius.circular(15.0),
                ),
              ),
              child: Image(
                image: NetworkImage(messageModel.image!),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMyMessage(MessageModel model) {
    return ConditionalBuilder(
      condition: model.image == null,
      builder: (context) {
        return Align(
          alignment: AlignmentDirectional.centerEnd,
          child: InkWell(
            onLongPress: () {
              showMyAlertDialog(context: context);
            },
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: defaultColor.withOpacity(0.7),
                borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              child: Text(
                model.text,
                style: const TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
        );
      },
      fallback: (context) {
        return Align(
          alignment: AlignmentDirectional.centerEnd,
          child: InkWell(
            onLongPress: () {
              showMyAlertDialog(context: context);
            },
            child: Container(
              width: 223.0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(15.0),
                  topStart: Radius.circular(15.0),
                  topEnd: Radius.circular(15.0),
                ),
              ),
              child: Image(
                image: NetworkImage(model.image!),
              ),
            ),
          ),
        );
      },
    );
  }

  void showMyAlertDialog({
    required BuildContext context,
  }) {
// Set up the buttons
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop(true);
        //Appcubit.get(context).cancelDelete(context);
      },
      child: const Text(
        'Cancel',
        style: TextStyle(color: defaultColor),
      ),
    );
    Widget deleteForEveryoneButton = TextButton(
      onPressed: () {
        // Appcubit.get(context).deleteFromMydatabase(id: taskModel['id']);
        Navigator.of(context).pop(true);
      },
      child: const Text(
        'Delete for everyone',
        style: TextStyle(color: defaultColor),
      ),
    );
    Widget deleteForMeButton = TextButton(
      onPressed: () {
        // Appcubit.get(context).deleteFromMydatabase(id: taskModel['id']);
        Navigator.of(context).pop(true);
      },
      child: const Text(
        'Delete for me',
        style: TextStyle(
          color: defaultColor,
        ),
      ),
    );

    // Set up the alert dialog
    AlertDialog alert = AlertDialog(
      backgroundColor:
          SocialCubit.get(context).isDark ? Colors.grey[700] : Colors.white,
      surfaceTintColor:
          SocialCubit.get(context).isDark ? Colors.grey[700] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        'Delete message?',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
          color: SocialCubit.get(context).isDark
              ? Colors.grey[700]
              : Colors.white, //change color according to theme
        ),
      ),
      actions: [
        cancelButton,
        deleteForEveryoneButton,
        deleteForMeButton,
      ],
    );
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  void showAlertDialog({
    required BuildContext context,
  }) {
    // Set up the buttons
    Widget cancelButton = TextButton(
      onPressed: () {
        //Appcubit.get(context).cancelDelete(context);
      },
      child: const Text(
        'Cancel',
        style: TextStyle(color: defaultColor),
      ),
    );
    Widget DeleteForMeButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop(true);
      },
      child: const Text(
        'Delete for me',
        style: TextStyle(
          color: defaultColor,
        ),
      ),
    );

    // Set up the alert dialog
    AlertDialog alert = AlertDialog(
      backgroundColor:
          SocialCubit.get(context).isDark ? Colors.grey[700] : Colors.white,
      surfaceTintColor:
          SocialCubit.get(context).isDark ? Colors.grey[700] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        'Delete message?',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
          color: SocialCubit.get(context).isDark
              ? Colors.grey[700]
              : Colors.white, //change color according to theme
        ),
      ),
      actions: [
        cancelButton,
        DeleteForMeButton,
      ],
    );
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
