import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'main.dart';
import 'model.dart';
const _duration = Duration(milliseconds: 500);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<IceCream> listIceCream = [];
  final pageIceCreamController = PageController(viewportFraction: 0.35);
  final pageTextController = PageController();
  double currentPage = 0.0;
  double textPage = 0.0;

  @override
  void initState() {
    addIceCream();
    pageIceCreamController.addListener(iceCreamScrollListener);
    pageTextController.addListener(textScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    pageIceCreamController.removeListener(iceCreamScrollListener);
    pageIceCreamController.dispose();
    pageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              bottom: size.width * 0.10,
              height: size.height / 10,
              left: 20,
              right: 20,
              child: const DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 90,
                      offset: Offset.zero,
                      spreadRadius: 45)
                ]),
              )),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                controller: pageIceCreamController,
                itemCount: listIceCream.length + 1,
                scrollDirection: Axis.vertical,
                onPageChanged: (val) {
                  if (val < listIceCream.length) {
                    pageTextController.animateToPage(val,
                        duration: _duration, curve: Curves.decelerate);
                  }
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return SizedBox.shrink();
                  }
                  final ice = listIceCream[index - 1];
                  final result = currentPage - index + 1;
                  final value = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, size.height / 2.6 * (1 - value).abs())
                        ..scale(value),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              PageRouteBuilder(
                                  transitionDuration: Duration(seconds: 1),
                                  reverseTransitionDuration: Duration(seconds: 1),
                                  pageBuilder: (context,animation,secondaryAnimation){
                                    final curvedAnimation =CurvedAnimation(
                                        parent: animation,
                                        curve: Interval(0,0.5)
                                    );
                                    return FadeTransition(
                                        opacity: curvedAnimation,
                                        child: DetailPage(
                                            iceCream : ice,
                                            tagImage:ice.image + index.toString()));
                                  })
                          );
                        },
                        child: Hero(
                          tag: ice.image + index.toString(),
                          child: Opacity(
                              opacity: opacity,
                              child: Image.asset(
                                ice.image,
                                fit: BoxFit.fitHeight,
                              )),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Positioned(
              height: 100,
              top: size.height * 0.1,
              left: size.width * 0.3,
              right: 0,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                        itemCount: listIceCream.length,
                        physics: NeverScrollableScrollPhysics(),
                        controller: pageTextController,
                        itemBuilder: (context, index) {
                          final opacity =
                          (1 - (index - textPage).abs()).clamp(0.0, 1.0);
                          return Opacity(
                              opacity: opacity,
                              child: Center(
                                  child: Text(
                                    listIceCream[index].name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                        fontSize: 30, fontWeight: FontWeight.bold),
                                  )));
                        }),
                  ),
                  AnimatedSwitcher(
                    duration: _duration,
                    child: Text(
                      listIceCream[currentPage.toInt().clamp(0, listIceCream.length - 1)].price,
                      style: TextStyle(fontSize: 30, color: Colors.red),
                    ),
                  )

                ],
              ))
        ],
      ),
    );
  }

  void addIceCream() {
    setState(() {
      listIceCream.add(new IceCream(
        name: "Papaya Juice",
        price: "2,500 MMK",
        image: "assets/i5.png",
        desc:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      ));
      listIceCream.add(new IceCream(
        name: "Water Melon Juice",
        price: "2,400 MMK",
        image: "assets/i2.png",
        desc:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      ));
      listIceCream.add(new IceCream(
        name: "Orange Juice",
        price: "2,300 MMK",
        image: "assets/i3.png",
        desc:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      ));
      listIceCream.add(new IceCream(
        name: "Mango Juice",
        price: "2,100 MMK",
        image: "assets/i4.png",
        desc:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      ));
    });
  }

  void iceCreamScrollListener() {
    setState(() {
      currentPage = pageIceCreamController.page!;
    });
  }

  void textScrollListener() {
    setState(() {
      textPage = currentPage;
    });
  }
}
