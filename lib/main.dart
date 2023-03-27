import 'package:chamcong_app/providers/api.dart';
import 'package:chamcong_app/providers/auth.dart';
import 'package:chamcong_app/providers/location.dart';
import 'package:chamcong_app/providers/notification.dart';
import 'package:chamcong_app/providers/time_break.dart';
import 'package:chamcong_app/providers/time_ot.dart';
import 'package:chamcong_app/providers/time_work.dart';
import 'package:chamcong_app/providers/users.dart';
import 'package:chamcong_app/screens/account_info_screen.dart';
import 'package:chamcong_app/screens/auth_screen.dart';
import 'package:chamcong_app/screens/change_password_screen.dart';
import 'package:chamcong_app/screens/history_timeot_timebreak.dart';
import 'package:chamcong_app/screens/history_timework_detail_screen.dart';
import 'package:chamcong_app/screens/history_timework_screen.dart';
import 'package:chamcong_app/screens/tabs_screen.dart';
import 'package:chamcong_app/screens/timebreak_screen.dart';
import 'package:chamcong_app/screens/timeot_timebreak_detail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //----initialize firebase from firebase core plugin
  await Firebase.initializeApp();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => API()),
        ChangeNotifierProvider(create: (context) => Location()),

        // State TimeWork
        ChangeNotifierProxyProvider<Auth, TimeWork>(
          create: (_) => TimeWork('', 0, {}),
          update: (context, auth, previous) => TimeWork(
              auth.apiTimework, auth.getAccount['id'], auth.getHeader()),
        ),

        // State Users
        ChangeNotifierProxyProvider<Auth, Users>(
          create: (_) => Users('', '', {}),
          update: (context, auth, users) =>
              Users(auth.token, auth.apiAllAccount, auth.getHeader()),
        ),

        //State TimeBreak
        ChangeNotifierProxyProvider<Auth, TimeBreaks>(
          create: (_) => TimeBreaks('', '', 0, {}),
          update: (context, auth, users) => TimeBreaks(auth.token,
              auth.apiTimebreak, auth.getAccount['id'], auth.getHeader()),
        ),

        //State Time OT
        ChangeNotifierProxyProvider<Auth, TimeOT>(
          create: (_) => TimeOT('', '', 0, {}),
          update: (context, auth, timeOt) =>
              TimeOT(auth.token, auth.apiTimeOT, auth.getAccount['id'], auth.getHeader()),
        ),

        //State Noti
        ChangeNotifierProxyProvider<Auth, Notifications>(
          create: (_) => Notifications('', {}),
          update: (context, auth, previous) => Notifications(auth.apiNoti, auth.getHeader()),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Color(0xFFEF4923),
              backgroundColor: Color(0xFFF2F3F8),
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD9DDE8)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              textTheme: TextTheme(
                headline1: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1a1a1a)),
                headline2: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF303439)),
                headline3: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                headline4: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
                headline5: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                headline6: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ).apply(bodyColor: Color(0xFF303439)),
              appBarTheme: AppBarTheme(
                elevation: 4,
                backgroundColor: Colors.white,
                iconTheme: Theme.of(context).iconTheme,
                titleTextStyle: TextStyle(
                  color: Color(0xFF303439),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: IconThemeData(
                color: Color(0xFF74777A),
                size: 28,
              ),
            ),
            home: !auth.isAuth ? AuthScreen() : TabsScreen(),
            routes: {
              '/home': (context) => TabsScreen(),
              TimeBreakScreen.routeName: (context) => TimeBreakScreen(),

              HistoryTimeworkScreen.routeName: (context) =>
                  HistoryTimeworkScreen(),

              HistoryTimeWorkDetailScreen.routeName: (context) =>
                  HistoryTimeWorkDetailScreen(),

              // History Time OT
              HistoryTimeOt.routeName:(context) => HistoryTimeOt(),
              
              // Detail Time Ot - Work
              TimeOTWorkDetail.routeName:(context) => TimeOTWorkDetail(),

              //account
              AccountInfoScreen.routeName: (context) => AccountInfoScreen(),

              //change pass
              ChangePasswordScreen.routeName: (context) =>
                  ChangePasswordScreen(),

            },
          );
        },
      ),
    );
  }
}
