import 'package:get/get.dart';
import '../../../services/searchServices.dart';
import '../../../services/storage.dart';

class SearchControllerS extends GetxController {
  String keywords = "";
  RxList historyList = [].obs;
  @override
  void onInit() {
    super.onInit();
    getHistoryData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getHistoryData() async {
    var tempList = await SearchServices.getHistoryData();
    if (tempList.isNotEmpty) {
      historyList.addAll(tempList);
      update();
    }
  }

  clearHistoryData() async {
    await SearchServices.clearHistoryData();
    historyList.clear();
    update();
  }

  removeHistoryData(keywords) async {
    var tempList = await SearchServices.getHistoryData();
    if (tempList.isNotEmpty) {
      tempList.remove(keywords);
      await Storage.setData("searchList", tempList);
      //注意
      historyList.remove(keywords);
      update();
    }
  }
}
