import 'dart:ui' as ui;

import 'package:flutter/material.dart';


class TotalTasklCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.05797101, size.height * 0.3298728);
    path_0.cubicTo(
        size.width * 0.05797101,
        size.height * 0.1657924,
        size.width * 0.1597254,
        size.height * 0.03277848,
        size.width * 0.2852457,
        size.height * 0.03277848);
    path_0.lineTo(size.width * 0.7147543, size.height * 0.03277848);
    path_0.cubicTo(
        size.width * 0.8402754,
        size.height * 0.03277848,
        size.width * 0.9420290,
        size.height * 0.1657924,
        size.width * 0.9420290,
        size.height * 0.3298728);
    path_0.cubicTo(
        size.width * 0.9420290,
        size.height * 0.4939533,
        size.width * 0.8402754,
        size.height * 0.6269674,
        size.width * 0.7147543,
        size.height * 0.6269674);
    path_0.lineTo(size.width * 0.05797101, size.height * 0.6269674);
    path_0.lineTo(size.width * 0.05797101, size.height * 0.3298728);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.05797101, size.height * 0.4403870),
        Offset(size.width * 0.9420290, size.height * 0.4403870),
        [const Color(0xff830010).withOpacity(1), const Color(0xffFF0037).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.05808725, size.height * 0.8479957);
    path_1.lineTo(size.width * 0.05808725, size.height * 0.6267043);
    path_1.lineTo(size.width * 0.2588812, size.height * 0.6267043);
    path_1.cubicTo(
        size.width * 0.1392696,
        size.height * 0.6338109,
        size.width * 0.07518043,
        size.height * 0.7771935,
        size.width * 0.05808725,
        size.height * 0.8479957);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.05797101, size.height * 0.4403870),
        Offset(size.width * 0.9420290, size.height * 0.4403870),
        [const Color(0xff830010).withOpacity(1), const Color(0xffFF0037).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//Complete task custom paint 
class TotalCompleteTasklCustomPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Path path_0 = Path();
    path_0.moveTo(size.width*0.05772957,size.height*0.3371120);
    path_0.cubicTo(size.width*0.05772957,size.height*0.1730315,size.width*0.1587518,size.height*0.04001783,size.width*0.2833691,size.height*0.04001783);
    path_0.lineTo(size.width*0.7097878,size.height*0.04001783);
    path_0.cubicTo(size.width*0.8344029,size.height*0.04001783,size.width*0.9354245,size.height*0.1730315,size.width*0.9354245,size.height*0.3371120);
    path_0.cubicTo(size.width*0.9354245,size.height*0.5011924,size.width*0.8344029,size.height*0.6342065,size.width*0.7097878,size.height*0.6342065);
    path_0.lineTo(size.width*0.05772957,size.height*0.6342065);
    path_0.lineTo(size.width*0.05772957,size.height*0.3371120);
    path_0.close();

Paint paint0Fill = Paint()..style=PaintingStyle.fill;
paint0Fill.shader = ui.Gradient.linear(Offset(size.width*0.05772957,size.height*0.4476261), Offset(size.width*0.9354245,size.height*0.4476261), [const Color(0xff006318).withOpacity(1),const Color(0xff00FF41).withOpacity(1)], [0,1]);
canvas.drawPath(path_0,paint0Fill);

Path path_1 = Path();
    path_1.moveTo(size.width*0.05784496,size.height*0.8552348);
    path_1.lineTo(size.width*0.05784496,size.height*0.6339435);
    path_1.lineTo(size.width*0.2571950,size.height*0.6339435);
    path_1.cubicTo(size.width*0.1384432,size.height*0.6410500,size.width*0.07481511,size.height*0.7844326,size.width*0.05784496,size.height*0.8552348);
    path_1.close();

Paint paint1Fill = Paint()..style=PaintingStyle.fill;
paint1Fill.shader = ui.Gradient.linear(Offset(size.width*0.05772957,size.height*0.4476261), Offset(size.width*0.9354245,size.height*0.4476261), [const Color(0xff006318).withOpacity(1),const Color(0xff00FF41).withOpacity(1)], [0,1]);
canvas.drawPath(path_1,paint1Fill);

Paint paint2Fill = Paint()..style=PaintingStyle.fill;
paint2Fill.shader = ui.Gradient.radial(const Offset(0,0),size.width*0.007194245, [Colors.white.withOpacity(1),const Color(0xffD9D9D9).withOpacity(0)], [0,1]);
canvas.drawRect(Rect.fromLTWH(size.width*0.05772957,size.height*0.1429598,size.width*0.1273647,size.height*0.6005967),paint2Fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}

// task custom paint
class TotalTaskInProgresslCustomPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Path path_0 = Path();
    path_0.moveTo(size.width*0.06282317,size.height*0.3338848);
    path_0.cubicTo(size.width*0.06282317,size.height*0.1698043,size.width*0.1638453,size.height*0.03679098,size.width*0.2884626,size.height*0.03679098);
    path_0.lineTo(size.width*0.7148813,size.height*0.03679098);
    path_0.cubicTo(size.width*0.8394964,size.height*0.03679098,size.width*0.9405180,size.height*0.1698043,size.width*0.9405180,size.height*0.3338848);
    path_0.cubicTo(size.width*0.9405180,size.height*0.4979663,size.width*0.8394964,size.height*0.6309793,size.width*0.7148813,size.height*0.6309793);
    path_0.lineTo(size.width*0.06282317,size.height*0.6309793);
    path_0.lineTo(size.width*0.06282317,size.height*0.3338848);
    path_0.close();

Paint paint0Fill = Paint()..style=PaintingStyle.fill;
paint0Fill.shader = ui.Gradient.linear(Offset(size.width*0.06282317,size.height*0.4444000), Offset(size.width*0.9405180,size.height*0.4444000), [const Color(0xff966700).withOpacity(1),const Color(0xffFFAF00).withOpacity(1)], [0,1]);
canvas.drawPath(path_0,paint0Fill);

Path path_1 = Path();
    path_1.moveTo(size.width*0.06293856,size.height*0.8520087);
    path_1.lineTo(size.width*0.06293856,size.height*0.6307163);
    path_1.lineTo(size.width*0.2622885,size.height*0.6307163);
    path_1.cubicTo(size.width*0.1435367,size.height*0.6378228,size.width*0.07990863,size.height*0.7812054,size.width*0.06293856,size.height*0.8520087);
    path_1.close();

Paint paint1Fill = Paint()..style=PaintingStyle.fill;
paint1Fill.shader = ui.Gradient.linear(Offset(size.width*0.06282317,size.height*0.4444000), Offset(size.width*0.9405180,size.height*0.4444000), [const Color(0xff966700).withOpacity(1),const Color(0xffFFAF00).withOpacity(1)], [0,1]);
canvas.drawPath(path_1,paint1Fill);

Paint paint2Fill = Paint()..style=PaintingStyle.fill;
paint2Fill.shader = ui.Gradient.radial(const Offset(0,0),size.width*0.007194245, [Colors.white.withOpacity(1),const Color(0xffD9D9D9).withOpacity(0)], [0,1]);
canvas.drawRect(Rect.fromLTWH(size.width*0.08199640,size.height*0.1346804,size.width*0.1393137,size.height*0.6005967),paint2Fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}


class TotalTaskInReviewCustomPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Path path_0 = Path();
    path_0.moveTo(size.width*0.05797101,size.height*0.3322717);
    path_0.cubicTo(size.width*0.05797101,size.height*0.1681913,size.width*0.1597254,size.height*0.03517750,size.width*0.2852457,size.height*0.03517750);
    path_0.lineTo(size.width*0.7147543,size.height*0.03517750);
    path_0.cubicTo(size.width*0.8402754,size.height*0.03517750,size.width*0.9420290,size.height*0.1681913,size.width*0.9420290,size.height*0.3322717);
    path_0.cubicTo(size.width*0.9420290,size.height*0.4963522,size.width*0.8402754,size.height*0.6293663,size.width*0.7147543,size.height*0.6293663);
    path_0.lineTo(size.width*0.05797101,size.height*0.6293663);
    path_0.lineTo(size.width*0.05797101,size.height*0.3322717);
    path_0.close();

Paint paint0Fill = Paint()..style=PaintingStyle.fill;
paint0Fill.shader = ui.Gradient.linear(Offset(size.width*0.05797101,size.height*0.4427859), Offset(size.width*0.9420290,size.height*0.4427859), [const Color(0xff00606F).withOpacity(1),const Color(0xff00DEFF).withOpacity(1)], [0,1]);
canvas.drawPath(path_0,paint0Fill);

Path path_1 = Path();
    path_1.moveTo(size.width*0.05808725,size.height*0.8503946);
    path_1.lineTo(size.width*0.05808725,size.height*0.6291033);
    path_1.lineTo(size.width*0.2588812,size.height*0.6291033);
    path_1.cubicTo(size.width*0.1392696,size.height*0.6362098,size.width*0.07518043,size.height*0.7795924,size.width*0.05808725,size.height*0.8503946);
    path_1.close();

Paint paint1Fill = Paint()..style=PaintingStyle.fill;
paint1Fill.shader = ui.Gradient.linear(Offset(size.width*0.05797101,size.height*0.4427859), Offset(size.width*0.9420290,size.height*0.4427859), [const Color(0xff00606F).withOpacity(1),const Color(0xff00DEFF).withOpacity(1)], [0,1]);
canvas.drawPath(path_1,paint1Fill);

Paint paint2Fill = Paint()..style=PaintingStyle.fill;
paint2Fill.shader = ui.Gradient.radial(const Offset(0,0),size.width*0.007246377, [Colors.white.withOpacity(1),const Color(0xffD9D9D9).withOpacity(0)], [0,1]);
canvas.drawRect(Rect.fromLTWH(size.width*0.05797101,size.height*0.1324511,size.width*0.1282877,size.height*0.6005967),paint2Fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}



//Add this CustomPaint widget to the Widget Tree


//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Path path_0 = Path();
    path_0.moveTo(size.width*0.8424968,size.height*0.6689929);
    path_0.cubicTo(size.width*0.8559290,size.height*0.6294619,size.width*0.8634323,size.height*0.5840048,size.width*0.8634323,size.height*0.5319865);
    path_0.cubicTo(size.width*0.8634323,size.height*0.2424286,size.width*0.7868258,size.height*0.08653810,size.width*0.6774323,size.height*0.03861159);
    path_0.cubicTo(size.width*0.6888065,size.height*0.03470786,size.width*0.7009226,size.height*0.03153310,size.width*0.7138710,size.height*0.02929905);
    path_0.cubicTo(size.width*0.7224710,size.height*0.02781754,size.width*0.7316258,size.height*0.02704151,size.width*0.7410452,size.height*0.02704151);
    path_0.cubicTo(size.width*0.7947742,size.height*0.02704151,size.width*0.8577935,size.height*0.05222762,size.width*0.8817613,size.height*0.1152278);
    path_0.cubicTo(size.width*0.9175161,size.height*0.2092230,size.width*0.8700774,size.height*0.3172341,size.width*0.9237484,size.height*0.4064325);
    path_0.cubicTo(size.width*0.9437935,size.height*0.4397548,size.width*1.073703,size.height*0.5801008,size.width*0.9411161,size.height*0.6353651);
    path_0.cubicTo(size.width*0.9086774,size.height*0.6488865,size.width*0.8756387,size.height*0.6591635,size.width*0.8424968,size.height*0.6689929);
    path_0.close();
    path_0.moveTo(size.width*0.09996710,size.height*0.4917500);
    path_0.cubicTo(size.width*0.07404194,size.height*0.4769341,size.width*0.05003329,size.height*0.4589444,size.width*0.03581439,size.height*0.4403190);
    path_0.cubicTo(size.width*-0.01756226,size.height*0.3703111,size.width*-0.01434252,size.height*0.2174071,size.width*0.06629935,size.height*0.1685635);
    path_0.cubicTo(size.width*0.09730581,size.height*0.1497976,size.width*0.1309729,size.height*0.1430714,size.width*0.1657942,size.height*0.1430714);
    path_0.cubicTo(size.width*0.2155981,size.height*0.1430714,size.width*0.2677832,size.height*0.1568056,size.width*0.3179961,size.height*0.1686103);
    path_0.cubicTo(size.width*0.2472368,size.height*0.2394183,size.width*0.1788968,size.height*0.3341659,size.width*0.1196019,size.height*0.4489032);
    path_0.cubicTo(size.width*0.1120271,size.height*0.4635540,size.width*0.1055129,size.height*0.4778278,size.width*0.09996710,size.height*0.4917500);
    path_0.close();

Paint paint0Fill = Paint()..style=PaintingStyle.fill;
paint0Fill.shader = ui.Gradient.linear(Offset(0,size.height*0.3480175), Offset(size.width,size.height*0.3480175), [const Color(0xff830010).withOpacity(1),const Color(0xffFF0037).withOpacity(1)], [0,1]);
canvas.drawPath(path_0,paint0Fill);

Path path_1 = Path();
    path_1.moveTo(size.width*0.4585458,size.height*0.9010317);
    path_1.cubicTo(size.width*0.2744071,size.height*0.9010317,size.width*-0.01170123,size.height*0.7716881,size.width*0.09996516,size.height*0.4917484);
    path_1.cubicTo(size.width*0.1303948,size.height*0.5091270,size.width*0.1634852,size.height*0.5221548,size.width*0.1863768,size.height*0.5267405);
    path_1.cubicTo(size.width*0.2319368,size.height*0.5359119,size.width*0.2831735,size.height*0.5374175,size.width*0.3238574,size.height*0.5636143);
    path_1.cubicTo(size.width*0.3994181,size.height*0.6122698,size.width*0.3978174,size.height*0.7510167,size.width*0.4806742,size.height*0.8028730);
    path_1.cubicTo(size.width*0.4957865,size.height*0.8123254,size.width*0.5107129,size.height*0.8162778,size.width*0.5254716,size.height*0.8162778);
    path_1.cubicTo(size.width*0.5736181,size.height*0.8162778,size.width*0.6196994,size.height*0.7741571,size.width*0.6625226,size.height*0.7435389);
    path_1.cubicTo(size.width*0.7044194,size.height*0.7135786,size.width*0.7498129,size.height*0.6967175,size.width*0.7964839,size.height*0.6826310);
    path_1.cubicTo(size.width*0.8118194,size.height*0.6779984,size.width*0.8271742,size.height*0.6735540,size.width*0.8424903,size.height*0.6689913);
    path_1.cubicTo(size.width*0.7840387,size.height*0.8411349,size.width*0.6131110,size.height*0.9010317,size.width*0.4585458,size.height*0.9010317);
    path_1.close();
    path_1.moveTo(size.width*0.4093935,size.height*0.1835183);
    path_1.cubicTo(size.width*0.3987110,size.height*0.1835183,size.width*0.3873955,size.height*0.1825778,size.width*0.3753542,size.height*0.1805786);
    path_1.cubicTo(size.width*0.3567058,size.height*0.1774984,size.width*0.3374994,size.height*0.1731944,size.width*0.3179948,size.height*0.1686087);
    path_1.cubicTo(size.width*0.4123529,size.height*0.07421389,size.width*0.5109361,size.height*0.02236016,size.width*0.5979432,size.height*0.02236016);
    path_1.cubicTo(size.width*0.6258039,size.height*0.02236016,size.width*0.6524710,size.height*0.02767492,size.width*0.6774323,size.height*0.03861000);
    path_1.cubicTo(size.width*0.5670116,size.height*0.07647151,size.width*0.5241497,size.height*0.1835183,size.width*0.4093935,size.height*0.1835183);
    path_1.close();

Paint paint1Fill = Paint()..style=PaintingStyle.fill;
paint1Fill.shader = ui.Gradient.linear(Offset(size.width*0.07484903,size.height*0.4616944), Offset(size.width*0.8424903,size.height*0.4616944), [const Color(0xff830010).withOpacity(1),const Color(0xffFF0037).withOpacity(1)], [0,1]);
canvas.drawPath(path_1,paint1Fill);

Path path_2 = Path();
    path_2.moveTo(size.width*0.5254742,size.height*0.8162778);
    path_2.cubicTo(size.width*0.5107155,size.height*0.8162778,size.width*0.4957897,size.height*0.8123254,size.width*0.4806774,size.height*0.8028730);
    path_2.cubicTo(size.width*0.3978206,size.height*0.7510198,size.width*0.3994213,size.height*0.6122730,size.width*0.3238600,size.height*0.5636175);
    path_2.cubicTo(size.width*0.2831761,size.height*0.5374198,size.width*0.2319400,size.height*0.5359151,size.width*0.1863800,size.height*0.5267437);
    path_2.cubicTo(size.width*0.1634884,size.height*0.5221579,size.width*0.1303974,size.height*0.5091302,size.width*0.09996839,size.height*0.4917508);
    path_2.cubicTo(size.width*0.1055148,size.height*0.4778294,size.width*0.1120284,size.height*0.4635548,size.width*0.1196032,size.height*0.4489040);
    path_2.cubicTo(size.width*0.1788981,size.height*0.3341675,size.width*0.2472381,size.height*0.2394198,size.width*0.3179974,size.height*0.1686119);
    path_2.cubicTo(size.width*0.3375019,size.height*0.1731976,size.width*0.3567090,size.height*0.1775008,size.width*0.3753574,size.height*0.1805817);
    path_2.cubicTo(size.width*0.3873987,size.height*0.1825810,size.width*0.3987142,size.height*0.1835214,size.width*0.4093968,size.height*0.1835214);
    path_2.cubicTo(size.width*0.5241529,size.height*0.1835214,size.width*0.5670142,size.height*0.07647444,size.width*0.6774323,size.height*0.03861294);
    path_2.cubicTo(size.width*0.7868323,size.height*0.08653968,size.width*0.8634323,size.height*0.2424302,size.width*0.8634323,size.height*0.5319881);
    path_2.cubicTo(size.width*0.8634323,size.height*0.5840063,size.width*0.8559355,size.height*0.6294635,size.width*0.8424968,size.height*0.6689944);
    path_2.cubicTo(size.width*0.8271806,size.height*0.6735563,size.width*0.8118258,size.height*0.6780016,size.width*0.7964903,size.height*0.6826341);
    path_2.cubicTo(size.width*0.7498129,size.height*0.6967206,size.width*0.7044194,size.height*0.7135817,size.width*0.6625290,size.height*0.7435413);
    path_2.cubicTo(size.width*0.6197026,size.height*0.7741603,size.width*0.5736213,size.height*0.8162778,size.width*0.5254742,size.height*0.8162778);
    path_2.close();

Paint paint2Fill = Paint()..style=PaintingStyle.fill;
paint2Fill.shader = ui.Gradient.linear(Offset(size.width*0.09996839,size.height*0.4274452), Offset(size.width*0.8634323,size.height*0.4274452), [const Color(0xff830010).withOpacity(1),const Color(0xffFF0037).withOpacity(1)], [0,1]);
canvas.drawPath(path_2,paint2Fill);

Path path_3 = Path();
    path_3.moveTo(size.width*0.3291452,size.height*0.09664841);
    path_3.cubicTo(size.width*0.3291452,size.height*0.1167548,size.width*0.3122090,size.height*0.1330516,size.width*0.2913271,size.height*0.1330516);
    path_3.cubicTo(size.width*0.2704452,size.height*0.1330516,size.width*0.2535090,size.height*0.1167548,size.width*0.2535090,size.height*0.09664841);
    path_3.cubicTo(size.width*0.2535090,size.height*0.07654151,size.width*0.2704452,size.height*0.06024460,size.width*0.2913271,size.height*0.06024460);
    path_3.cubicTo(size.width*0.3122090,size.height*0.06024460,size.width*0.3291452,size.height*0.07654151,size.width*0.3291452,size.height*0.09664841);
    path_3.close();

Paint paint3Fill = Paint()..style=PaintingStyle.fill;
paint3Fill.color = const Color(0xffEE2358).withOpacity(1.0);
canvas.drawPath(path_3,paint3Fill);

Path path_4 = Path();
    path_4.moveTo(size.width*0.3759503,size.height*0.02609944);
    path_4.cubicTo(size.width*0.3759503,size.height*0.03616452,size.width*0.3686923,size.height*0.04430119,size.width*0.3597587,size.height*0.04430119);
    path_4.cubicTo(size.width*0.3507884,size.height*0.04430119,size.width*0.3435484,size.height*0.03616452,size.width*0.3435484,size.height*0.02609944);
    path_4.cubicTo(size.width*0.3435484,size.height*0.01605794,size.width*0.3507884,size.height*0.007897754,size.width*0.3597587,size.height*0.007897754);
    path_4.cubicTo(size.width*0.3686923,size.height*0.007897754,size.width*0.3759503,size.height*0.01605794,size.width*0.3759503,size.height*0.02609944);
    path_4.close();

Paint paint4Fill = Paint()..style=PaintingStyle.fill;
paint4Fill.color = const Color(0xffEE2358).withOpacity(1.0);
canvas.drawPath(path_4,paint4Fill);

Path path_5 = Path();
    path_5.moveTo(size.width*0.6712710,size.height*0.9601190);
    path_5.cubicTo(size.width*0.6712710,size.height*0.9821349,size.width*0.6571613,size.height*0.9999603,size.width*0.6397619,size.height*0.9999603);
    path_5.cubicTo(size.width*0.6223606,size.height*0.9999603,size.width*0.6082535,size.height*0.9821349,size.width*0.6082535,size.height*0.9601190);
    path_5.cubicTo(size.width*0.6082535,size.height*0.9381349,size.width*0.6223606,size.height*0.9203095,size.width*0.6397619,size.height*0.9203095);
    path_5.cubicTo(size.width*0.6571613,size.height*0.9203095,size.width*0.6712710,size.height*0.9381349,size.width*0.6712710,size.height*0.9601190);
    path_5.close();

Paint paint5Fill = Paint()..style=PaintingStyle.fill;
paint5Fill.color = const Color(0xffEE2358).withOpacity(1.0);
canvas.drawPath(path_5,paint5Fill);

Path path_6 = Path();
    path_6.moveTo(size.width*0.8981806,size.height*0.7587786);
    path_6.cubicTo(size.width*0.8981806,size.height*0.7757341,size.width*0.8860839,size.height*0.7894913,size.width*0.8711548,size.height*0.7894913);
    path_6.cubicTo(size.width*0.8562323,size.height*0.7894913,size.width*0.8441548,size.height*0.7757341,size.width*0.8441548,size.height*0.7587786);
    path_6.cubicTo(size.width*0.8441548,size.height*0.7418000,size.width*0.8562323,size.height*0.7280429,size.width*0.8711548,size.height*0.7280429);
    path_6.cubicTo(size.width*0.8860839,size.height*0.7280429,size.width*0.8981806,size.height*0.7418000,size.width*0.8981806,size.height*0.7587786);
    path_6.close();

Paint paint6Fill = Paint()..style=PaintingStyle.fill;
paint6Fill.color = const Color(0xffEE2358).withOpacity(1.0);
canvas.drawPath(path_6,paint6Fill);

Path path_7 = Path();
    path_7.moveTo(size.width*0.8315355,size.height*0.8020000);
    path_7.cubicTo(size.width*0.8315355,size.height*0.8082778,size.width*0.8263032,size.height*0.8133810,size.width*0.8198452,size.height*0.8133810);
    path_7.cubicTo(size.width*0.8133677,size.height*0.8133810,size.width*0.8081419,size.height*0.8082778,size.width*0.8081419,size.height*0.8020000);
    path_7.cubicTo(size.width*0.8081419,size.height*0.7957222,size.width*0.8133677,size.height*0.7906206,size.width*0.8198452,size.height*0.7906206);
    path_7.cubicTo(size.width*0.8263032,size.height*0.7906206,size.width*0.8315355,size.height*0.7957222,size.width*0.8315355,size.height*0.8020000);
    path_7.close();

Paint paint7Fill = Paint()..style=PaintingStyle.fill;
paint7Fill.color = const Color(0xffEE2358).withOpacity(1.0);
canvas.drawPath(path_7,paint7Fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}