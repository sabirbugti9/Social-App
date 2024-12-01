import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/pages/chats/chat_details_screen.dart';
import '../../core/components/components.dart';
import '../../core/controllers/bloc/cubit.dart';
import '../../core/controllers/bloc/states.dart';


class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        MessageModel? message;

        for (int i = 0;
            i <= SocialCubit.get(context).messages.length - 1;
            i++) {
          if (i == SocialCubit.get(context).messages.length - 1) {
            message = SocialCubit.get(context).messages[i];
          }
        }
        return ConditionalBuilder(
          condition: SocialCubit.get(context).usersData.isNotEmpty &&
              SocialCubit.get(context).userModel != null,
          builder: (context) {
            return ListView.separated(
              itemBuilder: (context, index) => buildChatItem(
                model: SocialCubit.get(context).usersData[index],
                context: context,
                message: message,
              ),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: SocialCubit.get(context).usersData.length,
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(
      {required UserModel model,
      required BuildContext context,
      required MessageModel? message}) {
    return InkWell(
      onTap: () {
        SocialCubit.get(context).getMessages(receiverId: model.uId!);
        navigateTo(
            context: context, widget: ChatDetailsScreen(receiverModel: model));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: SocialCubit.get(context).isDark
                ? Colors.grey[600]
                : Colors.grey[200],
            //200 for light and grey[500] for dark
            borderRadius: const BorderRadiusDirectional.all(Radius.circular(8.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26.0,
                  backgroundImage: NetworkImage(
                    model.image!,
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name!, // model.name!
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 1.6,
                          color: SocialCubit.get(context).isDark
                              ? Colors.white.withOpacity(0.9)
                              : Colors.black87,
                        ),
                      ),
                      ConditionalBuilder(
                        condition: message?.text != null,
                        builder: (context) {
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  message!.text,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: SocialCubit.get(context).isDark
                                        ? Colors.white.withOpacity(0.9)
                                        : Colors.black87.withOpacity(0.7),
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: CircleAvatar(
                                  radius: 1.5,
                                  backgroundColor:
                                      SocialCubit.get(context).isDark
                                          ? Colors.white.withOpacity(0.9)
                                          : Colors.black87.withOpacity(0.7),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${DateFormat.E()
                                          .format(message.dateTime.toDate())}, ${DateFormat.jm()
                                          .format(message.dateTime.toDate())}',
                                  style: TextStyle(
                                    color: SocialCubit.get(context).isDark
                                        ? Colors.white.withOpacity(0.9)
                                        : Colors.black87.withOpacity(0.7),
                                    fontSize: 14.0,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          );
                        },
                        fallback: (context) {
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
