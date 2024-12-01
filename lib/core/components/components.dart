import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Styles/colors.dart';
import '../../models/post_model.dart';
import '../../pages/visit_profile/visit_profile_screen.dart';
import '../controllers/bloc/cubit.dart';
import '../controllers/visit_profile_cubit/visit_profile_cubit.dart';
import '../styles/icon_broken.dart';

void navigateTo({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return widget;
  }));
}

void navigateAndRemove({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) {
      return false;
    },
  );
}

Widget defaultButton({
  required double width,
  double height = 42.0,
  required Color backgroundColor,
  bool isUpperCase = true,
  double radius = 6.0,
  required String text,
  required Function function,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required String text,
  required void Function()? function,
}) =>
    TextButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: defaultColor,
          ),
        ));

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) {
  return AppBar(
    title: Text(title ?? ''),
    leading: IconButton(
      icon: const Icon(
        IconBroken.Arrow___Left_2,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: actions,
  );
}

Widget defaultFormField({
  required TextInputType type,
  required TextEditingController controller,
  String? label,
  String? hint,
  IconData? preficon,
  IconData? sufficon,
  String? Function(String?)? validator,
  InputBorder? inputBorder,
  Color? fillColor,
  Color? labelColor,
  Color? hintColor,
  Color? cursorColor,
  double? cursorHeight,
  Color? prefixColor,
  double? prefixIconSize,
  void Function()? suffixPreesed,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  TextStyle? style,
  bool isObsecure = false,
  void Function()? onTab,
}) =>
    SizedBox(
      height: 55.0,
      child: TextFormField(
        style: style,
        keyboardType: type,
        controller: controller,
        validator: validator,
        obscureText: isObsecure,
        cursorColor: cursorColor,
        cursorHeight: cursorHeight,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          fillColor: fillColor,
          labelStyle: TextStyle(
            color: labelColor,
          ),
          border: inputBorder,
          labelText: label,
          hintText: hint,
          hintStyle: TextStyle(
            color: hintColor,
          ),
          prefixIcon: Icon(
            preficon,
            color: prefixColor,
            size: prefixIconSize,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              sufficon,
            ),
            onPressed: suffixPreesed,
          ),
        ),
        onTap: onTab,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
      ),
    );

void showToast({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStates { SUCCESS, WAENING, ERROR, NOTIFY }

Color chooseToastColor(ToastStates state) {
  late Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WAENING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.NOTIFY:
      color = Colors.grey;
      break;
  }
  return color;
}

Widget myDivider() {
  return Divider(
    height: 1.0,
    indent: 15.0,
    endIndent: 15.0,
    color: Colors.grey[350],
  );
}

Widget buildPostItem({
  required PostModel model,
  required BuildContext context,
  required int index,
}) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  VisitCubit.get(context)
                      .getUserVisitData(userId: model.uId)
                      .then((value) {
                    navigateTo(
                        context: context, widget: const VisitProfileScreen());
                  });
                },
                child: CircleAvatar(
                  radius: 22.0,
                  backgroundImage: NetworkImage(model.image),
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        model.name,
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 1.6,
                          color: SocialCubit.get(context).isDark
                              ? Colors.white
                              : Colors
                                  .black, // change color here according to theme mode.
                        ),
                      ),
                      const SizedBox(
                        width: 2.0,
                      ),
                      const Icon(
                        Icons.check_circle,
                        color: defaultColor,
                        size: 16.0,
                      ),
                    ],
                  ),
                  Text(
                    model.dateTime,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          //change color here according to theme
                          height: 1.5,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz_sharp,
                  size: 22.0,
                  color: SocialCubit.get(context).isDark
                      ? Colors.grey[350]
                      : Colors
                          .black, // change color here according to theme mode
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: Text(
              model.text,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          //the tags below

          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsetsDirectional.only(top: 5.0, bottom: 10.0),
          //   child: Wrap(
          //     children: [
          //       Container(
          //         child: MaterialButton(
          //           onPressed: () {},
          //           minWidth: 1.2,
          //           textColor: Colors.blue,
          //           padding: EdgeInsets.zero,
          //           child: Text('#software'),
          //         ),
          //         height: 25.0,
          //         padding: EdgeInsetsDirectional.only(end: 5.0),
          //       ),
          //       Container(
          //         child: MaterialButton(
          //           onPressed: () {},
          //           minWidth: 1.2,
          //           textColor: Colors.blue,
          //           padding: EdgeInsets.zero,
          //           child: Text('#flutter'),
          //         ),
          //         height: 25.0,
          //         padding: EdgeInsetsDirectional.only(end: 5.0),
          //       ),
          //       Container(
          //         child: MaterialButton(
          //           onPressed: () {},
          //           minWidth: 1.2,
          //           textColor: Colors.blue,
          //           padding: EdgeInsets.zero,
          //           child: Text('#mobile_development'),
          //         ),
          //         height: 25.0,
          //         padding: EdgeInsetsDirectional.only(end: 5.0),
          //       ),
          //       Container(
          //         child: MaterialButton(
          //           onPressed: () {},
          //           minWidth: 1.2,
          //           textColor: Colors.blue,
          //           padding: EdgeInsets.zero,
          //           child: Text('#software_development'),
          //         ),
          //         height: 25.0,
          //         padding: EdgeInsetsDirectional.only(end: 5.0),
          //       ),
          //     ],
          //   ),
          // ), //wrap of hashtags
          if (model.postImage != '')
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                width: double.infinity,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadiusDirectional.all(Radius.circular(5.0)),
                  image: DecorationImage(
                    image: NetworkImage(
                      model.postImage,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          const SizedBox(
            height: 15.0,
          ),
          //image of post
          Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                            size: 18.0,
                          ),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              '${SocialCubit.get(context).postsLikes[index]}',
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ), // caption style replaced by bodySmall
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          IconBroken.Chat,
                          color: Colors.amber,
                          size: 18.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          '0 comments',
                          style: Theme.of(context).textTheme.bodySmall,
                        ), // caption style replaced by bodySmall
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: CircleAvatar(
                            radius: 1.6,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        Text(
                          '0 shares',
                          style: Theme.of(context).textTheme.bodySmall,
                        ), // caption style replaced by bodySmall
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // InkWell of Row of likes, comments, and shares
          Divider(
            color: Theme.of(context).dividerTheme.color,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16.0,
                        backgroundImage: NetworkImage(
                          SocialCubit.get(context).userModel!.image!,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Write a comment...',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  SocialCubit.get(context).likePost(
                      postId: SocialCubit.get(context).postsIds[index],
                      index: index,
                      userID: SocialCubit.get(context).userModel!.uId!);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        color: SocialCubit.get(context).likeColor(
                            postId: SocialCubit.get(context).postsIds[index],
                            userID: SocialCubit.get(context).userModel!.uId!,
                            isLike: false),
                        size: 18.0,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.bodySmall,
                      ), // caption style replaced by bodySmall
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 17.0,
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Upload,
                        color: Colors.green,
                        size: 18.0,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        'Share',
                        style: Theme.of(context).textTheme.bodySmall,
                      ), // caption style replaced by bodySmall
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
