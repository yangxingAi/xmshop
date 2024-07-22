import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/httpsClient.dart';

import '../controllers/category_controller.dart';

import '../../../services/screenAdapter.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);

  Widget _leftCate() {
    return SizedBox(
      width: ScreenAdapter.width(280),
      height: double.infinity,
      child: Obx(() => ListView.builder(
          itemCount: controller.leftCategoryList.length,
          itemBuilder: ((context, index) {
            return SizedBox(
              width: double.infinity,
              height: ScreenAdapter.height(180),
              child: InkWell(
                onTap: () {
                  controller.changeIndex(
                      index, controller.leftCategoryList[index].sId);
                },
                child: Obx(() => Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: ScreenAdapter.width(10),
                            height: ScreenAdapter.height(46),
                            color: controller.selectIndex.value == index
                                ? Colors.red
                                : Colors.white,
                          ),
                        ),
                        Center(
                          child: Text(
                            "${controller.leftCategoryList[index].title}",
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(36),
                                fontWeight:
                                    controller.selectIndex.value == index
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                          ),
                        )
                      ],
                    )),
              ),
            );
          }))),
    );
  }

  Widget _rightCate() {
    return Expanded(
        child: Container(
      color: Colors.white,
      height: double.infinity,
      child: Obx(() => GridView.builder(
          itemCount: controller.rightCategoryList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: ScreenAdapter.width(40),
              mainAxisSpacing: ScreenAdapter.height(20),
              childAspectRatio: 240 / 340),
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: () {
                Get.toNamed("/product-list", arguments: {
                  "cid": controller.rightCategoryList[index].sId
                });
              },
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Image.network(
                        HttpsClient.replaeUri(
                            controller.rightCategoryList[index].pic),
                        fit: BoxFit.fitHeight),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(0, ScreenAdapter.height(10), 0, 0),
                    child: Text("${controller.rightCategoryList[index].title}",
                        style: TextStyle(fontSize: ScreenAdapter.fontSize(34))),
                  )
                ],
              ),
            );
          }))),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Container(
            width: ScreenAdapter.width(840),
            height: ScreenAdapter.height(96),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(246, 246, 246, 1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      ScreenAdapter.width(34), 0, ScreenAdapter.width(10), 0),
                  child: const Icon(Icons.search,color: Colors.black54),
                ),
                Text("手机",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: ScreenAdapter.fontSize(32)))
              ],
            ),
          ),
          onTap: () {
            Get.toNamed("/search");
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.message_outlined, color: Colors.black45))
        ],
        elevation: 0,
      ),
      body: Row(
        children: [_leftCate(), _rightCate()],
      ),
    );
  }
}
