
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = black;
  static const Color secondary = Color(0xff454545);
  static const Color background = white;

  static const Color transparent = Colors.transparent;
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Colors.black;
  static const Color bg = Color(0xff0A0B0D);
  static const Color red = Colors.red;
  static const Color primaryBlack = Color(0xff111111);
  static const Color filledColor = Color(0xFFe7e7e7);
  static const Color textFiledColor = Color(0xFF979797);
  static const Color strokeColor = Color(0xFFE2E2E2);
  static const Color overlayBox = Color(0xFF1C1C1E);
  static const Color black500 = Color(0xFF1B1B1B);



  //static const Color base500 = Color(0xffF4005F);
    // static const Color base500 = Color(0xff000000);
     static const Color base500 = Color(0xffFFFFFF);

  static const Color base50 = Color(0xffFEE6EF);
  static const Color black900 = Color(0xff0B0B0B);
  static const Color white500=Color(0xffF1F1F1);
  static const Color white600=Color(0xffDBDBDB);
    // static const Color text=Color(0xff1B1B1B);
        static const Color text=Color(0xffF1F1F1);

    static const Color subTitle=Color(0xFFABABAB);
    static const Color green=Color(0xFF6AA259);
    static const Color highlight=Color(0xFFB6E101);
    static const Color black100=Color(0xFFB8B8B8);
    static const Color black400=Color(0xFF494949);


  // Splash gradient backgroun color
// static const Color splashRadialStart = Color(0xFFF85494);
// static const Color splashRadialMid   = Color(0xFFF6337F);
// static const Color splashRadialEnd   = Color(0xFFDE0056);

static const Color splashRadialStart = Color(0xFF000000);
static const Color splashRadialMid   = Color(0xFF000000);
static const Color splashRadialEnd   = Color(0xFF000000);

static const Color yellow   = Color(0xFFFFCB20);
static const Color blue   = Color(0xFF4086E6);

static const RadialGradient splashRadialGradient = RadialGradient(
  center: Alignment.center,
  
  radius: 1.1369,
  colors: [
    splashRadialStart,
    splashRadialMid,
    splashRadialEnd,
  ],
  stops: [
    0.0,     
    0.415,   
    1.0,    
  ],
);

// White BG gradient (from design)
static const Color whiteBgStart = Color(0xFFFDFBFB);
static const Color whiteBgMiddle = Color(0xFFFFFFFF);
static const Color whiteBgEnd = Color(0xFFF4F4F4);

static const LinearGradient whiteBgGradient = LinearGradient(
  colors: [whiteBgStart, whiteBgMiddle, whiteBgEnd],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);


//========for button
// static const Color ctaStart = Color(0xFFFCB0CD); // 0%
// static const Color ctaMid   = Color(0xFFF85494); // 0.01%
// static const Color ctaEnd   = Color(0xFFF4005F); // 100%


static const Color ctaStart = Color(0xFFECE9E6); // 0%
static const Color ctaMid   = Color(0xFFFFFFFF); // 0.01%
static const Color ctaEnd   = Color(0xFFFFFFFF);

static const LinearGradient ctaLinearGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [ctaStart,  ctaEnd],
  stops: [0.0,  1.0],
);

}