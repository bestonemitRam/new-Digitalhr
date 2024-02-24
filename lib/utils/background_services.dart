// import 'dart:async';

// import 'package:background_location/background_location.dart';
// import 'package:bmiterp/provider/dashboardprovider.dart';

// class BackgroundServicecss
// {

  
// Future<void> bgLocationTask() async 
// {
//   initBackgroundLocation();
//   print("dkjfhgkjfgkjgkjdhgf    ");
//   try {
//     final backgroundApiViewModel = DashboardProvider();
   
//     Timer.periodic(Duration(seconds: 5), (Timer t) async 
//     {
      
//       print("Calling getCurrentPosition within Timer");
     
//        //backgroundApiViewModel.getCurrentPosition();
//     });
//   } catch (err,stackTrace) {
//     print("This is the error: $err");
//     print("Stacktrace : ${stackTrace}");
//     throw Exception(err.toString());
//   }
// }
// void stopLocationService() {
//     BackgroundLocation.stopLocationService();
//   }


// void initBackgroundLocation() 
// {

//  BackgroundLocation.startLocationService();
//   BackgroundLocation.getLocationUpdates((location) 
//   {
//     print("Location: ${location.latitude}, ${location.longitude}");
   
//   });
// }

// }