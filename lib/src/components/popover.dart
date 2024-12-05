import 'package:flutter/material.dart';

class Popover extends StatelessWidget {
  const Popover({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // 假设这是你的主内容，气泡框指向它
        const Text('目标'),
        // 气泡框
        Positioned(
          top: 80,
          left: 120, // 根据箭头位置调整
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // 气泡内容
                const Text('气泡内容'),
                // 箭头（这里使用图片模拟）
                // 注意：你需要有一个箭头图片资源在你的项目中
                // Image.asset(
                //   'path/to/your/arrow_image.png',
                //   height: 10, // 根据需要调整
                //   alignment: Alignment.topCenter, // 可能需要调整
                // ),
                // 或者，为了简化，这里我们直接用一个容器和边框来模拟箭头
                Container(
                  height: 10,
                  width: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      right: BorderSide(color: Colors.transparent),
                      bottom: BorderSide(color: Colors.black, width: 2),
                      left: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.only(top: -5), // 调整箭头位置
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
