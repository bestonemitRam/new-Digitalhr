import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cnattendance/utils/DatabaseHelper.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:cnattendance/utils/internet_service.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/model/auth.dart';
import 'package:cnattendance/provider/attendancereportprovider.dart';
import 'package:cnattendance/provider/dashboardprovider.dart';
import 'package:cnattendance/provider/leaveprovider.dart';
import 'package:cnattendance/provider/meetingprovider.dart';
import 'package:cnattendance/provider/morescreenprovider.dart';
import 'package:cnattendance/provider/payslipprovider.dart';
import 'package:cnattendance/provider/prefprovider.dart';
import 'package:cnattendance/provider/profileprovider.dart';
import 'package:cnattendance/screen/auth/login_screen.dart';
import 'package:cnattendance/screen/dashboard/dashboard_screen.dart';
import 'package:cnattendance/screen/profile/editprofilescreen.dart';
import 'package:cnattendance/screen/profile/payslipdetailscreen.dart';
import 'package:cnattendance/screen/profile/profilescreen.dart';
import 'package:cnattendance/screen/profile/meetingdetailscreen.dart';
import 'package:cnattendance/screen/splashscreen.dart';
import 'package:cnattendance/utils/navigationservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'data/source/network/model/logout/Logoutresponse.dart';
import 'firebase_options.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:background_location/background_location.dart';

const fetchBackground = "fetchBackground";
const getLocation = "getLocation";
const checkLocationEnabled = "checkLocationEnabled";
final dbHelper = DatabaseHelper();

