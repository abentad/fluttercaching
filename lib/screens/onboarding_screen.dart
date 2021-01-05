import 'package:autocomplete/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;

  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/white1.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 500,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      onBoardPage("fast-food.png", "Choose Food",
                          "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nisi, fugit architecto. Quasi, deleniti. Voluptatum deleniti exercitationem enim accusantium maiores animi!"),
                      onBoardPage("no-signal.png", "No signal",
                          "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Nisi, fugit architecto. Quasi, deleniti. Voluptatum deleniti exercitationem enim accusantium maiores animi!"),
                    ],
                    onPageChanged: (value) => {
                      setCurrentPage(value),
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) => getIndicator(index)),
                ),
                SizedBox(height: 120.0),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: changePage,
                child: Container(
                  height: 70.0,
                  width: 70.0,
                  margin: EdgeInsets.only(bottom: 30.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xfff3953b),
                        Color(0xffe57509),
                      ],
                      stops: [0, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changePage() {
    if (currentPage == 1) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      _pageController.animateToPage(
        currentPage + 1,
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
  }

  void setCurrentPage(int value) {
    setState(() {
      currentPage = value;
    });
  }

  AnimatedContainer getIndicator(int pageNo) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: 10,
      width: (currentPage == pageNo) ? 20 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: (currentPage == pageNo) ? Colors.orange : Colors.grey,
      ),
    );
  }

  Column onBoardPage(String img, String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/$img"),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: "Raleway",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
