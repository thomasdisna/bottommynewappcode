import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/OnBoarding_Screen/Choose_Login.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 5.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFFffd55e) : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(backgroundColor: Color(0xFF1E2026),
        contentPadding: EdgeInsets.only(top: 10, left: 10),
        title: Image.asset(
          "assets/Template1/image/Foodie/logo.png",
          height: 18, alignment: Alignment.topLeft,
        ),
        titlePadding: EdgeInsets.all(10),
        content: new Text("Are you sure you want to exit?",
            style: f15w),
        actions:
        <Widget>[
          MaterialButton(
            height: 28,
            color: Color(0xFFffd55e),
            child: new Text(
              "Cancel",
              style: TextStyle(
                  color: Colors
                      .black),
            ),
            onPressed: () => Navigator.of(context).pop(false),

          ),
          SizedBox(width: 15,),
          MaterialButton(
            height: 28,
            color: Color(0xFF48c0d8),
            child: new Text(
              "Ok",
              style: TextStyle(
                  color: Colors
                      .black),
            ),
            onPressed: () => Navigator.of(context).pop(true),

          ),
        ],

      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    var _textH1 = TextStyle(
        fontFamily: "Sofia",
        fontWeight: FontWeight.w600,
        fontSize: 23.0,
        color: Colors.white);

    var _textH2 = TextStyle(
        fontFamily: "Sofia",
        fontWeight: FontWeight.w200,
        fontSize: 16.0,
        color: Colors.white);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1E2026),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Image(
                            image: AssetImage(
                                'assets/Template1/image/onBoarding1.jpeg'),
                            height: 400.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 0.0, bottom: _height / 3.8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(0.0, 1.0),
                                // stops: [0.0, 1.0],
                                // colors: <Color>[
                                //   Color(0xFF1E2026).withOpacity(0.1),
                                //   Color(0xFF1E2026).withOpacity(0.3),
                                //   Color(0xFF1E2026),
                                //   Color(0xFF1E2026),
                                // ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 245.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Live your life smarter',
                                    style: _textH1,
                                  ),
                                  SizedBox(height: 35.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                      textAlign: TextAlign.center,
                                      style: _textH2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: <Widget>[
                          Image(
                            image: AssetImage(
                                'assets/Template1/image/onBoarding2.jpeg'),
                            height: 400.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 0.0, bottom: _height / 3.8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(0.0, 1.0),
                                // stops: [0.0, 1.0],
                                // colors: <Color>[
                                //   Color(0xFF1E2026).withOpacity(0.1),
                                //   Color(0xFF1E2026).withOpacity(0.3),
                                //   Color(0xFF1E2026),
                                //   Color(0xFF1E2026),
                                // ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 245.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Live your life smarter',
                                    style: _textH1,
                                  ),
                                  SizedBox(height: 35.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                      textAlign: TextAlign.center,
                                      style: _textH2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: <Widget>[
                          Image(
                            image: AssetImage(
                                'assets/Template1/image/onBoarding3.jpeg'),
                            height: 400.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 0.0, bottom: _height / 3.8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(0.0, 1.0),
                                // stops: [0.0, 1.0],
                                // colors: <Color>[
                                //   Color(0xFF1E2026).withOpacity(0.1),
                                //   Color(0xFF1E2026).withOpacity(0.3),
                                //   Color(0xFF1E2026),
                                //   Color(0xFF1E2026),
                                // ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 245.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Live your life smarter',
                                    style: _textH1,
                                  ),
                                  SizedBox(height: 35.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                      textAlign: TextAlign.center,
                                      style: _textH2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: FractionalOffset.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 470.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                  ),
                ),
                _currentPage != _numPages - 1
                    ? Align(
                        alignment: FractionalOffset.bottomRight,
                        child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.transparent,
                                    border: Border.all(color: Color(0xFFffd55e))),
                                child: Center(
                                    child: Text(
                                  "Continue",
                                  style: TextStyle(
                                      color: Color(0xFFffd55e),
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins",
                                      letterSpacing: 1.5),
                                )),
                              ),
                            )),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
        bottomSheet: _currentPage == _numPages - 1
            ? InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new chooseLogin()));
                },
                child: Container(
                  height: 60.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFffd55e)
                  ),
                  child: Center(
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19.0,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
              )
            : Text(''),
      ),
    );
  }
}
