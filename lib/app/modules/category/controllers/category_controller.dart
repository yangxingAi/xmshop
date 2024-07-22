import 'package:get/get.dart';
import '../../../models/category_model.dart';
import '../../../services/httpsClient.dart';

class CategoryController extends GetxController {
  RxInt selectIndex = 0.obs;
  RxList<CategoryItemModel> leftCategoryList = <CategoryItemModel>[].obs;
  RxList<CategoryItemModel> rightCategoryList = <CategoryItemModel>[].obs;
  HttpsClient httpsClient = HttpsClient();
  @override
  void onInit() {
    //测试：静态属性共享存储空间
    print("-------静态属性共享存储空间-------");

    print(identical(HttpsClient.domain, HttpsClient.domain));  //true

    HttpsClient httpsClient1 = HttpsClient();
    HttpsClient httpsClient2 = HttpsClient();
    print(identical(httpsClient1, httpsClient2));  //false

    super.onInit();
    getLeftCategoryData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeIndex(index, id) {   

    selectIndex.value = index;
    getRightCategoryData(id);
    update();
  }

  getLeftCategoryData() async {
    var response = await httpsClient.get("api/pcate");
    if (response != null) {
      var category = CategoryModel.fromJson(response.data);
      leftCategoryList.value = category.result!;
      getRightCategoryData(leftCategoryList[0].sId!);
      update();
    }
  }

  getRightCategoryData(String pid) async {
    var response = await httpsClient.get("api/pcate?pid=$pid");
    if (response != null) {
      var category = CategoryModel.fromJson(response.data);
      rightCategoryList.value = category.result!;
      update();
    }
  }
}
