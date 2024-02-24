import 'package:bmiterp/model/leave.dart';
import 'package:bmiterp/provider/leaveprovider.dart';
import 'package:bmiterp/utils/navigationservice.dart';
import 'package:bmiterp/widget/buttonborder.dart';
import 'package:bmiterp/widget/customalertdialog.dart';
import 'package:bmiterp/widget/radialDecoration.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateDistributorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateDistributorScreenState();
}

class CreateDistributorScreenState extends State<CreateDistributorScreen> {
  Leave? selectedValue;

  bool isLoading = false;

  final _nameController = TextEditingController();
  final _ownerController = TextEditingController();
  final _addressController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool validateField(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  // void issueLeave() async {
  //   if (endDate.text.isNotEmpty &&
  //       startDate.text.isNotEmpty &&
  //       reason.text.isNotEmpty &&
  //       selectedValue != null) {
  //     try {
  //       showLoader();
  //       isLoading = true;
  //       final response = await Provider.of<LeaveProvider>(context, listen: false).issueLeave(
  //               startDate.text, endDate.text, reason.text, selectedValue!.id);

  //       if (!mounted)
  //       {
  //         return;
  //       }
  //       dismissLoader();
  //       Navigator.of(context).pop();
  //       Navigator.pop(context);
  //       isLoading = false;
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return Dialog(
  //             child: CustomAlertDialog(response.message),
  //           );
  //         },
  //       );
  //     } catch (e) {
  //       dismissLoader();
  //       isLoading = false;
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return Dialog(
  //             child: CustomAlertDialog(e.toString()),
  //           );
  //         },
  //       );
  //     }
  //   } else {
  //     NavigationService()
  //         .showSnackBar("Leave Status", "Field must not be empty");
  //   }
  // }

  // void dismissLoader() {
  //   setState(() {
  //     EasyLoading.dismiss(animation: true);
  //   });
  // }

  // void showLoader() {
  //   setState(() {
  //     EasyLoading.show(
  //         status: "Requesting...", maskType: EasyLoadingMaskType.black);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LeaveProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: SingleChildScrollView(
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
                Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
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
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.white),
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
                            controller: _ownerController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (!validateField(value!)) {
                                return "Empty Field";
                              }

                              return null;
                            },
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.white70),
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.white),
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
                              prefixIcon:
                                  Icon(Icons.phone, color: Colors.white),
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
                            keyboardType: TextInputType.number,
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
                              hintText: ' Alternative Phone No.',
                              hintStyle: TextStyle(color: Colors.white70),
                              prefixIcon:
                                  Icon(Icons.phone, color: Colors.white),
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
                              hintText: 'Distributor Description',
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
                              hintText: 'Distributor Fund Amount ',
                              hintStyle: TextStyle(color: Colors.white70),
                              prefixIcon:
                                  Icon(Icons.money, color: Colors.white),
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
                gaps(20),
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
                        // issueLeave();
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
      ),
    );
  }

  Widget gaps(double value) {
    return SizedBox(
      height: value,
    );
  }
}
