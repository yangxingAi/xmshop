import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../services/screenAdapter.dart';
import '../../../services/httpsClient.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  Widget _checkoutItem(value) {
    return Container(
      padding: EdgeInsets.only(
          top: ScreenAdapter.height(20),
          bottom: ScreenAdapter.height(20),
          right: ScreenAdapter.height(20)),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: ScreenAdapter.width(200),
            height: ScreenAdapter.width(200),
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            child: Image.network(HttpsClient.replaeUri(value["pic"]),
                fit: BoxFit.fitHeight),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${value["title"]}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: ScreenAdapter.height(10)),
              Text(
                "${value["selectedAttr"]}",
              ),
              SizedBox(height: ScreenAdapter.height(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("￥${value["price"]}",
                      style: TextStyle(color: Colors.red)),
                  Text("x${value["count"]}",
                      style: TextStyle(color: Colors.black87))
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _body() {
    return ListView(
      padding: EdgeInsets.all(ScreenAdapter.width(40)),
      children: [
        Obx(() => controller.addressList.isEmpty
            ? Container(
                padding: EdgeInsets.only(
                    top: ScreenAdapter.height(20),
                    bottom: ScreenAdapter.height(20)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.width(20))),
                child: ListTile(
                  onTap: () {
                    Get.toNamed("/address-add");
                  },
                  leading: const Icon(Icons.add_location),
                  title: const Text("新建收货地址"),
                  trailing: const Icon(Icons.navigate_next),
                ),
              )
            : Container(
                padding: EdgeInsets.only(
                    top: ScreenAdapter.height(20),
                    bottom: ScreenAdapter.height(20)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.width(20))),
                child: ListTile(
                  onTap: () {
                    Get.toNamed("/address-list");
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${controller.addressList[0].name} ${controller.addressList[0].phone}"),
                      SizedBox(
                        height: ScreenAdapter.height(10),
                      ),
                      Text("${controller.addressList[0].address}"),
                    ],
                  ),
                  trailing: Icon(Icons.navigate_next),
                ),
              )),
        SizedBox(
          height: ScreenAdapter.height(40),
        ),
        Container(
          padding: EdgeInsets.only(
              top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(20))),
          child: Obx(() => controller.checkoutList.isNotEmpty
              ? Column(
                  children: controller.checkoutList.map((value) {
                  return _checkoutItem(value);
                }).toList())
              : Text("")),
        ),
        SizedBox(
          height: ScreenAdapter.height(40),
        ),
        Container(
          padding: EdgeInsets.only(
              top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(20))),
          child: Column(
            children: [
              ListTile(
                  title: const Text("运费"),
                  trailing: Wrap(
                    children: [Text("包邮")],
                  )),
              ListTile(
                title: const Text("优惠券"),
                trailing: Wrap(
                  children: const [Text("无可用"), Icon(Icons.navigate_next)],
                ),
              ),
              ListTile(
                title: const Text("卡券"),
                trailing: Wrap(
                  children: const [Text("无可用"), Icon(Icons.navigate_next)],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: ScreenAdapter.height(40),
        ),
        Container(
          padding: EdgeInsets.only(
              top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(20))),
          child: const ListTile(
            title: Text("发票"),
            trailing: Icon(Icons.navigate_next),
          ),
        ),
      ],
    );
  }

  Widget _bottom() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          padding: EdgeInsets.only(right: ScreenAdapter.width(20)),
          width: ScreenAdapter.width(1080),
          height: ScreenAdapter.height(190),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: const Color.fromARGB(178, 240, 236, 236),
                      width: ScreenAdapter.height(2))),
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: ScreenAdapter.width(20)),
                  Obx(() => Text("共${controller.allNum.value}件,合计:")),
                  Obx(() => Text("${controller.allPrice.value}",
                      style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(58),
                          color: Colors.red))),
                  SizedBox(width: ScreenAdapter.width(20)),
                ],
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(251, 72, 5, 0.9)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                          // CircleBorder()
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    controller.doCheckOut();
                  },
                  child: const Text("去付款"))
            ],
          ),
        ));
  }

  const CheckoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('确认订单'),
        centerTitle: true,
      ),
      body: Stack(
        children: [_body(), _bottom()],
      ),
    );
  }
}
