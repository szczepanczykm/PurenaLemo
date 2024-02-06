import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

/* ****************************************************************************
1.	Wybierz język / choose language ( ok 6 języków)
2.	Wybierz logo ( domyślne PURENA, personalizowane wgraj z lokalizacji …., wymogi …)
3.	Wybierz produkt ( ok 7 produktów możliwych do wyboru)
4.	Wybierz typ apletu ( i tu będą 3 sposoby prezentacji cenówek, podam)
5.	Wybierz 2 z 3 formatów porcji (200 ml, XL  300 ml i  XXL 450 ml)
6.	Przypisz ceny
7.	Graj / Play
******************************************************************************/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Purena',
      ),
      home: const MyHomeScreen(),
    );
  }
}

enum PresentationType {
  type1,
  type2,
  type3,
}

Map<PresentationType, String> presentationTypeNames = {
  PresentationType.type1: 'Typ 1',
  PresentationType.type2: 'Typ 2',
  PresentationType.type3: 'Typ 3',
};

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const MyButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  late VideoPlayerController _controller;
  late PresentationType _presentationType;
  late double space;

  @override
  void initState() {
    super.initState();
    _presentationType = PresentationType.type1;
    space = 10;

    _controller = VideoPlayerController.asset('assets/videos/IMBIR.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller.setLooping(true);
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToVideoScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => FullScreenVideoScreen(controller: _controller)),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  void _showPresentationTypeDialog() async {
    PresentationType? selectedType = _presentationType;

    await showDialog<PresentationType>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Wybierz typ prezentacji'),
          children: PresentationType.values.map((type) {
            return SimpleDialogOption(
              onPressed: () {
                // Update the temporary selected value and pop the dialog.
                selectedType = type;
                Navigator.pop(context);
              },
              child: Text(presentationTypeNames[type] ?? 'Undefined'),
            );
          }).toList(),
        );
      },
    );

    // If a selection was made, update the state.
    if (selectedType != null) {
      setState(() {
        _presentationType = selectedType!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _goToVideoScreen();
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/logo_purena.svg',
                    semanticsLabel: 'Purena Logo',
                    height: 100,
                    fit: BoxFit.fitWidth,
                  ),
                  MyButton(onPressed: () => {}, text: "Wybierz logo...")
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  SingleChildScrollView(
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: IntrinsicColumnWidth(),
                        1: IntrinsicColumnWidth(),
                        2: IntrinsicColumnWidth(),
                        3: IntrinsicColumnWidth(),
                      },
                      children: [
                        TableRow(
                          children: [
                            const Text('Wybierz język: '),
                            SizedBox(width: space),
                            MyButton(onPressed: () => {}, text: "Polski"),
                            SizedBox(width: space),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text('Wybierz produkt: '),
                            SizedBox(width: space),
                            MyButton(onPressed: () => {}, text: "Produkt 1"),
                            SizedBox(width: space),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text('Wybierz typ \nprezentacji: '),
                            SizedBox(width: space),
                            MyButton(
                                onPressed: () =>
                                    {_showPresentationTypeDialog()},
                                text:
                                    presentationTypeNames[_presentationType]!),
                            SizedBox(width: space),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text('Wpisz pojemność \nporcji: '),
                            SizedBox(width: space),
                            MyButton(
                                onPressed: () => {},
                                text: "200ml / 300ml / 500ml"),
                            SizedBox(width: space),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text('Wprowadź ceny: '),
                            SizedBox(width: space),
                            MyButton(
                                onPressed: () => {},
                                text: "8 PLN / 10 PLN / 12 PLN"),
                            SizedBox(width: space),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: VideoWidget(controller: _controller),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoWidget extends StatelessWidget {
  const VideoWidget({
    super.key,
    required VideoPlayerController controller,
  }) : _controller = controller;

  final VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final whiteColumnWidth = screenWidth / 4;
    final videoWidth = screenWidth - whiteColumnWidth;
    final centerOffset = whiteColumnWidth / 2;

    return Stack(
      children: [
        _controller.value.isInitialized
            ? VideoPlayer(_controller)
            : const CircularProgressIndicator(),
        ProductPricesOverlayWidget(controller: _controller),
        const ProductTitleOverlay(text: 'LEMONIADA \nCYTRYNOWO-POMARAŃCZOWA')
      ],
    );
  }
}

class ProductTitleOverlay extends StatelessWidget {
  const ProductTitleOverlay({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 120, bottom: 30),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  fontSize: 30,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4
                    ..color = Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.brown,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }
}

class ProductPricesOverlayWidget extends StatelessWidget {
  const ProductPricesOverlayWidget({
    super.key,
    required VideoPlayerController controller,
  }) : _controller = controller;

  final priceTextStyle = const TextStyle(
    color: Colors.green,
    fontSize: 20,
    shadows: [
      Shadow(
        blurRadius: 5.0,
        color: Colors.greenAccent,
        offset: Offset(2.0, 2.0),
      ),
    ],
  );
  final VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/logo_purena.png',
            height: _controller.value.size.height / 25,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/images/size_s.svg', height: 100),
              Text(
                '200 ml',
                style: priceTextStyle,
              ),
              Text(
                '8 PLN',
                style: priceTextStyle,
              ),
            ],
          ),
          Column(
            children: [
              SvgPicture.asset('assets/images/size_m.svg', height: 100),
              Text(
                '300 ml',
                style: priceTextStyle,
              ),
              Text(
                '10 PLN',
                style: priceTextStyle,
              ),
            ],
          ),
          Column(
            children: [
              SvgPicture.asset('assets/images/size_l.svg', height: 100),
              Text(
                '500 ml',
                style: priceTextStyle,
              ),
              Text(
                '12 PLN',
                style: priceTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FullScreenVideoScreen extends StatelessWidget {
  final VideoPlayerController controller;

  const FullScreenVideoScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PopScope(
      onPopInvoked: (bool didPop) {
        if (didPop) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              overlays: SystemUiOverlay.values);
        }
      },
      child: VideoWidget(controller: controller),
    ));
  }
}
