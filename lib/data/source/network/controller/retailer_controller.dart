import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:bmiterp/api/apiConstant.dart';
import 'package:bmiterp/data/source/datastore/preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart'; // Add this import

class RetailerController extends GetxController {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  Rx<File?> imageFile = Rx<File?>(null);
  RxString currentAddress = RxString('');
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;

  Future<void> pickImage() async {
    addressController.clear();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      fetchCurrentAddress();
    }
  }

  Future<void> fetchCurrentAddress() async {
    try {
      Position position = await _getCurrentLocation();
      lat.value = position.latitude;
      long.value = position.longitude;
      String address = await _getAddressFromCoordinates(position);
      addressController.text = address;
    } catch (e) {
      currentAddress.value = 'Unable to fetch address';
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied';
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> _getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude ?? 0.0, position.longitude ?? 0.0);
      Placemark place = placemarks[0];
      return "${place.street}, ${place.subThoroughfare} ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country},  ${place.isoCountryCode} ,${place.name}, ${place.subAdministrativeArea} , ${place.thoroughfare}";
    } catch (e) {
      return "Address not found";
    }
  }

  // Future<XFile> _compressImage(File imageFile) async {
  //   final result = await FlutterImageCompress.compressAndGetFile(
  //     imageFile.path,
  //     imageFile.path,
  //     quality: 50, // Adjust the quality as per your requirement (0 - 100)
  //   );
  //   return result!;
  // }

  Future RegisterDistributor() async {
    var uri = Uri.parse(APIURL.CREATE_RETAILER);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    dynamic response;
    try {
      if (imageFile.value!.path != '') {
        // final compressedImage = await _compressImage(imageFile.value!);

        EasyLoading.show(
            status: "Created..", maskType: EasyLoadingMaskType.black);

        var request = http.MultipartRequest('POST', uri);
        Map<String, String> headers = {
          'Accept': 'application/json; charset=UTF-8',
          'user_token': '$token',
          'user_id': '$getUserID',
        };

        request.headers.addAll(headers);
        print(
            "check Date  ${imageFile.value!.path}, ${lat},  ${long}, ${contactController.text.trim()},  ${nameController.text.trim()}, ${addressController.text.trim()}");

        final file = await http.MultipartFile.fromPath(
            'retailer_shop_image', imageFile.value!.path);
        request.files.add(file);
        request.fields['retailer_latitude'] = lat.toString();
        request.fields['retailer_longitude'] = long.toString();
        request.fields['retailer_mobile_number'] =
            contactController.text.trim();
        request.fields['retailer_name'] = nameController.text.trim();
        request.fields['retailer_data'] = addressController.text.trim();

        try {
          final streamedResponse = await request.send();
          final response = await http.Response.fromStream(streamedResponse);
          print("kdjfhggf  ${response.statusCode}");

          var out = jsonDecode(response.body);
          print("check profile update ${out}");

          if (response.statusCode == 201) {

            Fluttertoast.showToast(
                msg: "Retailer  created successfully !",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
            nameController.clear();
            contactController.clear();
            addressController.clear();
            imageFile.value = null;
            lat.close();
            long.close();
            
            Get.back();
            EasyLoading.dismiss(animation: true);
          } else {
            EasyLoading.dismiss(animation: true);

            Fluttertoast.showToast(
                msg: "${out['message']}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          }
        } catch (e) {
          EasyLoading.dismiss(animation: true);
          Fluttertoast.showToast(
              msg: "Something went wrong! Please try again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          print(e);
        }

        return Future.error('error');
      } else {
        EasyLoading.dismiss(animation: true);
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    addressController.dispose();
    imageFile.close();
    lat.close();
    long.close();

    super.dispose();
  }
}
