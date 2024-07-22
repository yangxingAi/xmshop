class ShopModel {
  String? sId;
  String? title;
  int? status;
  String? pic;
  String? url;

  ShopModel.fromJson(Map<String, dynamic> mapJson) {
    sId = mapJson["_id"];
    title = mapJson["title"];
    status = mapJson["status"];
    pic = mapJson["pic"];
    url = mapJson["url"];
  }
}
