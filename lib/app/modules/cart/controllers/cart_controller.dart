import 'package:get/get.dart';
import 'package:xmshop/app/services/storage.dart';
import '../../../services/cartServices.dart';
import '../../../services/userServices.dart';

class CartController extends GetxController {
  //TODO: Implement CartController
  RxList cartList = [].obs;
  RxBool checkedAllBox = false.obs;
  RxBool isEdit = false.obs;
  RxDouble allPrice=0.0.obs;
  @override
  void onInit() {
    print("cart init");

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getCartListData() async {
    var tempList = await CartServices.getCartList();
    cartList.value = tempList;
    checkedAllBox.value = isCheckedAll();
    //计算总价
    computedAllPrice();
    update();
  }

  //增加数量
  void incCartNum(cartItem) {
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["_id"] == cartItem["_id"] &&
          cartList[i]["selectedAttr"] == cartItem["selectedAttr"]) {
        cartList[i]["count"]++;
      }
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    CartServices.setCartList(tempList);
     //计算总价
    computedAllPrice();
    update();
  }

  // 减少数量
  void decCartNum(cartItem) {
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["_id"] == cartItem["_id"] &&
          cartList[i]["selectedAttr"] == cartItem["selectedAttr"]) {
        if (cartList[i]["count"] > 1) {
          cartList[i]["count"]--;
        } else {
          Get.snackbar('提示！', "购物车数量已经到最小了");
        }
      }
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    CartServices.setCartList(tempList);
     //计算总价
    computedAllPrice();
    update();
  }

  //选中item
  void checkCartItem(cartItem) {
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["_id"] == cartItem["_id"] &&
          cartList[i]["selectedAttr"] == cartItem["selectedAttr"]) {
        cartList[i]["checked"] = !cartList[i]["checked"];
      }
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    CartServices.setCartList(tempList);
    checkedAllBox.value = isCheckedAll();
     //计算总价
    computedAllPrice();
    update();
  }

  //全选 反选
  void checkedAllFunc(value) {
    checkedAllBox.value = value;
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      cartList[i]["checked"] = value;
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    CartServices.setCartList(tempList);
    //计算总价
    computedAllPrice();
    update();
  }

  //判断是否全选
  bool isCheckedAll() {
    if (cartList.isNotEmpty) {
      for (var i = 0; i < cartList.length; i++) {
        if (cartList[i]["checked"] == false) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  //获取要结算的商品
  getCheckListData() {
    List tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["checked"] == true) {
        tempList.add(cartList[i]);
      }
    }
    return tempList;
  }

  //判断用户有没有登录
  Future<bool> isLogin() async {
    return await UserServices.getUserLoginState();
  }

  checkout() async {
    bool loginState = await isLogin();
    List checkListData = getCheckListData();
    if (loginState) {
      //判断购物车里面有没有要结算的商品
      if (checkListData.isNotEmpty) {
        //保存要结算的商品
        Storage.setData("checkoutList", checkListData);
        Get.toNamed("/checkout");
      } else {
        Get.snackbar("提示信息!", "购物车中没有要结算的商品");
      }
    } else {
      //执行跳转
      Get.toNamed("/code-login-step-one");
      Get.snackbar("提示信息!", "您还有没有登录，请先登录");
    }
  }
  //改变edit属性
  changeEditState(){
    isEdit.value=!isEdit.value;
    update();
  }
  //删除购物车数据

  deleteCartData(){
    List tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["checked"] == false) {
        tempList.add(cartList[i]);
      }
    }    
    //把没有选中的商品保存在cart里面
    cartList.value = tempList;
    CartServices.setCartList(tempList);
    update();

  }
  //计算总价
  computedAllPrice(){
    double tempAllPrice=0.0;
     for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["checked"] == true) {
        tempAllPrice+=cartList[i]["price"]*cartList[i]["count"];
      }
    }
    allPrice.value=tempAllPrice;    
  }

}
