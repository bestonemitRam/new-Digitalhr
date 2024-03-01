import 'dart:convert';
import 'dart:io';

import 'package:bmiterp/api/apiConstant.dart';
import 'package:bmiterp/api/app_strings.dart';
import 'package:bmiterp/data/source/datastore/preferences.dart';
import 'package:bmiterp/data/source/network/controller/distributor_controller.dart';
import 'package:bmiterp/model/distributor_state_model.dart';
import 'package:bmiterp/model/district_model.dart';
import 'package:bmiterp/model/leave.dart';
import 'package:bmiterp/provider/leaveprovider.dart';
import 'package:bmiterp/provider/shopprovider.dart';
import 'package:bmiterp/utils/constant.dart';
import 'package:bmiterp/utils/navigationservice.dart';
import 'package:bmiterp/widget/buttonborder.dart';
import 'package:bmiterp/widget/customalertdialog.dart';
import 'package:bmiterp/widget/radialDecoration.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateDistributorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateDistributorScreenState();
}

class CreateDistributorScreenState extends State<CreateDistributorScreen> {
  final _nameController = TextEditingController();
  final _orgController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _pancardController = TextEditingController();
  final _adharCardController = TextEditingController();
  final _gstNumberController = TextEditingController();

  final _form = GlobalKey<FormState>();

  bool validateField(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  late DisStateModel disStateModel;

  DistrictModel? districtModel;
  bool datafoundList = false;
  bool districtdatafoundList = false;

  getStateList() async {
    print("check get all state list data ");
    var uri = Uri.parse(APIURL.DISTRIBUTOR_STATE_LIST);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    final response = await http.get(uri, headers: headers);
    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      print("lkdfjhgkjfgkj ${responseData}");
      setState(() {
        datafoundList = true;
      });
      disStateModel = DisStateModel.fromJson(responseData);
    } else {
      setState(() {
        datafoundList = true;
      });
      disStateModel = DisStateModel.fromJson(responseData);
    }
  }

