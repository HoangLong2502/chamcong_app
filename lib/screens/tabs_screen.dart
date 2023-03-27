import 'package:chamcong_app/providers/notification.dart';
import 'package:chamcong_app/screens/account_screen.dart';
import 'package:chamcong_app/screens/calendar_work_screen.dart';
import 'package:chamcong_app/screens/home_screen.dart';
import 'package:chamcong_app/screens/noti_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    String deviceToken = await getDeviceToken();
    print('--------------');
    print(deviceToken);

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
    //   String? title = remoteMessage.notification!.title;
    //   String? description = remoteMessage.notification!.body;

    //   print(title);
    //   print(description);
    // });
  }

  //get device token to user for push notification
  Future getDeviceToken() async {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken();
    return (deviceToken == null) ? '' : deviceToken;
  }

  final List<Map<String, dynamic>> _pages = [
    {
      'page': HomeScreen(),
      'title': 'Trang chu',
    },
    {
      'page': CalendarWorkScreen(),
      'title': 'Trang chu',
    },
    {
      'page': NotiScreen(),
      'title': 'Trang chu',
    },
    {
      'page': AccountScreen(),
      'title': 'Trang chu',
    },
  ];

  int _pageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    Provider.of<Notifications>(context).handleGetNoti();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(
              Icons.location_pin,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(width: 8),
            Text(
              '48 Tố Hữu, Trung Văn, Hà Nội',
            ),
          ],
        ),
      ),
      body: _pages[_pageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.white,
        unselectedItemColor: Color(0xFF74777A),
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Color(0xFF74777A),
            ),
            activeIcon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: '',
          )
        ],
      ),
    );
  }
}
