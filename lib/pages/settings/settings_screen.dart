import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Styles/colors.dart';
import '../../core/components/components.dart';
import '../../core/controllers/bloc/cubit.dart';
import '../../core/controllers/bloc/states.dart';
import '../../core/styles/icon_broken.dart';
import '../login/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(context: context, title: 'Settings'),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 200.0,
                  ),
                  /********      change mode and language button    **********/
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: SocialCubit.get(context).isDark
                              ? Colors.white38
                              : Colors.grey[700]!,
                        ),
                        borderRadius:
                            const BorderRadiusDirectional.all(Radius.circular(15.0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /********      change mode button    **********/
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.brightness_2_outlined,
                                size: 24.0,
                                color: SocialCubit.get(context).isDark
                                    ? Colors.grey[350]
                                    : Colors
                                        .black87, //change color here according the theme
                              ),
                              const SizedBox(width: 7.0),
                              Text(
                                'Dark Mode',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: SocialCubit.get(context).isDark
                                      ? Colors.grey[350]
                                      : Colors
                                          .black87, // change color here according to theme mode
                                ),
                              ),
                              const Spacer(),
                              Switch(
                                activeColor: defaultColor,
                                splashRadius: 6.0,
                                value: SocialCubit.get(context).isDark,
                                onChanged: (bool value) {
                                  SocialCubit.get(context).changeMode();
                                },
                              ),
                            ],
                          ),
                          /********      change language button    **********/
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.language_outlined,
                                    size: 24.0,
                                    color: SocialCubit.get(context).isDark
                                        ? Colors.grey[350]
                                        : Colors
                                            .black87, //change color here according to theme
                                  ),
                                  const SizedBox(width: 7.0),
                                  Text(
                                    'Language',
                                    style: TextStyle(
                                      color: SocialCubit.get(context).isDark
                                          ? Colors.grey[350]
                                          : Colors.black87,
                                      // change color here according to theme mode
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /********      log out button    **********/
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      onTap: () {
                        SocialCubit.get(context)
                            .logOut(context: context, widget: LoginScreen());
                      },
                      child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                            vertical: 11.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white38,
                          ),
                          borderRadius: const BorderRadiusDirectional.all(
                              Radius.circular(15.0)),
                        ),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Logout,
                              size: 24.0,
                              color: SocialCubit.get(context).isDark
                                  ? Colors.grey[350]
                                  : Colors
                                      .black87, //change color here according to theme
                            ),
                            const SizedBox(width: 7.0),
                            Text(
                              'Log out',
                              style: TextStyle(
                                color: SocialCubit.get(context).isDark
                                    ? Colors.grey[350]
                                    : Colors.black87,
                                // cange color here according to theme mode
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