// @pragma('vm:entry-point')
// void callbackDispatcher(BuildContext ctx) {
//   Workmanager().executeTask((task, inputData) async {
//     print("Native called background task: $task");
//     switch (task) {
//       case getLocation:
//         // bgLocationTask();
//         break;
//       case checkLocationEnabled:
//         hasUserClosedLocation(ctx);
//         break;
//       case fetchBackground:
//         print("Getting user locaton");
//         // Position userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//         //onStart();
//         break;
//     }
//     return Future.value(true);
//   });
// }

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPref = await SharedPreferences.getInstance();
  // initializeService();
  //BackgroundLocation.startLocationService();
  //initBackgroundLocation();

  // Workmanager().initialize(
  //     callbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode:
  //         true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  //     );

  // Workmanager().registerPeriodicTask(
  //   "getLocation",
  //   getLocation,
  //   frequency: Duration(seconds: 2),
  // );

  // Workmanager().registerPeriodicTask(
  //   "checkLocationEnabled",
  //   checkLocationEnabled,
  //   frequency: Duration(seconds: 5),
  // );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined or has not accepted permission');
  }

  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/app_icon',
      [
        NotificationChannel(
            channelGroupKey: 'digital_hr_group',
            channelKey: 'digital_hr_channel',
            channelName: 'Digital Hr notifications',
            channelDescription: 'Digital HR Alert',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'digital_hr_group', channelGroupName: 'HR group')
      ],
      debug: true);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  FirebaseMessaging.onMessage.listen((event) {
    FlutterRingtonePlayer.play(
      fromAsset: "assets/sound/beep.mp3",
    );
    try {
      InAppNotification.show(
        child: Card(
          margin: const EdgeInsets.all(15),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            leading: Container(
                height: double.infinity, child: Icon(Icons.notifications)),
            iconColor: HexColor("#011754"),
            textColor: HexColor("#011754"),
            minVerticalPadding: 10,
            minLeadingWidth: 0,
            tileColor: Colors.white,
            title: Text(
              event.notification!.title!,
            ),
            subtitle: Text(
              event.notification!.body!,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        context: NavigationService.navigatorKey.currentState!.context,
      );
    } catch (e) {
      print(e);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('Message cxcvcvclicked! ${message}');
  });

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(const MyApp());
  configLoading();
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  FlutterRingtonePlayer.play(
    fromAsset: "assets/sound/beep.mp3",
  );
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 50.0
    ..radius = 0.0
    ..progressColor = Colors.blue
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.blue
    ..textColor = Colors.black
    ..maskType = EasyLoadingMaskType.none
    ..userInteractions = false
    ..dismissOnTap = false;
}

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       // this will executed when app is in foreground or background in separated isolate
//       onStart: onStart,
//       // auto start service
//       autoStart: true,
//       isForegroundMode: true,
//     ),
//     iosConfiguration: IosConfiguration(
//       // auto start service
//       autoStart: true,
//       // this will executed when app is in foreground in separated isolate
//       onForeground: onStart,
//       onBackground:
//         onStart ,

//       // you have to enable background fetch capability on xcode project
//      // onBackground: onIosBackground,
//     ),
//   );
// }

// Future<void> bgLocationTask() async {
//     BackgroundLocation.startLocationService();

//   print("dkjfhgkjfgkjgkjdhgf    ");
//   try {
//     final backgroundApiViewModel = DashboardProvider();

//     Timer.periodic(Duration(seconds: 5), (Timer t) async
//     {
//       log("SENDING LOC ${t.tick}");
//       print("Calling getCurrentPosition within Timer");
//       initBackgroundLocation();
//        backgroundApiViewModel.getCurrentPosition();
//     });
//   } catch (err,stackTrace) {
//     print("This is the error: $err");
//     print("Stacktrace : ${stackTrace}");
//     throw Exception(err.toString());
//   }
// }

void initBackgroundLocation() {
  print("dkfgkjdfhgjk");
  BackgroundLocation.startLocationService();
  BackgroundLocation.getLocationUpdates((location) {
    print("Location: ${location.latitude}, ${location.longitude}");
    // Handle your location updates here
  });
}

Future<void> hasUserClosedLocation(BuildContext context) async {
  print("dfghdgfjjdfh");
  Timer.periodic(Duration(seconds: 5), (timer) async {
    bool _serviceEnabled;
    LocationPermission _permission;
    Position _position;
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      var uri = Uri.parse(Constant.LOGOUT_URL);

      Preferences preferences = Preferences();
      String token = await preferences.getToken();
      int getUserID = await preferences.getUserId();

      print("Get user token is :$token");
      print("Get user id  is :$getUserID");

      Map<String, String> headers = {
        'Accept': 'application/json; charset=UTF-8',
        'user_token': '$token',
        'user_id': '$getUserID',
      };
      print("Header is :$headers");
      try {
        final response = await http.get(uri, headers: headers);
        debugPrint(response.body.toString());

        final responseData = json.decode(response.body);

        if (response.statusCode == 200 || response.statusCode == 401) {
          final jsonResponse = Logoutresponse.fromJson(responseData);
          print("Logout is Successfully");
          preferences.clearPrefs();
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else {
          var errorMessage = responseData['message'];
          throw errorMessage;
        }
      } catch (e) {
        throw e;
      }
      return;
    } else {
      print("Location service is enabled  ${_serviceEnabled}");
      try {
        _position = await Geolocator.getCurrentPosition();
        // Do something with _position
        print("Location: ${_position.latitude}, ${_position.longitude}");
      } catch (e) {
        print("Error getting location: $e");
      }
    }
  });
}

// Future<void> onStart() async {

//   print("dkjhfgkjfjkgkfhgfjkgkj");

//   WidgetsFlutterBinding.ensureInitialized();
//   final service = FlutterBackgroundService();
//   final backgroundApiViewModel = DashboardProvider();
//   Timer.periodic(Duration(seconds: 15), (Timer t) async
//   {
//     log("Service executing");
//     await backgroundApiViewModel. getCurrentPosition();
//     service.onDataReceived.listen((event) {
//       // log("THIS IS ACTION : "+event!["action"]);
//       if (event!["action"] == "setAsForeground") {
//         service.setForegroundMode(true);
//         Timer.periodic(Duration(seconds: 15), (Timer t) async
//         {
//           await backgroundApiViewModel. getCurrentPosition();
//         });
//         return;
//       }

//       if (event["action"] == "setAsBackground")
//       {
//         print("BG");
//         Timer.periodic(Duration(seconds: 15), (Timer t) async
//         {
//           log("SENDING LOC ${t.tick }");
//           await backgroundApiViewModel. getCurrentPosition();
//         });
//         service.setForegroundMode(false);
//       }

//       if (event["action"] == "stopService")
//        {
//         Timer.periodic(Duration(seconds: 15), (Timer t) async
//         {
//           await backgroundApiViewModel. getCurrentPosition();
//         });
//         service.stopBackgroundService();
//       }
//     });
//   });

//   // bring to foreground
//   service.setForegroundMode(true);
//   Timer.periodic(Duration(seconds: 15), (timer) async
//   {

//     await backgroundApiViewModel. getCurrentPosition();
//     if (!(await service.isServiceRunning())) timer.cancel();
//     service.setNotificationInfo(
//       title: "My App Service",
//       content: "Updated at ${DateTime.now()}",
//     );

//     service.sendData(
//       {"current_date": DateTime.now().toIso8601String()},
//     );
//   });

//   var isRunning = await service.isServiceRunning();
//   if (isRunning) {
//     service.sendData(
//       {"action": "stopService"},
//     );
//   } else {
//     service.start();
//   }

//   if (!isRunning) {
//     Timer.periodic(Duration(seconds: 5), (Timer t) async
//     {
//       await backgroundApiViewModel. getCurrentPosition();
//     });
//   } else {
//     Timer.periodic(Duration(seconds: 5), (Timer t) async
//     {
//       await backgroundApiViewModel. getCurrentPosition();
//     });
//   }
// }

void stopLocationService() {
  BackgroundLocation.stopLocationService();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    // bgLocationTask();
    WidgetsBinding.instance.addObserver(this);
    //stopLocationService();
    Timer.periodic(Duration(seconds: 3), (timer) {
      //hasUserClosedLocation(context);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      ;
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('AppLifecycleState changed to: $state');

    // You can handle different lifecycle states here
    switch (state) {
      case AppLifecycleState.resumed:
        //stopLocationService();
        break;
      case AppLifecycleState.paused:
        //bgLocationTask();

        break;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // FlutterBackgroundService().sendData({"action": "setAsBackground"});

    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return StreamProvider<InternetConnectionStatus>(
          initialData: InternetConnectionStatus.connected,
          create: (_) {
            return InternetConnectionChecker().onStatusChange;
          },
          child: OverlaySupport.global(
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (ctx) => Auth(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => Preferences(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => LeaveProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => PrefProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => ProfileProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => AttendanceReportProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => DashboardProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => MoreScreenProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => MeetingProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => PaySlipProvider(),
                ),
              ],
              child: Portal(
                child: InAppNotification(
                  child: GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onVerticalDragDown: (details) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: GetMaterialApp(
                      navigatorKey: NavigationService.navigatorKey,
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        canvasColor: const Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'GoogleSans',
                        primarySwatch: Colors.blue,
                      ),
                      initialRoute: '/',
                      routes: {
                        '/': (_) => SplashScreen(),
                        LoginScreen.routeName: (_) => LoginScreen(),
                        DashboardScreen.routeName: (_) => DashboardScreen(),
                        ProfileScreen.routeName: (_) => ProfileScreen(),
                        EditProfileScreen.routeName: (_) => EditProfileScreen(),
                        MeetingDetailScreen.routeName: (_) =>
                            MeetingDetailScreen(),
                        PaySlipDetailScreen.routeName: (_) =>
                            PaySlipDetailScreen(),
                      },
                      builder: EasyLoading.init(),
                    ),
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
