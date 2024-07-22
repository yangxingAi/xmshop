import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../models/message.dart';
import '../../../../services/httpsClient.dart';
import '../../../../services/storage.dart';
import '../../../user/controllers/user_controller.dart';
class PassLoginController extends GetxController {
 TextEditingController telController=TextEditingController();
 TextEditingController passController=TextEditingController();
   UserController userController =Get.find<UserController>();
  HttpsClient httpsClient = HttpsClient();  
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    //状态管理 更新userController.getUserInfo
    userController.getUserInfo();
    super.onClose();
  }

 Future<MessageModel> doLogin() async{
    var response = await httpsClient.post("api/doLogin",data:{
        "username":telController.text,
        "password":passController.text,
      });
      if (response != null) {
         print(response);
         if(response.data["success"]){
          //保存用户信息
           Storage.setData("userinfo",response.data["userinfo"]);         
          return MessageModel(message: "登录成功", success: true);
         }
        return MessageModel(message: response.data["message"], success: false);
      }else{
        return MessageModel(message:"网络异常", success: false);
      }
  }

}
