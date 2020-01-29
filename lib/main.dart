import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LFIT Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Photo Meme Creator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProgressDialog _progressDialog;
  File _finalImageFile = null;
  int bottomTabBarIndex = 0;
  ScreenshotController screenshotController = ScreenshotController();

  File _1stImageFile = null;
  File _2ndImageFile = null;
  File _3rdImageFile = null;
  File _4thImageFile = null;

  double imageSize = 0;

  incrementBottomTabBarIndex(index) {
    setState(() {
      bottomTabBarIndex = index;
    });
  }

  Future getImage(bool firstImage, bool secondImage, bool thirdImage,
      bool fourthImage) async {
    print('getImageRan()');

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    double screenSize = MediaQuery.of(context).size.width - 50;
    imageSize = screenSize / 4;

    setState(() {
      print('otherwise onTap() isnt get called');
    });

    if (firstImage) {
      setState(() {
        _1stImageFile = image;
      });
    } else if (secondImage) {
      setState(() {
        _2ndImageFile = image;
      });
    } else if (thirdImage) {
      setState(() {
        _3rdImageFile = image;
      });
    } else if (fourthImage) {
      setState(() {
        _4thImageFile = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    _progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    _progressDialog.style(
      message: 'Saving your image...',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Screenshot(
              controller: screenshotController,
              child: createCanvas(deviceWidth))),
      bottomNavigationBar: Container(
        height: 50.0,
        child: InkWell(
            onTap: () {
              takeScreenShot();
            },
            child: Container(
              color: Colors.blue,
              child: Center(
                  child: Text('SAVE & SHARE',
                      style: TextStyle(
                          color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold))),
            )),
      ),
    );
  }

  Widget createCanvas(double deviceWidth) {
    double canvasSize = deviceWidth - 50.0;

    return Container(
      height: canvasSize,
      width: canvasSize,
      child: Column(
        children: <Widget>[
          Container(
            height: canvasSize / 2,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      getImage(true, false, false, false);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color: Color(0xFFF5DCC7),
                          child: Center(child: Text('')),
                        ),
                        _1stImageFile == null
                            ? getCameraIcon()
                            : Positioned.fill(
                                child: Image.file(
                                  _1stImageFile,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Positioned.fill(
                          bottom: 5.0,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: getImageTypeText('LINKEDIN'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      getImage(false, true, false, false);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color: Color(0xFFD2F3DF),
                          child: Center(child: Text('')),
                        ),
                        _2ndImageFile == null
                            ? getCameraIcon()
                            : Positioned.fill(
                                child: Image.file(
                                  _2ndImageFile,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Positioned.fill(
                          bottom: 5.0,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: getImageTypeText('FACEBOOK'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: canvasSize / 2,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      getImage(false, false, true, false);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color: Color(0xFFD5E8F8),
                          child: Center(child: Text('')),
                        ),
                        _3rdImageFile == null
                            ? getCameraIcon()
                            : Positioned.fill(
                                child: Image.file(
                                  _3rdImageFile,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Positioned.fill(
                          bottom: 5.0,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: getImageTypeText('INSTAGRAM'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      getImage(false, false, false, true);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color: Color(0xFFFCDFFF),
                          child: Center(child: Text('')),
                        ),
                        _4thImageFile == null
                            ? getCameraIcon()
                            : Positioned.fill(
                                child: Image.file(
                                  _4thImageFile,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Positioned.fill(
                          bottom: 5.0,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: getImageTypeText('TINDER'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getCameraIcon() {
    return Center(
      child: Icon(
        Icons.image,
        color: Colors.black38,
      ),
    );
  }

  Widget getImageTypeText(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          shadows: <Shadow>[
            Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 2.0,
                color: Colors.black.withOpacity(0.9))
          ]),
    );
  }

  void takeScreenShot() async {
    _progressDialog.show();

    final directory = (await getApplicationDocumentsDirectory())
        .path; //from path_provide package
    String fileName = DateTime.now().toIso8601String();
    final path = '$directory/$fileName.png';

    screenshotController
        .capture(path: path, pixelRatio: 2.0)
        .then((File imageFile) async {
      setState(() {
        _finalImageFile = imageFile;
      });

      final result =
          await ImageGallerySaver.saveImage(_finalImageFile.readAsBytesSync());

      print('image location: $result');
      _progressDialog.hide();

      final ByteData bytes = await rootBundle.load(path);
      await Share.file(
          'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png',
          text: 'My optional text.');

      print('image has been saved');
    });
  }
}

/*
first color: Color(0xFFF5DCC7),
second color: Color(0xFFD2F3DF)
third color: Color(0xFFD5E8F8)
fourth color: Color(0xFFFCDFFF)
 */
