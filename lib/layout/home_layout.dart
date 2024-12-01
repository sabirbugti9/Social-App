import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/new_post/new_post_screen.dart';
import '../core/components/components.dart';
import '../core/constants/constants.dart';
import '../core/controllers/bloc/cubit.dart';
import '../core/controllers/bloc/states.dart';
import '../core/styles/icon_broken.dart';
class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialGetUserErrorState) {
          showToast(
              message: 'check your internet connection',
              state: ToastStates.NOTIFY);
        }
        if(state is SocialAddPostState){
          navigateTo(context: context, widget: NewPostScreen());
        }

      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[savedCurrentIndex]),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(IconBroken.Notification),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(IconBroken.Search),
              ),
            ],
          ),
          body: cubit.screens[savedCurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: savedCurrentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper_Upload,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Location,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Profile
                ),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              cubit.changeBottomIndex(index);
            },
          ),
        );
      },
    );
  }
}

/// ConditionalBuilder(
//               condition: SocialCubit.get(context).model != null,
//               builder: (context) {
//                 var model = SocialCubit.get(context).model;
//                 return  Column(
//                   children: [
//                     if(!(FirebaseAuth.instance.currentUser!.emailVerified))
//                     Container(
//                       padding: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
//                       decoration: BoxDecoration(
//                         color: Colors.amber.shade200,
//                         borderRadius: BorderRadiusDirectional.all(Radius.circular(7.0)),
//                       ),
//
//                       child: Row(
//                         children: [
//                           Icon(Icons.warning_amber),
//                           SizedBox(width: 15.0),
//                           Text('Please Verify Your Email'),
//                           Spacer(),
//                           defaultTextButton(
//                             text: 'verify email',
//                             function: (){
//                               FirebaseAuth.instance.currentUser
//                                   ?.sendEmailVerification()
//                                   .then((value) {
//                                     showToast(message: 'check your mail', state: ToastStates.SUCCESS);
//                               }).catchError((error){
//                                 showToast(message: 'check your internet connection', state: ToastStates.NOTIFY);
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               },
//               fallback: (context) => const Center(child: CircularProgressIndicator()),
//
//             )
