library vpixel;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

//像素缩放比
double _pixelScale = 1;

//初始化
void _initVPixel(MediaQueryData mqd, double designWidth) {
  _pixelScale = mqd.size.width / designWidth;
}

//虚拟像素转化扩展
extension VPixelExp on num {
  //虚拟像素
  double get vpx {
    //this is designPixel
    return _pixelScale * this;
  }
  //默认像素
  double get dp2vpx {
    //this is dp
    return this / _pixelScale;
  }
}

//数据共享
class _VPixelInherited extends InheritedWidget {
  final MediaQueryData? data;
  final Widget child;
  final Key? key;
  const _VPixelInherited({this.key, this.data, required this.child}) : super(key: key, child: child);
  @override
  bool updateShouldNotify(covariant _VPixelInherited oldWidget) {
    return data != oldWidget.data;
  }
}

//虚拟像素小部件
class VPixel extends StatefulWidget {
  final WidgetBuilder? builder;
  final Key? key;
  final double designWidth;
  const VPixel({this.key, this.builder, required this.designWidth}) : assert(designWidth != null), super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _VPixelState();
  }

  //获取UI尺寸数据
  static MediaQueryData? of(BuildContext ctx) {
    return ctx.dependOnInheritedWidgetOfExactType<_VPixelInherited>()?.data;
  }
}

//虚拟像素小部件状态
class _VPixelState extends State<VPixel> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeMetrics() {
    //UI尺寸发生变化时，刷新状态
    setState(() {
      RendererBinding.instance!.scheduleWarmUpFrame();
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    _initVPixel(data, widget.designWidth);
    return _VPixelInherited(
      data: data,
      child: Builder(
        builder: (ctx) {
          return widget.builder!(ctx);
        },
      ),
    );
  }

}