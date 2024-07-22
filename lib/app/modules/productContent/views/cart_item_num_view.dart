import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../services/screenAdapter.dart';
import '../controllers/product_content_controller.dart';

class CartItemNumView extends GetView {
  @override
  final ProductContentController controller = Get.find();
  CartItemNumView({Key? key}) : super(key: key);

  Widget _left() {
    return InkWell(
      onTap: () {
        controller.decBuyNum();
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(80),
        height: ScreenAdapter.height(80),
        child: const Text("-"),
      ),
    );
  }

  Widget _center() {
    return Obx(()=>Container(
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(width: ScreenAdapter.width(2), color: Colors.black12),
        right: BorderSide(width: ScreenAdapter.width(2), color: Colors.black12),
      )),
      alignment: Alignment.center,
      width: ScreenAdapter.width(80),
      height: ScreenAdapter.height(80),
      child: Text("${controller.buyNum.value}"),
    ));
  }

  Widget _right() {
    return InkWell(
      onTap: (){
        controller.incBuyNum();
      },
      child: Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(80),
      height: ScreenAdapter.height(80),
      child: const Text("+"),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(244),
      height: ScreenAdapter.height(80),
      decoration: BoxDecoration(
          border:
              Border.all(width: ScreenAdapter.width(2), color: Colors.black12)),
      child: Row(
        children: [_left(), _center(), _right()],
      ),
    );
  }
}
