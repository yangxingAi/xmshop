import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart';
import '../../../services/screenAdapter.dart';
import '../../../services/searchServices.dart';

class SearchView extends GetView<SearchControllerS> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        title: Container(
          width: ScreenAdapter.width(840),
          height: ScreenAdapter.height(96),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            autofocus: true,
            style: TextStyle(
                //修改框框的字体
                fontSize: ScreenAdapter.fontSize(36)),
            decoration: InputDecoration(
                //配置padding值
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none)),
            onChanged: (value) {
              controller.keywords = value;
            },
            //监听键盘的回车事件
            onSubmitted: (value) {
              //保存搜索记录
              SearchServices.setHistoryData(value);
              //替换路由
              Get.offAndToNamed("/product-list",
                  arguments: {"keywords": value});
            },
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () {
                //保存搜索记录
                SearchServices.setHistoryData(controller.keywords);
                //替换路由
                Get.offAndToNamed("/product-list",
                    arguments: {"keywords": controller.keywords});
              },
              child: Text("搜索",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: ScreenAdapter.fontSize(36))))
        ],
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.height(20)),
        children: [
          Obx(() => controller.historyList.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("搜索历史",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenAdapter.fontSize(42))),
                      IconButton(
                          onPressed: () {
                            Get.bottomSheet(Container(
                              padding: EdgeInsets.all(ScreenAdapter.width(20)),
                              color: Colors.white,
                              width: ScreenAdapter.width(1080),
                              height: ScreenAdapter.height(360),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "您确定要清空历史记录吗?",
                                        style: TextStyle(
                                            fontSize:
                                                ScreenAdapter.fontSize(48)),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: ScreenAdapter.height(40)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: ScreenAdapter.width(420),
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Color.fromARGB(123, 151,
                                                            147, 147)),
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white)),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text("取消")),
                                      ),
                                      SizedBox(
                                          width: ScreenAdapter.width(420),
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color.fromARGB(
                                                              123,
                                                              151,
                                                              147,
                                                              147)),
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.red)),
                                              onPressed: () {
                                                controller.clearHistoryData();
                                                Get.back();
                                              },
                                              child: const Text("确定"))),
                                    ],
                                  )
                                ],
                              ),
                            ));
                          },
                          icon: const Icon(Icons.delete_forever_outlined))
                    ],
                  ),
                )
              : const Text("")),
          Obx((() => Wrap(
              children: controller.historyList
                  .map((value) => GestureDetector(
                        onLongPress: () {
                          Get.defaultDialog(
                              title: "提示信息!",
                              middleText: "您确定要删除吗?",
                              confirm: ElevatedButton(
                                  onPressed: () {
                                    print("确定");
                                    controller.removeHistoryData(value);
                                    Get.back();
                                  },
                                  child: const Text("确定")),
                              cancel: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("取消")));
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              ScreenAdapter.width(32),
                              ScreenAdapter.width(16),
                              ScreenAdapter.width(32),
                              ScreenAdapter.width(16)),
                          margin: EdgeInsets.all(ScreenAdapter.height(16)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(value),
                        ),
                      ))
                  .toList()))),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("猜你想搜",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenAdapter.fontSize(42))),
                const Icon(Icons.refresh)
              ],
            ),
          ),
          Wrap(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("电脑"),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("路由器"),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("手机"),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("笔记本"),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("电脑"),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("路由器"),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("手机"),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("笔记本"),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("电脑"),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("路由器"),
              ),
            ],
          ),

          const SizedBox(height: 20),
          //热销商品

          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(138),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/hot_search.png"))),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(20)),
                  child: GridView.builder(
                      shrinkWrap: true, //收缩
                      itemCount: 8, //必须设置
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: ScreenAdapter.width(40),
                          mainAxisSpacing: ScreenAdapter.height(20),
                          childAspectRatio: 3 / 1),
                      itemBuilder: ((context, index) {
                        return Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: ScreenAdapter.width(120),
                              padding: EdgeInsets.all(ScreenAdapter.width(10)),
                              child: Image.network(
                                "https://www.itying.com/images/shouji.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.all(ScreenAdapter.width(10)),
                              alignment: Alignment.topLeft,
                              child: const Text("小米净化器 热水器 小米净化器"),
                            ))
                          ],
                        );
                      })),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
