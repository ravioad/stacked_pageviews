import 'package:flutter/material.dart';
import 'package:stacked_pageviews/animations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> images = [
    "images/endgame.jpg",
    "images/eternals.png",
    "images/housefull.png",
    "images/joker.jpg"
  ];

  List<String> names = ["Endgame", "Eternals", "Housefull", "Joker"];

  PageController backPageViewController;
  PageController frontPageViewController;

  int currentPage = 0;

  @override
  void initState() {
    backPageViewController = PageController(initialPage: images.length - 1);
    frontPageViewController = PageController(viewportFraction: .8);
    frontPageViewController.addListener(() {
      int next = frontPageViewController.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: backPageViewController,
            children: <Widget>[
              page(image: images[3]),
              page(image: images[2]),
              page(image: images[1]),
              page(image: images[0]),
            ],
          ),
          PageView.builder(
            physics: BouncingScrollPhysics(),
            controller: frontPageViewController,
            itemCount: images.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              bool active = (index == currentPage);
              return frontPage(
                  image: images[index], title: names[index], isActive: active);
            },
            onPageChanged: (index) {
              backPageViewController.animateToPage(
                images.length - 1 - index,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
          )
        ],
      ),
    );
  }

  Widget frontPage({image, title, isActive}) {
    double paddingTop = isActive ? 100 : 150;
    double blur = isActive ? 30 : 0;
    double offset = isActive ? 20 : 0;
    return AnimatedPadding(
      duration: Duration(milliseconds: 400),
      padding: EdgeInsets.only(top: paddingTop, right: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: blur,
                    offset: Offset(offset, offset),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                    delay: 1.5,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    delay: 2,
                    child: Text(
                      "Action + Adventure",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    delay: 2.5,
                    child: Text(
                      "4.0",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeAnimation(
                    delay: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 20,
                        ),
                        Icon(
                          Icons.star_border,
                          color: Colors.white,
                          size: 20,
                        ),
                        Icon(
                          Icons.star_border,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget page({image}) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        color: Colors.black.withOpacity(.6),
      ),
    );
  }
}
