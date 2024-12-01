import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/pages/login/login_screen.dart';
import 'core/bloc_observer.dart';
import 'core/components/components.dart';
import 'core/constants/constants.dart';
import 'core/controllers/bloc/cubit.dart';
import 'core/controllers/bloc/states.dart';
import 'core/controllers/visit_profile_cubit/visit_profile_cubit.dart';
import 'core/styles/themes.dart';
import 'network/local/cache_helper.dart';

//Handle background message (the app is closed or the app is running in the background)
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  showToast(message: "Background message", state: ToastStates.SUCCESS);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //check internet
  // bool result = await InternetConnectionChecker().hasConnection;
  // if (result == true) {
  //   return;
  // } else {
  //   showToast(
  //       message: 'No Internet Connection, check internet and try again',
  //       state: ToastStates.NOTIFY);
  // }

  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

// use the returned token to send messages to users from your custom server
  String? token = await messaging.getToken();
  print('token is $token');
  //token is c0tM5SrMRcqXZPJJafAGoN:APA91bEYitQWQL4XumxyXXb4zJsCmMIWMhEx4dRShuXzVfLr6gvnDG2Z2awqYu9ny0k1Gz-hkTdINwocJdE_59bbjJuP9z7eyIpy05ZNynTjZDShE5wWLHlkt6AuB9itHlgNdfKEcDXM

  // Handle foreground messages (notification)
  //To listen to messages while your application is in the foreground (you are opening the application)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message in the foreground!');
    print('Message data: ${message.data}');
    showToast(message: "on message", state: ToastStates.SUCCESS);
    // if (message.notification != null) {
    //   print('Message also contained a notification: ${message.notification.toString()}');
    // }
  });

  //Handle a message when the user clicked on the notification  (the app is running in the background)
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('On MessageOpened App!');
    print('Message data: ${message.data}');
    showToast(message: "On message opened app", state: ToastStates.SUCCESS);
    // if (message.notification != null) {
    //   print('Message also contained a notification: ${message.notification.toString()}');
    // }
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  if (CacheHelper.checkData(key: 'uId')) {
    uId = CacheHelper.getData(key: 'uId') as String;
  } else {
    uId = null;
  }
//
  if (CacheHelper.checkData(key: 'savedCurrentIndex')) {
    savedCurrentIndex = CacheHelper.getData(key: 'savedCurrentIndex') as int;
  }

  bool? isDarkTheme = CacheHelper.getBoolean(key: 'isDark');
  Widget widget;

  if (uId != null) {
    widget = HomeLayout();
  } else {
    widget = LoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
    isDarkk: isDarkTheme,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool? isDarkk;

  MyApp({super.key, required this.startWidget, required this.isDarkk});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..setMode(fromShared: isDarkk)
            ..getPosts()
            ..getUserData(userId: uId)
            ..getAllUsers(),
        ),
        BlocProvider(
          create: (context) => VisitCubit(),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            //title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: SocialCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
