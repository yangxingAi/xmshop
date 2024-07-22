import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/screenAdapter.dart';
import '../controllers/cart_controller.dart';
import "cart_item_view.dart";

//注意CartView在多个地方调用了  需要手动获取CartController
class CartView extends GetView {
  @override
  final CartController controller = Get.put(CartController());
  CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('购物车'),
          centerTitle: true,
          actions: [
            Obx(() => controller.isEdit.value
                ? TextButton(onPressed: () {
                  controller.changeEditState();
                }, child: const Text("完成"))
                : TextButton(onPressed: () {
                   controller.changeEditState();
                }, child: const Text("编辑")))
          ],
        ),
        body: GetBuilder<CartController>(
            initState: (state) {
              //获取购物车数据
              controller.getCartListData();
            },
            init: controller,
            builder: (controller) {
              return controller.cartList.isNotEmpty
                  ? Stack(
                      children: [
                        ListView(
                            padding: EdgeInsets.only(
                                bottom: ScreenAdapter.height(200)),
                            children: controller.cartList.map((value) {
                              return CartItemView(value);
                            }).toList()),
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.only(
                                  right: ScreenAdapter.width(20)),
                              width: ScreenAdapter.width(1080),
                              height: ScreenAdapter.height(190),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: const Color.fromARGB(
                                              178, 240, 236, 236),
                                          width: ScreenAdapter.height(2))),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Obx(() => Checkbox(
                                          activeColor: Colors.red,
                                          value: controller.checkedAllBox.value,
                                          onChanged: (value) {
                                            print(value);
                                            controller.checkedAllFunc(value);
                                          })),
                                      const Text("全选")
                                    ],
                                  ),
                                  Obx(()=>controller.isEdit.value?Row(
                                    children: [
                                    
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      const Color.fromRGBO(251, 72, 5, 0.9)),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              shape: MaterialStateProperty.all(
                                                  // CircleBorder()
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)))),
                                          onPressed: () {                                           
                                            controller.deleteCartData();
                                          },
                                          child: const Text("删除"))
                                    ],
                                  ):Row(
                                    children: [
                                      Text("合计: "),
                                     Obx(()=> Text("¥${controller.allPrice.value}",
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenAdapter.fontSize(58),
                                              color: Colors.red))),
                                      SizedBox(width: ScreenAdapter.width(20)),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                         const Color.fromRGBO(251, 72, 5, 0.9)),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              shape: MaterialStateProperty.all(
                                                  // CircleBorder()
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)))),
                                          onPressed: () {
                                            //判断用户有没有登录
                                            controller.checkout();
                                          },
                                          child: const Text("结算"))
                                    ],
                                  ))
                                ],
                              ),
                            ))
                      ],
                    )
                  : const Center(
                      child: Text("购物车空空的"),
                    );
            }));
  }
}
