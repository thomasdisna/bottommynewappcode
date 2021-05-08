import 'package:flutter/material.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/Screen/Template1/Login_Screen/Signup_Screen.dart';

class chooseLogin extends StatefulWidget {
  chooseLogin({Key key}) : super(key: key);

  @override
  _chooseLoginState createState() => _chooseLoginState();
}

class _chooseLoginState extends State<chooseLogin>
    with TickerProviderStateMixin {
  /// Declare Animation
  AnimationController animationController;
  var tapLogin = 0;
  var tapSignup = 0;
  var tapGmail = 0;

  @override

  /// Declare animation in initState
  void initState() {
    // TODO: implement initState
    /// Animation proses duration
    animationController =
        AnimationController( duration: Duration(milliseconds: 300))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tapLogin = 0;
                tapSignup = 0;
                tapGmail = 0;
              });
            }
          });
    super.initState();
  }

  /// To dispose animation controller
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  /// Play animation set forward reverse
  Future<Null> _Playanimation() async {
    try {
      await animationController.forward();
      await animationController.reverse();
    } on TickerCanceled {}
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

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    mediaQuery.devicePixelRatio;
    mediaQuery.size.height;
    mediaQuery.size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            ///
            /// Set background video
            ///
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/Template1/image/chosseBackground.jpeg"),
                      fit: BoxFit.cover)),
            ),
            Container(
              child: Container(
                margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.0, 1.0),
                    // stops: [0.0, 1.0],
                    // colors: <Color>[
                    //   Color(0xFF1E2026).withOpacity(0.1),
                    //   Color(0xFF1E2026).withOpacity(0.3),
                    //   Colors.black.withOpacity(0.6),
                    //   Colors.black.withOpacity(0.7),
                    // ],
                  ),
                ),

                /// Set component layout
                child: ListView(
                  padding: EdgeInsets.all(0.0),
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, bottom: 170.0),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "DELIVERED\nFAST FOOD\nTO YOUR\nDOOR.",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 37.0,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: "Sofia",
                                            letterSpacing: 1.3),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 20.0, right: 20.0),
                                      child: Text(
                                        "Set exact location to find the right restaurant near you.",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w200,
                                            fontFamily: "Sofia",
                                            letterSpacing: 1.3),
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 220.0)),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                /// To create animation if user tap == animation play (Click to open code)
                                tapLogin == 0
                                    ? Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          splashColor: Colors.white,
                                          onTap: () {
                                            setState(() {
                                              tapLogin = 1;
                                            });
                                            _Playanimation();
                                            return tapLogin;
                                          },
                                          child: ButtonCustom(
                                            txt: "Login / Sign Up",
                                            gradient1: Color(0xFFFEE140),


                                          ),
                                        ),
                                      )
                                    : AnimationSplashSignup(
                                        animationController:
                                            animationController.view,
                                      ),
                                Padding(padding: EdgeInsets.only(top: 140.0)),
                              ],
                            ),

                            /// To create animation if user tap == animation play (Click to open code)
                            Container(
                              child: tapSignup == 0
                                  ? Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashColor: Colors.white,
                                        onTap: () {
                                          setState(() {
                                            tapSignup = 1;
                                          });
                                          _Playanimation();
                                          return tapSignup;
                                        },
                                        child: ButtonCustom(
                                          txt: "Connect with Faceboock",
                                          gradient1: Colors.blue,
                                        ),
                                      ),
                                    )
                                  : AnimationSplashGmail(
                                      animationController: animationController.view,
                                    ),
                            ),
SizedBox(height: 10,),

                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 70),
                          child: Container(
                            child: tapGmail == 0
                                ? Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {
                                  setState(() {
                                    tapGmail = 1;
                                  });
                                  _Playanimation();
                                  return tapGmail;
                                },
                                child: ButtonCustom(
                                  txt: "Connect with Gmail",
                                  gradient1: Colors.red[500],
                                ),
                              ),
                            )
                                : AnimationSplashGmail(
                              animationController: animationController.view,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

/// Button Custom widget
class ButtonCustom extends StatelessWidget {
  @override
  String txt;
  GestureTapCallback ontap;
  Color gradient1;



  ButtonCustom({this.txt, this.gradient1});

  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.white,
        child: LayoutBuilder(builder: (context, constraint) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              height: 52.0,
              width: double.infinity,
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(80.0),
               color: gradient1
              ),
              child: Center(
                  child: Text(
                txt,
                style: TextStyle(
                    color: txt == "Login / Sign Up" ? Colors.black : Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Sofia",
                    letterSpacing: 0.9),
              )),
            ),
          );
        }),
      ),
    );
  }
}


/// Set Animation Login if user click button login
class AnimationSplashGmail extends StatefulWidget {
  AnimationSplashGmail({Key key, this.animationController})
      : animation = new Tween(
    end: 900.0,
    begin: 70.0,
  ).animate(CurvedAnimation(
      parent: animationController, curve: Curves.fastOutSlowIn)),
        super(key: key);

  final AnimationController animationController;
  final Animation animation;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.only(bottom: 60.0),
      child: Container(
        height: animation.value,
        width: animation.value,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: animation.value < 600 ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }

  @override
  _AnimationSplashGmailState createState() => _AnimationSplashGmailState();
}


/// Set Animation Login if user click button login
class AnimationSplashLogin extends StatefulWidget {
  AnimationSplashLogin({Key key, this.animationController})
      : animation = new Tween(
          end: 900.0,
          begin: 70.0,
        ).animate(CurvedAnimation(
            parent: animationController, curve: Curves.fastOutSlowIn)),
        super(key: key);

  final AnimationController animationController;
  final Animation animation;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.only(bottom: 60.0),
      child: Container(
        height: animation.value,
        width: animation.value,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: animation.value < 600 ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }

  @override
  _AnimationSplashGmailState createState() => _AnimationSplashGmailState();
}

/// Set Animation Login if user click button login
class _AnimationSplashGmailState extends State<AnimationSplashGmail> {
  @override
  Widget build(BuildContext context) {
    widget.animationController.addListener(() {
      if (widget.animation.isCompleted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => new signupTemplate1()));
        //hello
      }
    });
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: widget._buildAnimation,
    );
  }
}

/// Set Animation signup if user click button signup
class AnimationSplashSignup extends StatefulWidget {
  AnimationSplashSignup({Key key, this.animationController})
      : animation = new Tween(
          end: 900.0,
          begin: 70.0,
        ).animate(CurvedAnimation(
            parent: animationController, curve: Curves.fastOutSlowIn)),
        super(key: key);

  final AnimationController animationController;
  final Animation animation;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.only(bottom: 60.0),
      child: Container(
        height: animation.value,
        width: animation.value,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: animation.value < 600 ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }

  @override
  _AnimationSplashSignupState createState() => _AnimationSplashSignupState();
}

/// Set Animation signup if user click button signup
class _AnimationSplashSignupState extends State<AnimationSplashSignup> {
  @override
  Widget build(BuildContext context) {
    widget.animationController.addListener(() {
      if (widget.animation.isCompleted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => new signupTemplate1()));
      }
    });
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: widget._buildAnimation,
    );
  }
}