  getCityList(int state_Id) async {
    var uri = Uri.parse(APIURL.DISTRIBUTOR_DISTRICT_LIST + "${state_Id}");
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    final response = await http.get(uri, headers: headers);
    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        districtdatafoundList = true;
      });
      districtModel = DistrictModel.fromJson(responseData);
    } else {
      setState(() {
        districtdatafoundList = true;
      });
      districtModel = DistrictModel.fromJson(responseData);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getStateList();
    super.initState();
  }

  StateDataList? stateDataList;
  DistrictData? districtData;

  Future RegisterDistributor() async {
    var uri = Uri.parse(APIURL.CREATE_DISTRIBUTOR);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    EasyLoading.show(status: "Created..", maskType: EasyLoadingMaskType.black);

    print(
        "kjdfhgjh ${uri}  ${imagefiles!.path}  ${stateDataList!.id.toString()}");

    dynamic response;
    try {
      if (imagefiles!.path != '') {
        var request = http.MultipartRequest('POST', uri);
        Map<String, String> headers = {
          'Accept': 'application/json; charset=UTF-8',
          'user_token': '$token',
          'user_id': '$getUserID',
        };

        request.headers.addAll(headers);

        final file = await http.MultipartFile.fromPath(
            'distributor_avatar', imagefiles!.path);

        request.files.add(file);
        request.fields['state_id'] = stateDataList!.id.toString();
        request.fields['district_id'] = districtData!.id.toString();
        request.fields['d_latitude'] = "30.345";
        request.fields['d_longitude'] = "43.456";
        request.fields['distributor_org_name'] = _orgController.text.trim();
        request.fields['full_name'] = _nameController.text.trim();
        request.fields['mail'] = _emailController.text.trim();
        request.fields['contact'] = _contactController.text.trim();
        request.fields['address'] = _addressController.text.trim();
        request.fields['pancard'] = _pancardController.text.trim();
        request.fields['aadharcard'] = _addressController.text.trim();
        request.fields['gst_no'] = _gstNumberController.text.trim();

        try {
          final streamedResponse = await request.send();
          final response = await http.Response.fromStream(streamedResponse);
          print("kdjfhggf  ${response.statusCode}");

          var out = jsonDecode(response.body);
          print("check profile update ${out}");

          if (response.statusCode == 200) {
            Fluttertoast.showToast(
                msg: "Distributor Created Successfully !",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
            setState(() {
              EasyLoading.dismiss(animation: true);
            });
            Get.back();
            final leaveData = Provider.of<ShopProvider>(context, listen: true);
            final distributor = leaveData.distributor;
            Get.back();

            //   ScaffoldMessenger.of(context)
            //       .showSnackBar(SnackBar(content: Text(response.message)));
          } else {
            setState(() {
              EasyLoading.dismiss(animation: true);
            });

            Fluttertoast.showToast(
                msg: "Error !",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          }
        } catch (e) {
          print(e);
        }

        return Future.error('error');
      } else {}
    } catch (error) {
      throw error;
    }
  }

  final ImagePicker imgpicker = ImagePicker();
  XFile? imagefiles;

  openImages() async {
    try {
      final XFile? image =
          await imgpicker.pickImage(source: ImageSource.camera);

      if (image != null) {
        imagefiles = image;
        setState(() {});
      } else {
        print("Error");
        // DialogHelper.showFlutterToast(strMsg: Languages.of(context)!.imageNotSelected);
      }
    } catch (e) {
      // DialogHelper.showFlutterToast(strMsg: 'Error while picking file');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: RadialDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Create Distributor',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.white,
                      )),
                ],
              ),
              Center(
                child: CircleAvatar(
                  radius: 7.5.h,
                  backgroundImage: imagefiles != null
                      ? FileImage(File(imagefiles!.path))
                      : Apphelper.USER_AVATAR != null
                          ? NetworkImage(Apphelper.USER_AVATAR.toString())
                          : AssetImage('assets/images/dummy_avatar.png')
                              as ImageProvider,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        openImages();
                      },
                      child: CircleAvatar(
                        radius: 2.h,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        datafoundList
                            ? Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: DropdownButton<StateDataList>(
                                    isExpanded: true,
                                    hint: Row(
                                      children: const [
                                        Expanded(
                                          child: Text(
                                            'Select State',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white70,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    value: stateDataList,
                                    style: TextStyle(color: Colors.black),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                    onChanged: (StateDataList? selectedItem) {
                                      setState(() {
                                        getCityList(selectedItem!.id!);
                                        print(selectedItem?.stateName);
                                        stateDataList = selectedItem;
                                      });
                                    },
                                    underline: SizedBox(),
                                    items: disStateModel.result!
                                        .map((StateDataList item) {
                                      return DropdownMenuItem<StateDataList>(
                                        value: item,
                                        child: Text(item.stateName!,
                                            style:
                                                TextStyle(color: Colors.black)),
                                      );
                                    }).toList(),
                                    selectedItemBuilder:
                                        (BuildContext context) {
                                      return disStateModel.result!
                                          .map<Widget>((StateDataList item) {
                                        return Text(
                                          item.stateName!,
                                          style: TextStyle(
                                              color: Colors
                                                  .white), // Change selected item color here
                                        );
                                      }).toList();
                                    },
                                  ),
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                        districtdatafoundList
                            ? SizedBox(
                                height: 10,
                              )
                            : SizedBox(),
                        districtdatafoundList
                            ? districtModel!.resultData!.isNotEmpty
                                ? Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: DropdownButton<DistrictData>(
                                        isExpanded: true,
                                        hint: Row(
                                          children: const [
                                            Expanded(
                                              child: Text(
                                                'Select Districts',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        value: districtData,
                                        style: TextStyle(color: Colors.black),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                        ),
                                        onChanged:
                                            (DistrictData? selectedItem) {
                                          setState(() {
                                            print(
                                                'kjdfhgjkhdf  ${selectedItem?.districtName}');
                                            districtData = selectedItem;
                                          });
                                        },
                                        underline: SizedBox(),
                                        items: districtModel!.resultData!
                                            .map((DistrictData item) {
                                          return DropdownMenuItem<DistrictData>(
                                            value: item,
                                            child: Text(item.districtName!,
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          );
                                        }).toList(),
                                        selectedItemBuilder:
                                            (BuildContext context) {
                                          return districtModel!.resultData!
                                              .map<Widget>((DistrictData item) {
                                            return Text(
                                              item.districtName!,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ),
                                  )
                                : Center()
                            : Center(),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _orgController,
                          keyboardType: TextInputType.text,
                          //maxLength: 11,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (!validateField(value!)) {
                              return "Empty Field";
                            }

                            return null;
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: ' Organization Name',
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.on_device_training_outlined,
                                color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white24,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (!validateField(value!)) {
                              return "Empty Field";
                            }

                            return null;
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.person, color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white24,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an email';
                            }

                            bool emailValid =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value);
                            if (!emailValid) {
                              return 'Please enter a valid email';
                            }
                            return null; // Return null if the input is valid
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.email, color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white24,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _contactController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          // maxLength: 11,
                          validator: (value) {
                            if (!validateField(value!)) {
                              return "Empty Field";
                            }

                            return null;
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Phone No.',
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.phone, color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white24,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _addressController,
                          keyboardType: TextInputType.streetAddress,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (!validateField(value!)) {
                              return "Empty Field";
                            }

                            return null;
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Current Address',
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon:
                                Icon(Icons.location_on, color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white24,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _pancardController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (!validateField(value!)) {
                              return "Empty Field";
                            }

                            return null;
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Pan card Number',
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon:
                                Icon(Icons.description, color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white24,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _adharCardController,
                          keyboardType: TextInputType.streetAddress,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (!validateField(value!)) {
                              return "Empty Field";
                            }

                            return null;
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Aadhar card Number',
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.money, color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white24,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _gstNumberController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (!validateField(value!)) {
                              return "Empty Field";
                            }

                            return null;
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'GST Number',
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.money, color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white24,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(10))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              gaps(10),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 5),
                child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: HexColor("#036eb7"),
                      padding: EdgeInsets.zero,
                      shape: ButtonBorder(),
                    ),
                    onPressed: () {
                      if (_form.currentState!.validate()) {
                        RegisterDistributor();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget gaps(double value) {
    return SizedBox(
      height: value,
    );
  }
}
