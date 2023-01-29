import 'dart:ui';


extension SizeExtension on num{
  double get dp => DimenFit.dpToSize(this);
  double get sp => DimenFit.spToSize(this);

}
class DimenFit{
  static late double physicalWidth;
  static late double physicalHeight;
  static late double devicePixelRatio;
  static late double screenWidth;
  static late double screenHeight;
  static late double statusBarHeight;
  static late double bottomBarHeight;
  static late double widthScaleRatio;
  static late double _designWidth;
  static void initialize({double designWidth = 375}){
    _designWidth=designWidth;
    physicalWidth=window.physicalSize.width;
    physicalHeight=window.physicalSize.height;
    devicePixelRatio=window.devicePixelRatio;
    screenWidth=physicalWidth/devicePixelRatio;
    screenHeight=physicalHeight/devicePixelRatio;
    statusBarHeight=window.padding.top/devicePixelRatio;
    bottomBarHeight=window.padding.bottom/devicePixelRatio;

    widthScaleRatio = screenWidth/_designWidth;
  }

  static double dpToSize(num dp) => dp * widthScaleRatio;
  static double spToSize(num sp) => sp * widthScaleRatio;

}