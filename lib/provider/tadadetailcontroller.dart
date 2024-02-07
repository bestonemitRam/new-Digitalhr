import 'package:cnattendance/model/attachment.dart';
import 'package:cnattendance/model/tada.dart';
import 'package:cnattendance/repositories/tadarepository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class TadaDetailController extends GetxController {
  var tada = Tada(0, "", "", "", "", "", "", "", []).obs;
  var isLoading = false.obs;
  TadaRepository repository = TadaRepository();

  Future<String> getTadaDetail() async {
    try {
      isLoading.value = true;
      EasyLoading.show(
          status: 'Loading, Please Wait...',
          maskType: EasyLoadingMaskType.black);
      print("hgkjfjkg  ${Get.arguments["tadaId"].toString()}");

      final response =
          await repository.getTadaDetail(Get.arguments["tadaId"].toString());

      EasyLoading.dismiss(animation: true);

      final data = response.data;

      final attachmentList = <Attachment>[];
      int count = 0;
      if (data != null && data.attachments != null)
        for (var attachment in data!.attachments!) {
          print('dfgkjdfhgj  ${attachment.pathLink!}');
          attachmentList.add(Attachment(count, attachment.pathLink!, "image"));
          count = count + 1;
        }
      // for (var attachment in data.attachments.file) {
      //   attachmentList.add(Attachment(attachment.id, attachment.url, "file"));
      // }

      Tada rTada = Tada(
          data!.id!,
          data.title!,
          data.description,
          data.totalExpense!,
          data.status!,
          data.statusChangedBy != null ? data.statusChangedBy : '',
          data.statusTitle!,
          data.createdDate!,
          attachmentList);
      tada.value = rTada;

      isLoading.value = false;
      return "Loaded";
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  void onInit() {
    getTadaDetail();
    super.onInit();
  }
}
