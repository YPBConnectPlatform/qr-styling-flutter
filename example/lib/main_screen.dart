/*
 * QR.Flutter
 * Copyright (c) 2019 the QR.Flutter authors.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// This is the screen that you'll see when the app starts
class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final message = 'Hey this is a QR code. Change the value for custom QR.';
  QrEyeDot qrEyeDot = QrEyeDot.square;
  QrEyeOuter qrEyeOuter = QrEyeOuter.square;
  QrDataModuleShape qrDataShape = QrDataModuleShape.square;

  @override
  Widget build(BuildContext context) {
    /*final qrFutureBuilder = FutureBuilder<ui.Image>(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 280.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: message,
            version: QrVersions.auto,
            gapless: true,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              //color: Color(0xff128760),
              borderRadius: 10,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              //color: Color(0xff1a5441),
              borderRadius: 5,
            ),
            // size: 320.0,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(50),
              safeArea: true,
              safeAreaMultiplier: 1.1,
            ),
          ),
        );
      },
    );

    return qrFutureBuilder;*/

    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    width: 280,
                    child: QrImageView(
                      data: 'https://qr.staging.ypb.io/yEuyy2uvkE',
                      version: QrVersions.auto,
                      errorCorrectionLevel: QrErrorCorrectLevel.H,
                      eyeStyle: QrEyeStyle(
                        eyeDot: qrEyeDot,
                        eyeOuter: qrEyeOuter,
                        color: Colors.black,
                      ),
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: qrDataShape,
                        color: Colors.black,
                      ),
                      // embeddedImage: AssetImage('assets/images/4.0x/logo_yakka_transparent.png'),
                      // embeddedImageStyle: QrEmbeddedImageStyle(
                      //   // 0.4 size of qr
                      //   size: Size.square(112),
                      //   color: Colors.white,
                      //   embeddedImageShape: EmbeddedImageShape.square,
                      //   shapeColor: Color(0xff128760),
                      // ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Text(message),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Eye Dot'),
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownButton<QrEyeDot>(
                      value: qrEyeDot,
                      items: QrEyeDot.values
                          .map((eyeDot) => DropdownMenuItem<QrEyeDot>(
                              value: eyeDot, child: Text(eyeDot.name)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          qrEyeDot = value ?? qrEyeDot;
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Eye Outer'),
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownButton<QrEyeOuter>(
                      value: qrEyeOuter,
                      items: QrEyeOuter.values
                          .map((eyeOuter) => DropdownMenuItem<QrEyeOuter>(
                              value: eyeOuter, child: Text(eyeOuter.name)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          qrEyeOuter = value ?? qrEyeOuter;
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Data Shape'),
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownButton<QrDataModuleShape>(
                      value: qrDataShape,
                      items: QrDataModuleShape.values
                          .map((dataShape) =>
                              DropdownMenuItem<QrDataModuleShape>(
                                  value: dataShape,
                                  child: Text(dataShape.name)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          qrDataShape = value ?? qrDataShape;
                        });
                      }),
                ],
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
