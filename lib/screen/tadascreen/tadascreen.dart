import 'package:cnattendance/model/tada.dart';
import 'package:cnattendance/provider/tadalistcontroller.dart';
import 'package:cnattendance/screen/tadascreen/edittadascreen.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TadaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Get.put(TadaListController());

    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "TADA",
            style: TextStyle(color: Colors.white),
          ),
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () {
              Get.back();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.onTadaCreateClicked();
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue),
        body: Obx(
          () => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: RefreshIndicator(
                onRefresh: () {
                  return model.getTadaList();
                },
                child: ListView.builder(
                  itemCount: model.tadaList.length,
                  itemBuilder: (context, index) {
                    Tada item = model.tadaList[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(10))),
                        tileColor: Colors.white12,
                        onTap: () {
                          model.onTadaClicked(item.id.toString());
                        },
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        title: Text(
                          item.title,
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            item.submittedDate!.isNotEmpty
                                ? Text(
                                    item.submittedDate ?? "",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                : SizedBox(),
                            Text(
                              item.expenses ?? "",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            if (item.status == "Accepted") {
                              showToast("Accepted TADA can't be edited");
                            } else {
                              model.onTadaEditClicked(item.id.toString());
                            }
                          },
                          child: item.status == "Pending"
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.edit),
                                )
                              : SizedBox(),
                        ),
                        leading: Card(
                            color: item.status == "Pending"
                                ? Colors.orange
                                : item.status == "Rejected"
                                    ? Colors.red
                                    : Colors.green,
                            shape: CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                item.status == "Pending"
                                    ? "P"
                                    : item.status == "Rejected"
                                        ? "R"
                                        : "A",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}