import 'package:bmiterp/model/member.dart';
import 'package:bmiterp/screen/projectscreen/commentscreen/commentscreencontroller.dart';
import 'package:bmiterp/screen/projectscreen/commentscreen/widget/commentlist.dart';
import 'package:bmiterp/screen/projectscreen/commentscreen/widget/mentionbottomsheet.dart';
import 'package:bmiterp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';

class CommentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<TextFieldAutoCompleteState<String>> _textFieldAutoCompleteKey =
        new GlobalKey();
    final model = Get.put(CommentScreenController());
    List<Member> value = Get.arguments['members'];
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("Comments"),
        ),
        body: GestureDetector(
          onVerticalDragDown: (details) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 10,
                    right: 10,
                    bottom: 90,
                    child: Column(
                      children: [
                        Expanded(child: CommentList()),
                        GestureDetector(
                          onTap: () {
                            model.getComments();
                          },
                          child: Obx(
                            () => model.commentList.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Load More Comments",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ),
                        )
                      ],
                    )),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 90,
                    child: Divider(
                      color: Colors.white54,
                      endIndent: 10,
                      indent: 10,
                    )),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: RadialDecoration(),
                      height: 100,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: model.mentionList.length,
                                        itemBuilder: (context, index) {
                                          final member =
                                              model.mentionList[index];
                                          return Card(
                                            color: Colors.white54,
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      member.name,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        model.removeMember(
                                                            member);
                                                      },
                                                      child: Icon(
                                                        Icons.close,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.bottomSheet(MentionBottomSheet(value),
                                          isDismissible: true,
                                          enableDrag: true,
                                          isScrollControlled: false,
                                          ignoreSafeArea: true);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Obx(
                                    () => Image.network(
                                      model.user.value.avatar,
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Expanded(
                                  child: TextFormField(
                                focusNode: model.focusNode,
                                autofocus: false,
                                controller: model.commentController,
                                maxLines: 1,
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                                validator: (value) {
                                  return null;
                                },
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                    hintText: "Write your Comment",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    labelStyle: TextStyle(color: Colors.white),
                                    filled: true,
                                    fillColor: Colors.transparent),
                              )),
                              GestureDetector(
                                onTap: () {
                                  model.saveComments();
                                },
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
