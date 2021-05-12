## 虚拟像素

通过设计稿尺寸自动等比缩放UI

##### 引入方式
```yaml
dependencies:
  # 虚拟像素
  vpixel:
    git:
      url: https://github.com/XiaoBaiCZ/vPixel.git
      ref: stable
```

##### 使用方式

使用VPixel包住需要缩放的Widget，推荐 入口Widget（全局通用）

```dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //入口设置VPixel
    return VPixel(
      //设计稿宽度尺寸
      designWidth: 750,
      builder: (ctx) {
        //原入口Widget
        //App范围内都能使用vpx，如Body
        return MaterialApp(
          home: Scaffold(
            body: Body(),
          ),
        );
      },
    );
  }
}

//App范围内可用vpx填写设计稿尺寸
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        //3等分方块
        //App范围内可用vpx填写设计稿尺寸
        Positioned(
          top: 0,
          left: 0,
          child: Container(color: Colors.red, width: 250.vpx, height: 250.vpx,),
        ),
        Positioned(
          top: 0,
          child: Container(color: Colors.green, width: 250.vpx, height: 250.vpx,),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(color: Colors.blue, width: 250.vpx, height: 250.vpx,),
        ),
        //2等分方块
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(color: Colors.yellow, width: 375.vpx, height: 375.vpx,),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(color: Colors.orange, width: 375.vpx, height: 375.vpx,),
        ),
      ],
    );
  }
}
```

##### 效果图
![5EBB03B8-D00D-436A-8155-73303A6334FC.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6967d68c32cd447185d525070bbdefa1~tplv-k3u1fbpfcp-watermark.image)

![6A8CD3B3-6FDD-4BB7-AFB6-E7FA14BBEBDF.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/75610b6d7ae8431dafa9344d03ff7676~tplv-k3u1fbpfcp-watermark.image)
