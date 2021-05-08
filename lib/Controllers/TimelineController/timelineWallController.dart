import 'dart:developer';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/CART-PAYMENTS-SCREENS/Payment-method-choosing.dart';
import 'package:flutter/src/widgets/framework.dart' as sss;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:Butomy/Components/widget_style.dart';
import 'package:Butomy/FIREBASE/Fire_Contro/firebaseController.dart';
import 'package:Butomy/Model/TimelineModel/timelineModel.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/drawer_account_requestverification.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_address_book_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/foodi_suggetion_screen.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/timeline_food_wall_detail_page.dart';
import 'package:Butomy/Screen/Template1/B1_Home_Screen/video_list_detail_page.dart';
import 'package:Butomy/Screen/Template1/B4_Cart_Screen/B4_Cart_Screen.dart';
import 'package:Butomy/Screen/Template1/Login_Screen/Alread_Exist_User_Register/email_sign_up.dart';
import 'package:Butomy/Screen/Template1/Login_Screen/Alread_Exist_User_Register/mobile_mob_pass_page.dart';
import 'package:Butomy/Screen/Template1/Login_Screen/Alread_Exist_User_Register/username_sign_up.dart';
import 'package:Butomy/Screen/Template1/Login_Screen/Confirm_OTP_Screen.dart';
import 'package:Butomy/Screen/Template1/Login_Screen/SignIn_Screen.dart';
import 'package:Butomy/Screen/Template1/Login_Screen/Signup_Screen.dart';
import 'package:Butomy/Screen/Template1/Login_Screen/add_profile.dart';
import 'package:Butomy/Screen/Template1/Login_Screen/mob_pass_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart';
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart' as user_repo;
import 'package:Butomy/Repository/TimelineRepository/timelineRepository.dart'
    as repository;

var UserIdPref;

class TimelineWallController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey;
  List timelinePostData=[];
  var userListNamespace;

  List FollowSearchDatatest = [];
  List addressLIST = [];
  List Subcategories = [];
  List KitchenCategories = [];
  List MarketKitchenCategories = [];
  List BlogList = [];
  List FollowingSearchDatatest = [];
  List FoodiSearchDatatest = [];
  List FollowingSearchData = [];
  List AccountPostData = [];
  List suggestionFLIST = [];
  List suggestionRLIST = [];
  List suggestionSLIST = [];
  List suggestionHLIST = [];
  List AccountWall = [];
  var timflag=false;
  var notificationListarr;
  var ReadStatus;

  bool statusAccWall = true;
  bool videoStatus = true;
  bool addressStatus = true;
  bool statusBlog = true;
  bool statusVideo = true;
  bool statusPosts = true;
  bool statusLike = true;
  bool sugStatus = true;
  bool statusComment = true;
  bool statusSavedPost = true;
  bool statusShare = true;
  bool statusFollower = true;
  bool statusParticularPost = true;
  bool statusFollowing = true;
  bool searchStatus = true;
  bool notificationStatus = true;
  bool searchStatusFoodi = true;
  bool searchStatusFollow = true;
  bool searchStatusFollowing = true;
  bool searchStatusOtherFollow = true;
  bool searchStatusOtherFollowing = true;
  List AccountWallVideos = [];
  var savePostInfo;
  var followingInfo;
  var saveOtherUserInfo;
  var saveUserInfo;
  var SEARCHARRAY;
  List searchPOSTS = [];
  List searchFOODIS = [];
  List searchMARKET = [];
  List searchSTORE = [];
  List searchKITCHEN = [];
  List searchBANK = [];
  List searchRESTAURANT = [];
  List  timelineComments = [];

  List timelineLikeList = [];
  List LikeFoodiSearchDatatest = [];
  bool likesearchStatusFoodi = true;
  List followersList = [];
  List fullVideosList = [];
  List ParticularPost = [];
  List followingList = [];
  List businessFollowingList = [];
  List timelineShareList = [];
  var deleteTimeWallData;
  var reportTimeWallData;
  var likeposttim = [];
  var savePostStorage;
  var followerInfo;
  var likefollowerInfo;
  var postImage;
  var postVideo;
  var likecmnttim;
  var timelinepostshare;
  var timcommnetlikestatus;

  TimelineWallController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void setUserId(userIdPassed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userIdPassed);
  }



  void setEmail(Email) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Email', Email);

  }

  void setPassword(PAss) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Password', PAss);

  }

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserIdPref = prefs.getString('userId');

  }
  void addProfileImage(context,profImg,UserIds,otpp) async {

    repository.profileImage(profImg,UserIds).then((value) {
      if (value != null) {

        setUserId(UserIds.toString());
        getAbout(UserIds);
        if (value["status"].toString() == "200") {
          // Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
          setState((){
            userid=UserIds;
          });

          Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (_, __, ___) => ConfirmOtpPage(OTPMessage: otpp.toString())));
        } else {
          //Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Otp');
          Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (_, __, ___) => signinTemplate1()));
        }
      } else {

        Navigator.of(context).pushReplacement(
            PageRouteBuilder(pageBuilder: (_, __, ___) => signinTemplate1()));
      }
    });
  }

  void DistrictList (stateid)  async {
    repository.getDistrictList(stateid).then((value) {
      setState(() => DISTRICTS = value);
    });
  }

  void stateList ()  async {
    repository.getStateList().then((value) {
      setState(() => STATES = value);
    });
  }

  void register(context,name,surname,email,dob,gender,mobile,password,location_lat,location_long,token,state,district,locc,lastname) async {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.signUp(name,surname,email,dob,gender,mobile,password,location_lat,location_long,token,state,district,locc,lastname).then((value) {
        if (value != null) {
          if (value['status'].toString() == "200") {
            // Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
            var otp = value['otp'].toString();
            setState((){
              timelineIdFoodi=value['timeline_id'].toString();
              userid=value['id'].toString();
              userNAME=surname.toString();
              NAME=name.toString();
              LNAME=lastname.toString();
              EMAIL=email.toString();
              PHONE=mobile.toString();
              fire_id="";
              fire_name="";
              fire_username="";
              fire_id=value['id'].toString();
              fire_name=name.toString();
              fire_username=surname.toString();
            });
            setUserId(userid.toString());
            setEmail(email.toString());
            setPassword(password.toString());
            Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (_, __, ___) => AddProfilePage(
                    tim_id: value['timeline_id'].toString(),
                    userid: userid.toString(),otp:otp.toString())));
          } else {
            Fluttertoast.showToast(
                msg:value["message"].toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 10,
                backgroundColor: Color(0xFF48c0d8),
                textColor: Colors.white,
                fontSize: 16);
            if(value["message"].toString()=="Username Already Taken")
            {
              Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ExistUserNameSignUp(dob: dob,email: email,gender: gender,name: name,surname: surname,
                  lastname: lastname,)));
            }
            else if(value["message"].toString()=="Email Already Registered")
            {
              Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ExistEmailSignUp(email: email,dob: dob,surname: surname,name: name,gender: gender,
                    lastname: lastname,
                  )));
            }
            else if(value["message"].toString()=="Mobile Number Already Registered")
            {
              Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => AlreadyExistMobilePasswordPage(
                    district: district,lastname: lastname,
                    state: state,
                    email: email,dob: dob,surname: surname,name: name,gender: gender,
                    mobile: mobile,pass: password,lat: location_lat,long: location_long,loc: locc,)));
            }
            //Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Otp');
            else
            {
              Navigator.of(context).pushReplacement(
                  PageRouteBuilder(pageBuilder: (_, __, ___) => signupTemplate1()));
            }
          }
        } else
          {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(pageBuilder: (_, __, ___) => signupTemplate1()));
        }
      });
    }
  }

  void otp(context,otp,userid) async {
      //loginFormKey.currentState.save();
      repository.Otp(otp,userid).then((value) {
        print("NEWWWWW ACCCOUNTTT RESPONSS : "+value.toString());
        if (value != null) {
          if (value["status"].toString() == "200") {
            setState((){userid=value["id"].toString();
            });
            getAbout(userid);
            setUserId(userid.toString());
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) => SuggestionScreen(uid: value["id"].toString())), (route) => false);
            // splashgetTimelineWall(userid.toString());
          } else {
            setState((){userid=value["id"].toString();});
            setUserId(userid.toString());
            Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (_, __, ___) => ConfirmOtpPage(OTPMessage: value["message"].toString(),)));
          }
        } else {

          Navigator.of(context).pushReplacement(
              PageRouteBuilder(pageBuilder: (_, __, ___) => signinTemplate1()));
        }
      });

  }

  void resendOtp(context,userid) async {

      repository.ResendOtp(userid).then((value) {
        if (value != null) {
          if (value["status"].toString() == "200") {
            setState((){
              userid=value["id"].toString();
            });
            setUserId(userid.toString());
            Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (_, __, ___) => ConfirmOtpPage(
                  OTPMessage: value["otp"].toString(),
                )));
          } else {
            Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (_, __, ___) => ConfirmOtpPage(OTPMessage: "please Click resend Otp",)));
          }
        } else {

          Navigator.of(context).pushReplacement(
              PageRouteBuilder(pageBuilder: (_, __, ___) => signinTemplate1()));
        }
      });

  }

  void login(context,email,password) async {
    if (loginFormKey.currentState.validate()) {
      repository.signIn(email,password).then((value)async {
        if (value != null) {
          /*setState((){
            userid=value["id"].toString();
          });*/
          if (value["status"].toString() == "200")  {

            setState((){
              userid=value["id"].toString();
              timelineIdFoodi=value['timeline_id'].toString();
            });
            print("loginnnnnnnnnnnnn "+value.toString());
            getAbout(userid);
            setUserId(value['id'].toString());
            final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
            String token = await _firebaseMessaging.getToken();
            print("token %%%%%%%%%%%%%%%%%%%% ");
            print(token);
            setState(() {
              fire_token = token.toString();
            });
            FirebaseController.instanace.updateToken(timelineIdFoodi.toString(),token.toString());
            tokenEditAccount(token.toString());
            splashgetTimelineWall(context,userid.toString());
          } else if (value["status"].toString() == "201") {
            Fluttertoast.showToast(
                msg:value["message"].toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 10,
                backgroundColor: Color(0xFF48c0d8),
                textColor: Colors.white,
                fontSize: 16.0
            );
            repository.ResendOtp(userid).then((value) {
              if (value["status"]== "200") {
                setState((){
                  userid=value["id"].toString();
                });
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => ConfirmOtpPage(
                      OTPMessage: value["otp"].toString(),
                    )));
              } else {
              }
            });
          } else {
            Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (_, __, ___) => signinTemplate1()));
          }
        } else {
          Navigator.of(context).pushReplacement(
              PageRouteBuilder(pageBuilder: (_, __, ___) => signinTemplate1()));
        }
      });
    }
  }

 /* void UUUUUUUUUUUUUUUUgetAbout(user) async {
    repository.AboutInfo(user).then((value) {
      setState(()  {saveUUUUUUUUUUserInfo = value;
      setFiredata(value["data"][0]["device_token"].toString(),user);
      userNAME=value["data"][0]["username"].toString();
      userPIC=value["data"][0]["picture"].toString().replaceAll(" ", "%20")+"?alt=media";
      NAME=value["data"][0]["name"].toString();


      }
      );
    } );
  }*/

  TimelineData tim_wall = new TimelineData();


  void setFiredata(token,id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('FCMToken', token);
    await prefs.setString('userId',id);
  }
  void notification(userid) async {
    repository.notificationList(userid). then((value) {
      setState(() {
        notificationListarr = value;
        NOTIFICATIONLIST=value;
        notificationStatus=false;
        notificationReadStatus = value["unseencount"];
      },
      );
      if (value != null) {

      } else {
      }
    });
  }
  void notificationRead(userid) async {
    repository.notificationReadAll(userid). then((value) {

      setState(() {
        ReadStatus = value;
        notificationReadStatus = 0;
      },
      );
      if (value != null) {
      } else {
      }
    });
  }


 /* void notification(userid) async {
    Stream<List> stream = new Stream.fromFuture(notificationList(userid));
    stream.listen((data) {
      setState(() {
        notificationListarr = data;
        notificationStatus=false;
        notificationCount=data.length;
      });
    }, onDone: () {}, onError: (error) {});
  }*/

  void FollowingSearch(desc,userid) async {

    Stream<List> stream = new Stream.fromFuture(FollowingSearchRepo(desc,userid));
    stream.listen((data) {
      setState(() {

        FollowingSearchDatatest = data;
        searchStatusFollowing= false;

      });
      getAbout(userid);

    }, onDone: () {}, onError: (error) {});
  }

  void LikeSearch(desc,userid) async {

    Stream<List> stream = new Stream.fromFuture(LikFoodiSearchRepo(desc,userid));
    stream.listen((data) {
      setState(() {

        LikeFoodiSearchDatatest = data;
        likesearchStatusFoodi= false;

      });

    }, onDone: () {}, onError: (error) {});
  }

  void getUsers ()  async {
    repository.userListNamespace().then((value) {
      setState(() => userListNamespace = value);
      if (value != null) {
      } else {
      }
    });
  }


  void getTimelineWall(userId) async {
    Stream<List> stream = new Stream.fromFuture(getTimeWall(userId));
    stream.listen((data) {
      setState(() {
        timelinePostData = timelinePostData+data;
        Splashtotimdata=timelinePostData;
        starttim=0;
        timflag=true;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void getTimelineWallStart(userId) async {
    setState((){ starttim=0;});
    Stream<List> stream = new Stream.fromFuture(getTimeWall(userId));
    stream.listen((data) {
      setState(() {
        timelinePostData = data;
        Splashtotimdata=timelinePostData;
        starttim=0;
        timflag=true;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void splashgetTimelineWall(context,userId,) async {
    // getAbout(userid.toString());
    Stream<List> stream = new Stream.fromFuture(getTimeWall(userId));
    stream.listen((data) {
      setState(() {
        timelinePostData = data;
        timflag=true;
        Splashtotimdata=timelinePostData;
        starttim=0;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TimeLine(false)));
    }, onDone: () {}, onError: (error) {});
  }

  void getTimCommentPage(postid, userid) async {
    Stream<List> stream =
        new Stream.fromFuture(getTimelineCommentList(postid, userid));
    stream.listen((data) {
      setState(() {
        timelineComments = data;
        // timelineComments11=data;
        statusComment = false;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void getTimlike(postid,userid) async {
    Stream<List> stream = new Stream.fromFuture(getTimelineLike(postid,userid));
    stream.listen((data) {
      setState(() {
        timelineLikeList = data;
        statusLike=false;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void postTimCommntReply(postid, userid, desc,cmntId) async {
    repository.postTimelineCommentReplyList(postid, userid, desc,cmntId).then((value) {
      if (value != null) {

        if (value['status'] == "200") {
          getTimCommentPage(postid.toString(), userid.toString());
        }
      } else {
      }
    });
  }


  void getTimshare(postid) async {
    Stream<List> stream = new Stream.fromFuture(getTimelineShare(postid));
    stream.listen((data) {
      setState(() {
        timelineShareList = data;
        statusShare = false;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void postTimCommnt(postid, userid, desc) async {
    repository.postTimelineCommentList(postid, userid, desc).then((value) {
      if (value != null) {
        if (value['status'] == "200") {
         getTimCommentPage(postid.toString(), userid.toString());
        }
      } else {}
    });
  }

  void deleteTimCommnt(commenttid, userid) async {
    repository.deleteTimelineCommentList(commenttid, userid).then((value) {
      if (value != null) {
        if (value["status"] == "200") {
          getTimelineWall(userid);
          savePostListController(userid.toString());
          getAccountWallImage(userid.toString());
        } else {}
      } else {}
    });
  }

  void reportTimeWall(userid, post_id) async {
    repository.reportTimelineWall(userid, post_id).then((value) {
      setState(() => reportTimeWallData = value);
      getTimelineWall(userid);
      getAccountWallImage(userid.toString());
    });
  }

  void deleteTimelineWall(userid, post_id) async {
    repository.deleteTimeWall(userid, post_id).then((value) {
      print("delete post success : "+value.toString());
      setState(() => deleteTimeWallData = value);
      getTimelineWallStart(userid);
      savePostListController(userid.toString());
      getAccountWallImage(userid.toString());
    });
  }

  void likePostTime(userid, post_id) async {
    Stream<List> stream =
        new Stream.fromFuture(likePostTimeline(userid, post_id));
    stream.listen((data) {
      // getTimelineWall(userid.toString());
      setState(() => likeposttim = data);

      setState(() {
        likesCountApi = likeposttim[0]["likecount"].toString();
      });

      // savePostListController(userid.toString());
      // getAccountWallImage(userid.toString());
    }, onDone: () {}, onError: (error) {});
  }

  void likeOtherPostTime(userid, post_id, id) async {
    Stream<List> stream =
        new Stream.fromFuture(likeOtherPostTimeline(userid, post_id));
    stream.listen((data) {
      setState(() => likeposttim = data);

      setState(() {
        likesCountApi = likeposttim[0]["likecount"].toString();
      });
      // getPersonalPosts(id,userid);
      // getAccountWallVideos(id.toString(),"video",userid);
    }, onDone: () {}, onError: (error) {});
  }

  void likeSearchPostTime(userid, post_id, text) async {
    Stream<List> stream =
        new Stream.fromFuture(likePostTimeline(userid, post_id));
    stream.listen((data) {
      setState(() => likeposttim = data);
      setState(() {
        likesCountApi = likeposttim[0]["likecount"].toString();
      });
      getTimelinesearch(text);
      getTimelineWall(userid);
    }, onDone: () {}, onError: (error) {});
  }

  void likeComment(userid, commenttid) async {
    repository.likeCommnetTimeline(userid, commenttid).then((value) {
      likecommentstatus = value;
      if (value['status'] == "200") {
      } else {}
    });
  }

  void saveTimelinePost(post_id, userid) async {
    repository.savePost(post_id.toString(), userid.toString()).then((value) {
      setState(() => savePostStorage = value);
      // getTimelineWall(userid);
      savePostListController(userid.toString());
      // getAccountWallImage(userid.toString());
    });
  }

  void saveOtherPost(post_id, userid, id) async {
    repository.savePost(post_id.toString(), userid.toString()).then((value) {
      setState(() => savePostStorage = value);
      // getPersonalPosts(id,userid);
      // getAccountWallVideos(id.toString(),"video",userid);
    });
  }

  void editProfile(context,
      userid, email, mobile, gender, dob, foodpref, name, username,favdish,loc,lat,longg,lastname,bio,emailshow,mobshow,locshow,stateshow,distshow,dobshow) async {
    repository
        .editProf(userid, email, mobile, gender, dob, foodpref, name, username,favdish,loc,lat,longg,lastname,bio,emailshow,mobshow,locshow,stateshow,distshow,dobshow)
        .then((value) {
      if (value['status'] == "200") {
        getAbout(userid);
        Navigator.pop(context);
      } else {}
    });
  }

  void getFollowers(userid,parentid) async {
    Stream<List> stream = new Stream.fromFuture(getFollowersList(userid,parentid));
    stream.listen((data) {
      setState(() {
        followersList = data;
        statusFollower = false;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void gettimelineparticularpost(posti) async {
    Stream<List> stream = new Stream.fromFuture(getParticularPost(posti));
    stream.listen((data) {
      setState(() {
        ParticularPost = data;
        statusParticularPost = false;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void getFollowing(userid) async {
    repository.getFollowingList(userid).then((data) {
      setState(() {
        followingList = data["following"];
        businessFollowingList = data['business_following'];
        statusFollowing = false;
      });
      print("FFFFFFFFFFFFFFFFf "+followingList.toString());
    });
  }

  void getOtherFollowing(userid,parr) async {
    repository.getOtherFollowingList(userid,parr).then((data) {
      setState(() {
        followingList = data["following"];
        businessFollowingList = data['business_following'];
        statusFollowing = false;
      });
    });
  }



  void getTimelinesearch(desc) async {
    print("searchh 2222222222222 ");
    repository.getTimeSearch(desc).then((value) {
      setState(() {
        SEARCHARRAY=value;
        searchPOSTS = value["posts"];
        searchFOODIS = value["foodies"];
        searchMARKET = value["foodiemarket"];
        searchSTORE = value["localstore"];
        searchKITCHEN = value["homekitchen"];
        searchBANK = value["foodbank"];
        searchRESTAURANT = value["restaurant"];
        searchStatus = false;
      });
      print("searchh 555555555555555555555555  "+value.toString());
    });
  }

  void getAccountWall(userid) async {
    Stream<List> stream = new Stream.fromFuture(getAccWall(userid));
    stream.listen((data) {
      setState(() {
        AccountWall = data;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void followerController(useridCon, followeridCon) async {
    repository.FollowerRepo(useridCon, followeridCon).then((value) {
      getAbout(userid);
      user_repo.OtherAboutInfo1(userid);
      getOtherAbout(followeridCon,useridCon);
      setState(() => followerInfo = value);
    });
  }

  void sugfollowerController(useridCon, followeridCon) async {
    repository.FollowerRepo(useridCon, followeridCon).then((value) {

    });
  }

  void searchFolloooowww(useridCon, followeridCon) async {
    repository.FollowerRepo(useridCon, followeridCon).then((value) {
      setState(() => followerInfo = value);
    });
  }

  void likefollowerController(useridCon, followeridCon) async {
    repository.FollowerRepo(useridCon, followeridCon).then((value) {
      setState(() => likefollowerInfo = value);
    });
  }

  void getPersonalPosts(tim,acc) async {
    Stream<List> stream = new Stream.fromFuture(getPersonPost(tim,acc));
    stream.listen((data) {
      setState(() {
        AccountPostData = data;
        statusPosts = false;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void posttimelineDescPost1(context,userid, description,pic,title,desc,site,link) async {
    print("urlll 444444444444444 : "+urlPost.toString());
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>TimeLine(false)
    ));
    repository.TimelineDescPost1(userid, description,pic,title,desc,site,link).then((value) {
      Fluttertoast.showToast(
        msg: " Uploaded Post ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Color(0xFF48c0d8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      user_repo.OtherAboutInfo1(userid);
      // splashgetTimelineWall(userid.toString());
      setState(() => postImage = value);
    });
  }

  void posttimelineDescPost2(context,userid, description,loc,lat,long,pic,title,desc,site,link) async {
    print("urlll 22222222222222 : "+pic.toString());
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>TimeLine(false)
    ));
    repository.TimelineDescPost2(userid, description,loc,lat,long,pic,title,desc,site,link).then((value) {
      Fluttertoast.showToast(
        msg: " Uploaded Post ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Color(0xFF48c0d8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      user_repo.OtherAboutInfo1(userid);
     // splashgetTimelineWall(userid.toString());
      setState(() => postImage = value);
    });
  }

  void editPostTimelineDesc(context,description, post) async {
    repository.EditPostTimDesc(description, post).then((value) {
      getTimelineWallStart(userid.toString());
      Navigator.pop(context);
      setState(() => postImage = value);
    });
  }

  void editPostTimelineImage(context,description, postid,img,type) async {
    repository.EditPostTimImage(description, postid,img,type).then((value) {
      getTimelineWallStart(userid.toString());
      Navigator.pop(context);
      setState(() => postImage = value);
    });
  }

  void editPostTimelineVideo(context,description, postid,vdo) async {
    repository.EditPostTimVideo(description, postid,vdo).then((value) {
      getTimelineWallStart(userid.toString());
      Navigator.pop(context);
      setState(() => postImage = value);
    });
  }

  void posttimelineWallPost1(context,userid, description, image, type,loc,lat,long) async {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>TimeLine(true)
    ));
    repository.TimelineWallPost1(userid, description, image, type,loc,lat,long).then((value) {
      user_repo.OtherAboutInfo1(userid);
      // splashgetTimelineWall(userid.toString());
      setState(() => postImage = value);
    });
  }

  void posttimelineWallPost2(context,userid, description, image, type,) async {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>TimeLine(true)
    ));
    repository.TimelineWallPost2(userid, description, image, type,).then((value) {

      user_repo.OtherAboutInfo1(userid);
      // splashgetTimelineWall(userid.toString());
      setState(() => postImage = value);
    });
  }

  void foodieBlog(context,userid, title,desc, type,imageList,utube,location,locLat,locLong) async {
    imageList.toString()!="" && imageList!= null ? Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>TimeLine(true)
    )) : Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>TimeLine(false)
    ));
    repository.foodieBlogRepo(userid, title,desc, type,imageList,utube,location,locLat,locLong)
        .then((value) {
      user_repo.OtherAboutInfo1(userid);
      splashgetTimelineWall(context,userid.toString());
      // splashgetTimelineWall(userid.toString());
      setState(() => postImage = value);
    });
  }

  void foodieBlogVideo(context,userid, title,desc, type,imageList,videoo,location,locLat,locLong) async {
    repository.foodieBlogVideoRepo(userid, title,desc, type,imageList,videoo,location,locLat,locLong)
        .then((value) {
      setState((){
        daaaaaaaaaaaaa =false;
      });
      user_repo.OtherAboutInfo1(userid);
      splashgetTimelineWall(context,userid.toString());
      // splashgetTimelineWall(userid.toString());
      setState(() => postImage = value);
    });
  }

  void postBlogPost1(context,userid, description, image, type,_location,lat,lng,title) async {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>TimeLine(true)
    ));
    repository.BlogPost1(userid, description, image, type, _location,lat,lng,title)
        .then((value) {
      user_repo.OtherAboutInfo1(userid);
      splashgetTimelineWall(context,userid.toString());
      // splashgetTimelineWall(userid.toString());
      setState(() => postImage = value);
    });
  }

  void postBlogPost2(context,userid, description, image, type, title,) async {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>TimeLine(true)
    ));
    repository.BlogPost2(userid, description, image, type, title,)
        .then((value) {
      user_repo.OtherAboutInfo1(userid);
      splashgetTimelineWall(context,userid.toString());
      // splashgetTimelineWall(userid.toString());
      setState(() => postImage = value);
    });
  }

  void postBlogPost4(context,userid, description, image, type,_location,lat,lng,title,video) async {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>TimeLine(true)
    ));
    repository.BlogPost4(userid, description, image, type, _location,lat,lng,title,video)
        .then((value) {
      user_repo.OtherAboutInfo1(userid);
      splashgetTimelineWall(context,userid.toString());
      // splashgetTimelineWall(userid.toString());
      setState(() => postImage = value);
    });
  }

  void postBlogPost3(context,userid, description, image, type, title,video) async {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>TimeLine(true)
    ));
    repository.BlogPost3(userid, description, image, type, title,video)
        .then((value) {
      user_repo.OtherAboutInfo1(userid);
      splashgetTimelineWall(context,userid.toString());
      // splashgetTimelineWall(userid.toString());
      setState(() => postImage = value);
    });
  }

  void followingController(useridCon, followingidCon) async {
    repository.FollowerRepo(useridCon, followingidCon).then((value) {
      setState(() => followingInfo = value);
    });
  }

  void foodieVideoPost(context,userid, description, video,_location,lat,lng) async {
    repository.foodieVideoPost(userid, description, video,_location,lat,lng).then((value) {
      user_repo.OtherAboutInfo1(userid);
      setState((){
        daaaaaaaaaaaaa =false;
      });
      splashgetTimelineWall(context,userid.toString());
      setState(() {
        postVideo = value;
      });
    });
  }

  void posttimelineOwnVideoPost2(context,userid, description, video,ext) async {
    print("callingg videoo 11111");
    repository.TimelineOwnVideoPost2(userid, description, video,ext).then((value) {
      print("setdrfgh video ress -> "+value.toString());
      user_repo.OtherAboutInfo1(userid);
      videoStatus = false;
      setState((){
        daaaaaaaaaaaaa =false;
      });
      splashgetTimelineWall(context,userid.toString());
      Fluttertoast.showToast(msg: "Video Uploaded", toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Color(0xFF48c0d8),
        textColor: Colors.white,
        fontSize: 16.0,);
      setState(() {

        postVideo = value;
      });
    });
  }



  void foodieYoutubePost(context,userid, description, video,_location,lat,lng) async {
    repository.foodieYoutubePost(userid, description, video,_location,lat,lng).then((value) {
      user_repo.OtherAboutInfo1(userid);
      splashgetTimelineWall(context,userid.toString());
      setState(() {
        postVideo = value;
      });
    });
  }

  void posttimelineUTubeVideoPost2(context,userid, description, video,) async {
    repository.TimelineUTubeVideoPost2(userid, description, video,).then((value) {
      user_repo.OtherAboutInfo1(userid);
      splashgetTimelineWall(context,userid.toString());
      setState(() {
        postVideo = value;
      });
    });
  }

  void postBlogimagewithvideo(context,userid, description, image, type, title,video,_location,lat,lng) async {
    repository.postBlogimageOwnVideoPost(userid, description, image, type, title,video,_location,lat,lng).then((value) {
      user_repo.OtherAboutInfo1(userid);
      setState((){
        daaaaaaaaaaaaa =false;
      });
      splashgetTimelineWall(context,userid.toString());

      setState(() {
        postVideo = value;
      });
    });
  }

  void postBlogimagewithvideo2(context,userid, description, image, type, title,video,ext) async {
    print("callingg videoo 11111");
    repository.postBlogimageOwnVideoPost2(userid, description, image, type, title,video).then((value) {
      print("setdrfgh video ress -> "+value.toString());
      user_repo.OtherAboutInfo1(userid);
      videoStatus = false;
      setState((){
        daaaaaaaaaaaaa =false;
      });
      splashgetTimelineWall(context,userid.toString());

      setState(() {
        postVideo = value;
      });
    });
  }

  void postBlogwithvideo(context,userid, description, type, title,video,_location,lat,lng) async {
    repository.postBlogOwnVideoPost(userid, description, type, title,video,_location,lat,lng).then((value) {
      user_repo.OtherAboutInfo1(userid);
      setState((){
        daaaaaaaaaaaaa =false;
      });
      splashgetTimelineWall(context,userid.toString());

      setState(() {
        postVideo = value;
      });
    });
  }

  void postBlogwithvideo2(context,userid, description, type, title,video,ext) async {
    print("callingg videoo 11111");
    repository.postBlogOwnVideoPost2(userid, description, type, title,video).then((value) {
      print("setdrfgh video ress -> "+value.toString());
      user_repo.OtherAboutInfo1(userid);
      videoStatus = false;
      setState((){
        daaaaaaaaaaaaa =false;
      });
      splashgetTimelineWall(context,userid.toString());

      setState(() {
        postVideo = value;
      });
    });
  }

  void postBlogVideoPost1(context,userid, description, video, categry,_location,lat,lng) async {
    repository.BlogVideoPost1(userid, description, video, categry,_location,lat,lng).then((value) {
      user_repo.OtherAboutInfo1(userid);
      splashgetTimelineWall(context,userid.toString());
      setState(() {
        postVideo = value;
      });
    });
  }

  void postBlogVideoPost2(context,userid, description, video, categry,) async {
    repository.BlogVideoPost2(userid, description, video, categry,).then((value) {
      user_repo.OtherAboutInfo1(userid);
      splashgetTimelineWall(context,userid.toString());
      setState(() {
        postVideo = value;
      });
    });
  }

  void FollowSearch(desc,userid) async {

    Stream<List> stream = new Stream.fromFuture(FollowSearchRepo(desc,userid));
    stream.listen((data) {
      setState(() {
        FollowSearchDatatest = data;
        searchStatusFollow= false;
      });
      getAbout(userid);

    }, onDone: () {}, onError: (error) {});
  }

  void getAccountWallImage(timid) async {
    Stream<List> stream = new Stream.fromFuture(getAccWallImage(timid));
    stream.listen((data) {
      setState(() {
        AccountWall = data;
        ACCCWall=AccountWall;
        acc = false;
        statusAccWall = false;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void getAccountWallVideos(timid, type,acc) async {
    Stream<List> stream = new Stream.fromFuture(getAccWallVideos(timid, type,acc));
    stream.listen((data) {
      var fullVideoLength;
      print("Foodi full video length : "+data.length.toString());
      setState(() {
        AccountWallVideos = [];
        fullVideoLength =0;
      });
      for(int i=0;i<data.length;i++){

        fullVideoLength = AccountWallVideos.length;
        if(data[i]["youtube_video_id"].toString().length==11 && data[i]["youtube_video_id"]!=null){
          setState(() {
            AccountWallVideos.insert(fullVideoLength, data[i]);
          });
        }
      }
      print("Foodi utube video length : "+AccountWallVideos.length.toString());
      setState(() {
        statusVideo = false;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void savePostListController(userid) async {
    Stream<List> stream = new Stream.fromFuture(savePostRepo(userid));
    stream.listen((data) {
      setState(() {
        savePostInfo = data;
      statusSavedPost = false;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void getOtherAbout(userid,parentid) async {
    repository.OtherAboutInfo(userid,parentid).then((value) {
      setState(() => saveOtherUserInfo = value);
      print(value.toString());
    });
  }
  void getOtherAbout1(userid) async {
    repository.OtherAboutInfo1(userid).then((value) {
      setState(() => saveOtherUserInfo = value);
    });
  }

  void getAbout(userid)  {
    repository.OtherAboutInfo1(userid).then((value) {
      print("userrrrr "+value.toString());
      setFiredata(value["data"][0]["device_token"].toString(),userid);
      setState(()  {saveUserInfo = value;
      userNAME=value["data"][0]["username"].toString();
      userPIC=value["data"][0]["picture"].toString()+"?alt=media";
      NAME=value["data"][0]["name"].toString();
      LNAME=value["data"][0]["lastname"].toString();
      EMAIL=value["data"][0]["email"].toString();
      PHONE=value["data"][0]["mobile"].toString();
      timelineIdFoodi=value["data"][0]['timeline_id'].toString();
      user_location=value["data"][0]["current_location"].toString();
      user_lat=value["data"][0]["location_lat"].toString();
      user_long=value["data"][0]["location_long"].toString();
      }
      );
    } );
  }

  void getIDS(userid)  {
    repository.GetIDSRepooo(userid).then((value) {
      print("IDDDSSSSS "+IDS.toString());
      setState(() {
        statusAccWall = false;
        IDS=value;
        Market_pageid=value["food_market"][0]["page_id"].toString();
        Market_timid=value["food_market"][0]["timeline_id"].toString();
        Foodbank_pageid=value["food_bank"][0]["page_id"].toString();
        Foodbank_timid=value["food_bank"][0]["timeline_id"].toString();
      });
    } );
  }

  void updateIDStatus(page_id,status,bustype,ind) async {
    repository.updateIdStatusRepoo(page_id,status).then((value) {
      if (value != null) {
        if (value["status"].toString() == "200") {
        setState((){
          bustype=="1" ? IDS["home_kitchen"][ind]["verify_status"]=status :
          bustype=="2" ? IDS["local_store"][ind]["verify_status"]=status :
          bustype=="3" ? IDS["restaurant"][ind]["verify_status"]=status :
          null;
        });

        } else {
          Fluttertoast.showToast(msg: value["message"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 35,
            backgroundColor: Color(0xFF48c0d8),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {}
    });
  }

  void adduserProfileImage(profImg, UserIds) async {
    repository.profileImage(profImg, UserIds).then((value) {
      if (value != null) {
        if (value["status"].toString() == "200") {
        } else {

        }
      } else {}
    });
  }
  void shareTimelinePost(context,user,desc,post) async {
    repository.shareTimPost(user,desc,post).then((value) {
      if (value != null) {
        if (value["status"].toString() == "200") {
          getTimelineWallStart(userid.toString());
          Fluttertoast.showToast(msg: "Post Shared Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 35,
            backgroundColor: Color(0xFF48c0d8),
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(msg: value["message"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 35,
            backgroundColor: Color(0xFF48c0d8),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {

      }
    });
  }

  void getUseranametoId(context,username) async {
    repository.UserNametoID(username).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TimelineFoodWallDetailPage(id: value.toString(),)));
    } );
  }
/*Username Already Exists*/
  /*User Email Already Exists*/
  void register_Username_Email_Validation(context,name,username,email,dob,gender,lastname) async {
    repository.username_Email_validation_Repoo(username,email).then((value) {
      print("returnnn validation data "+value.toString());

      if(value["status"]=="200")
        {
           Navigator.of(context).push(
          PageRouteBuilder(
              pageBuilder: (_, __, ___) =>
                  MobilePasswordPage(
                    name: name,
                    surname: username,
                    email: email,
                    dob: dob,
                    gender: gender,lastname: lastname,
                  )));
        }
     else if(value["status"]=="201" && value["message"]== "Username Already Exists")
        {
          Fluttertoast.showToast(msg: value["message"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 35,
            backgroundColor: Color(0xFF48c0d8),
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (_, __, ___) => ExistUserNameSignUp(
                lastname: lastname,
                dob: dob,email: email,gender: gender,name: name,surname: username,)));
        }
      else if(value["status"]=="201" && value["message"]== "User Email Already Exists")
        {
          Fluttertoast.showToast(msg: value["message"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 35,
            backgroundColor: Color(0xFF48c0d8),
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (_, __, ___) => ExistEmailSignUp(
                lastname: lastname,
                email: email,dob: dob,surname: username,name: name,gender: gender,)));
        }
      else
        Container();
    } );
  }

  void AddtoPurchaseList(user_id,products_id,business_type,customers_basket_quantity,final_price,page_id) async {
    Fluttertoast.showToast(msg: "Added to Bucket",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 35,
      backgroundColor: Color(0xFF48c0d8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    repository.AddPurchaseListRepoo(user_id,products_id,business_type,customers_basket_quantity,final_price,page_id)
        .then((value) {
      getPurchaseList(userid.toString());
    });
  }

  void getPurchaseList(user_id) async {
    repository.GetPurchaseListRepoo(user_id.toString())
        .then((value) {
      setState((){
        PURCHASELIST=value["data"];
        purchasecount=value["data"].length;
      });
    });
  }

  void BusinessFollowunFollow(pageId,userId) async {
    // getHome();
    repository.PageFollower(pageId.toString(),userId.toString(),).then((value) {

    });
  }

  void getSubCategories(parentId) async {
    Stream<List> stream = new Stream.fromFuture(categoryListRepo(parentId));
    stream.listen((data) {
      setState(() {
        Subcategories = data;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void getKitchenCategories(parentId) async {
    Stream<List> stream = new Stream.fromFuture(categoryListRepo(parentId));
    stream.listen((data) {
      setState(() {
        KitchenCategories = data;
        KitCat=KitchenCategories;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void getMarketCategories(parentId) async {
    Stream<List> stream = new Stream.fromFuture(categoryListRepo(parentId));
    stream.listen((data) {
      setState(() {
        MarketKitchenCategories = data;
        MKitCat=KitchenCategories;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void FoodiMarket1(context,pageid, description, images, type,loc,lat,long,itemname,price,catid,) async {
    print("testttttttt 1111");
    print("callll 444444444444");
    repository.FoodiMarketRepoo1(pageid, description, images, type,loc,lat,long,itemname,price,catid).then((value) {
      setState(() => postImage = value);
      Fluttertoast.showToast(msg: value["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Color(0xFF48c0d8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
     splashgetTimelineWall(context,userid.toString());
    });
  }

  void FoodiMarket2(context,pageid, description, image, type,itemname,price,catid) async {
    print("callll 5555555555555");
    repository.FoodiMarketRepoo2(pageid, description, image, type,itemname,price,catid).then((value) {
      setState(() => postImage = value);
      Fluttertoast.showToast(msg: value["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Color(0xFF48c0d8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      splashgetTimelineWall(context,userid.toString());
    });
  }

  void FoodiBank1(context,pageid, description, images, type,loc,lat,long,itemname,price,catid,) async {
    print("testttttttt 1111");
    print("callll 444444444444");
    repository.FoodiBankRepoo1(pageid, description, images, type,loc,lat,long,itemname,price,catid).then((value) {
      setState(() => postImage = value);
      Fluttertoast.showToast(msg: value["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Color(0xFF48c0d8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      splashgetTimelineWall(context,userid.toString());
    });
  }

  void FoodiBank2(context,pageid, description, image, type,itemname,price,catid) async {
    print("callll 5555555555555");
    repository.FoodiBankRepoo2(pageid, description, image, type,itemname,price,catid).then((value) {
      setState(() => postImage = value);
      Fluttertoast.showToast(msg: value["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Color(0xFF48c0d8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      splashgetTimelineWall(context,userid.toString());
    });
  }

  void getAccountBlog(timeline) async {
    Stream<List> stream = new Stream.fromFuture(getAccountBlogRepoo(timeline));
    stream.listen((data) {
      setState(() {
        BlogList = data;
        statusBlog=false;
        BLOGLIST=BlogList;
      });
    }, onDone: () {}, onError: (error) {});
  }

  void addLocationAddress(context,loc_name,address,lat,long,landmark,houseno,locmain) async {
    print("testttttttt 1111");
    repository.addLocationRepooo(loc_name,address,lat,long,landmark,houseno,locmain).then((value) {
     if(value["status"].toString()=="200")
      {getAddressList(context,"0");
      Fluttertoast.showToast(msg: value["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Color(0xFF48c0d8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(
              builder: (context) => FoodiAddressBookPage()));
      }
     else{
       Fluttertoast.showToast(msg: value["message"].toString(),
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.TOP,
         timeInSecForIosWeb: 35,
         backgroundColor: Color(0xFF48c0d8),
         textColor: Colors.white,
         fontSize: 16.0,
       );
     }

    });
  }

  void addLocationAddress2(context,loc_name,address,lat,long,landmark,houseno,locmain,name,lastname,email,mobile,city,pincode,itemlist,date,time) async {
    print("testttttttt 1111");
    repository.addLocationRepooo(loc_name,address,lat,long,landmark,houseno,locmain).then((value) {
      if(value["status"].toString()=="200")
      {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>PaymentChoosingScreen(
        locName: loc_name,
        date: date,time: time,
        firstname: NAME.toString(),
        lastname: lastname,
        email: email,
        phone: mobile,
        address: address,
        street: landmark,
        city: city,
        pincode: pincode,
        itemList: itemlist,
      )));
      // Navigator.push(context,
      //     MaterialPageRoute(
      //         builder: (context) => FoodiAddressBookPage()));
      }
      else{
        Fluttertoast.showToast(msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

    });
  }

  void editLocation(context,loc_name,address,lat,long,landmark,houseno,locmain,loc_id) async {
    print("testttttttt 1111");
    repository.editLocationRepooo(loc_name,address,lat,long,landmark,houseno,locmain,loc_id).then((value) {
      if(value["status"].toString()=="200")
      {
        getAddressList(context,"0");
      Fluttertoast.showToast(msg: value["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Color(0xFF48c0d8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(
              builder: (context) => FoodiAddressBookPage()));
      }
      else{
        Fluttertoast.showToast(msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

    });
  }

  void getAddressList(context,typ) async {
    Stream<List> stream = new Stream.fromFuture(getAddressListRepoo());
    stream.listen((data) {
      setState(() {
        addressStatus=false;
        addressLIST = data;
      });
      var home_count=0;
      var work_count=0;
      for (var i = 0; i < addressLIST.length; i++) {
        addressLIST[i]["location_name"]=="Home" || addressLIST[i]["location_name"]=="home" ? home_count=home_count+1 : null;
        addressLIST[i]["location_name"]=="Work" || addressLIST[i]["location_name"]=="Work"? work_count=work_count+1 : null;
      }
      setState((){
        work_count==0 ? work_save=false : work_save=true;
        home_count==0 ? home_save=false : home_save=true;
      });
      typ=="0" ? Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => FoodiAddressBookPage()
      )) : null;
    }, onDone: () {}, onError: (error) {});
  }

  void deleteAddress(context,idd) async {
    print("testttttttt 1111");
    repository.deleteAddressRepoo(idd).then((value) {
      getAddressList(context,"1");
      Fluttertoast.showToast(msg: "Successfully deleted address",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Color(0xFF48c0d8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  void addFoodBankProduct(context,image,description,itemname,qty,pickup,
      loc,loc_lat,loc_long,listing_days,show_user_days) async {
    print("testttttttt 1111");
    repository.addFoodBankProductRepo(image,description,itemname,qty,pickup,
        loc,loc_lat,loc_long,listing_days,show_user_days).then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => TimeLine(false)
          ));
    });
  }

  void addFoodiMarketProduct(context,image,description,itemname,qty,
      loc,loc_lat,loc_long,listing_days,price,cat_id,tags,availability) async {
    print("testttttttt 1111");
    repository.addFoodiMarketProductRepo(image,description,itemname,qty,
        loc,loc_lat,loc_long,listing_days,price,cat_id,tags,availability).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => TimeLine(false)
      ));
    });
  }

  void getSuggetstion() {
    repository.getSuggestionList()
        .then((value) {
          print("erty "+value.toString());
      setState((){
        sugStatus = false;
        suggestionFLIST=value["data"];
        suggestionHLIST=value["homekitchen"];
        suggestionSLIST=value["localstore"];
        suggestionRLIST=value["restaurant"];
      });
      print("ddddddd 111111 "+SuggestionList.toString());
      print("ddddddd 2222222222 "+suggestionFLIST.toString());
    });
  }

  void buyNow(context,user_id,products_id,business_type,customers_basket_quantity,final_price,page_id,item,quantity,kitchenname,loct) async {
    setState((){
      showClearDialog = false;
    });
    repository.buynoww(user_id,products_id,business_type,customers_basket_quantity,final_price.toString(),page_id)
        .then((value) {
          print("buyyyyy "+value.toString());
          if(value["status"]=="200")
            {
              Fluttertoast.showToast(msg: "Item added to cart Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 35,
                backgroundColor: Color(0xFF48c0d8),
                textColor: Colors.white,
                fontSize: 16.0,
              );
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CartScreenT1(null,null,false)
              ));
            }
          else if(value["status"]=="201")
            {
              setState((){
                showClearDialog = true;
                showCartProceedButton = false;
                showCartClearButton = true;
              });
              showModalBottomSheet(
                  backgroundColor:
                  Colors.grey[800],
                  context:
                  context,
                  clipBehavior: Clip
                      .antiAlias,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                        builder: (
                            BuildContext context, sss.StateSetter state) {
                          return Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Clear your Cart ?",style: f21BB,),
                                    IconButton(icon: Icon(Icons.close,color: Colors.white,size: 25,),
                                      onPressed: (){
                                      Navigator.pop(context);
                                      },)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                child: Divider(color: Colors.grey[200],),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:12,right: 12,bottom: 8,top: 8),
                                child: RichText(textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: "Your cart has existing items from ",
                                    style: f14w,children: [
                                      TextSpan(
                                        text: value["kitchen_name"]+".",
                                        style: f14yB,
                                      ),
                                    TextSpan(
                                      text: " Do yoy want to clear it and add items from ",
                                      style: f14w
                                    ),
                                    TextSpan(
                                      text: kitchenname,
                                      style: f14yB
                                    )
                                  ]
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8,right: 8,bottom: 10,top: 10),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[850],
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        )
                                      ),
                                        width: MediaQuery.of(context).size.width,
                                        child: Padding(
                                      padding: const EdgeInsets.only(left:8,right: 8,bottom: 10,top: 10),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(kitchenname,style: f16wB,),
                                          SizedBox(height: 3,),
                                          Text(loct,style: f14wB,)
                                        ],
                                      ),
                                    )),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFF23252E),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                          )
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left:15,right: 15,bottom: 5,top: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(item,style: f14w,),
                                                Text("\u20B9 "+(final_price*quantity).toString(),style: f14y,),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      splashColor: Color(0xFF48c0d8),
                                                      icon: Text("-",style: f15wB,),onPressed: (){
                                                        state((){
                                                          quantity=quantity-1;
                                                          quantity= quantity >0 ? quantity : 0;
                                                        });
                                                    },),
                                                    Text(quantity.toString(),style: f14wB,),
                                                    IconButton(
                                                      splashColor: Color(0xFF48c0d8),
                                                      icon: Text("+",style: f15wB,),onPressed: (){
                                                        state((){
                                                          quantity = quantity+1;
                                                        });
                                                    },),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          /*Padding(
                                            padding: const EdgeInsets.only(left:8,right: 8,bottom: 8),
                                            child: Divider(color: Colors.black87,thickness: 1,),
                                          )*/
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:7.0,left: 12,right: 12,),
                                child: GestureDetector(
                                  onTap: (){
                                    if(showCartProceedButton == false) {
                                      Fluttertoast.showToast(msg: "Please Clear your Cart",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 35,
                                      backgroundColor: Color(0xFF48c0d8),
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    ); }
                                    else{
                                      Navigator.pop(context);
                                      buyNow(context,user_id,products_id,business_type,customers_basket_quantity,final_price,page_id,item,quantity,kitchenname,loct);
                                    }
                                    // Navigator.pop(context);
                                  },
                                  child: Opacity(
                                    opacity: showCartProceedButton ? 1 : .1,
                                    child: Container(
                                      height: 47,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          border: Border.all(color: Color(0xFFffd55e),width: 2),
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: Center(child: Text("Proceed with this Item",style: f15yB,)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:13.0,left: 12,right: 12,bottom: 10),
                                child: GestureDetector(
                                  onTap: (){
                                    showCartClearButton ? clearCart(state) : Fluttertoast.showToast
                                      (msg: "Already Cart Cleared",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 35,
                                      backgroundColor: Color(0xFF48c0d8),
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                   // Navigator.pop(context);
                                  },
                                  child: Opacity(
                                    opacity: showCartClearButton ? 1 : .1,
                                    child: Container(
                                      height: 47,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFffd55e),
                                        borderRadius: BorderRadius.circular(12)
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(child: Text("Clear Cart",style: f16B,)),
                                    ),
                                  ),
                                ),
                              )


                            ],
                          );
                        });
                  });
            }
          else{
            Fluttertoast.showToast(msg: value["message"].toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 35,
              backgroundColor: Color(0xFF48c0d8),
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
    });
  }

  void clearCart(state) async {

    repository.clearCart().then((value) {
      print("cart clear "+value.toString());
      if(value["status"]=="200")
      {
        Fluttertoast.showToast(msg: "Cart cleared Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        state((){
          showCartProceedButton = true;
          showCartClearButton = false;
        });
      }
      else{
        Fluttertoast.showToast(msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  void Preorder(context,user_id,products_id,business_type,customers_basket_quantity,final_price,page_id,date,time,item,quantity,kitchenname,loct) async {
    repository.buynoww(user_id,products_id,business_type,customers_basket_quantity,final_price,page_id)
        .then((value) {
      print("buyyyyy "+value.toString());
      if(value["status"]=="200")
      {
        Fluttertoast.showToast(msg: "Preorder Item added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CartScreenT1(date,time,true)
        ));
      }
      else if(value["status"]=="201"){
        Navigator.pop(context);
        setState((){
          showClearDialog = true;
          showCartProceedButton = false;
          showCartClearButton = true;
        });
        showModalBottomSheet(
            backgroundColor:
            Colors.grey[800],
            context:
            context,
            clipBehavior: Clip
                .antiAlias,
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (
                      BuildContext context,sss. StateSetter state) {
                    return Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Clear your Cart ?",style: f21BB,),
                              IconButton(icon: Icon(Icons.close,color: Colors.white,size: 25,),
                                onPressed: (){
                                  Navigator.pop(context);
                                },)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Divider(color: Colors.grey[200],),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:12,right: 12,bottom: 8,top: 8),
                          child: RichText(textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "Your cart has existing items from ",
                                style: f14w,children: [
                              TextSpan(
                                text: value["kitchen_name"]+".",
                                style: f14yB,
                              ),
                              TextSpan(
                                  text: " Do yoy want to clear it and add items from ",
                                  style: f14w
                              ),
                              TextSpan(
                                  text: kitchenname,
                                  style: f14yB
                              )
                            ]
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8,right: 8,bottom: 10,top: 10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[850],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      )
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:8,right: 8,bottom: 10,top: 10),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(kitchenname,style: f16wB,),
                                        SizedBox(height: 3,),
                                        Text(loct,style: f14wB,)
                                      ],
                                    ),
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF23252E),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    )
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:15,right: 15,bottom: 5,top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(item,style: f14w,),
                                          Text("\u20B9 "+(final_price*quantity).toString(),style: f14y,),
                                          Row(
                                            children: [
                                              IconButton(
                                                splashColor: Color(0xFF48c0d8),
                                                icon: Text("-",style: f15wB,),onPressed: (){
                                                state((){
                                                  quantity=quantity-1;
                                                  quantity= quantity >0 ? quantity : 0;
                                                });
                                              },),
                                              Text(quantity.toString(),style: f14wB,),
                                              IconButton(
                                                splashColor: Color(0xFF48c0d8),
                                                icon: Text("+",style: f15wB,),onPressed: (){
                                                state((){
                                                  quantity = quantity+1;
                                                });
                                              },),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                   /* Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(color: Colors.black87,thickness: 1,),
                                    )*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:7.0,left: 12,right: 12,),
                          child: GestureDetector(
                            onTap: (){
                              if(showCartProceedButton == false) {
                                Fluttertoast.showToast(msg: "Please Clear your Cart",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 35,
                                  backgroundColor: Color(0xFF48c0d8),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                ); }
                              else{
                                Navigator.pop(context);
                                Preorder(context,user_id,products_id,business_type,customers_basket_quantity,final_price,page_id,date,time,item,quantity,kitchenname,loct);
                              }
                              // Navigator.pop(context);
                            },
                            child: Opacity(
                              opacity: showCartProceedButton ? 1 : .1,
                              child: Container(
                                height: 47,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(color: Color(0xFFffd55e),width: 2),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Center(child: Text("Proceed with this Item",style: f15yB,)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:13.0,left: 12,right: 12,bottom: 10),
                          child: GestureDetector(
                            onTap: (){
                              showCartClearButton ? clearCart(state) : Fluttertoast.showToast
                                (msg: "Already Cart Cleared",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 35,
                                backgroundColor: Color(0xFF48c0d8),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              // Navigator.pop(context);
                            },
                            child: Opacity(
                              opacity: showCartClearButton ? 1 : .1,
                              child: Container(
                                height: 47,
                                decoration: BoxDecoration(
                                    color: Color(0xFFffd55e),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Center(child: Text("Clear Cart",style: f16B,)),
                              ),
                            ),
                          ),
                        )


                      ],
                    );
                  });
            });
      }
      else{
        Fluttertoast.showToast(msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  void tokenEditAccount(token) async {
    repository.editProfToken(token).then((value) {
      if (value != null) {

      } else {

      }
    });
  }

  void requestVerification(context,id_proof,known_as,known_category) async {
    repository.foodiRequestVerification(id_proof,known_as,known_category).then((value) {
      if (value != null) {
        if (value['status'] == "200") {
          getAbout(userid.toString());
          Fluttertoast.showToast(msg: value["message"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 35,
            backgroundColor: Color(0xFF48c0d8),
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DrawerAccountRequestVerification(stat: repository.AbtInfo["data"][0]
                      ["req_verified_user"].toString(),showw: repository.AbtInfo["data"][0]["id_proof"]!=null ? "1" : "0",
                      )));
        }
      } else {
        Fluttertoast.showToast(msg: value["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Color(0xFF48c0d8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  void getFullVideosList(sel) async {
    Stream<List> stream = new Stream.fromFuture(getFullVideos());
    stream.listen((data) {
      print("Videoss : "+data.toString());
      print("Videoss len: "+data.length.toString());
      setState(() {
        fullVideoLength = 0;
      });

      for(int i=0;i<data.length;i++){
        fullVideoLength = fullVideosList.length;
        if(data[i]["youtube_video_id"].toString().length==11 && data[i]["youtube_video_id"]!=null){
          setState(() {
            fullVideosList.insert(fullVideoLength, data[i]);
          });
        }
      }
      print("cutted : "+fullVideosList.toString());
      print("cutted len: "+fullVideosList.length.toString());
      fullVideosList.forEach((element) {
        if(element["id"]==sel){
          setState(() {
            mainVideo = element ;
            statusFollower = false;
          });
          print("Selected video "+element.toString());
        }
      });
    }, onDone: () {}, onError: (error) {});
  }

  void getFoodieFullVideosList(sel,tim) async {
    Stream<List> stream = new Stream.fromFuture(getAccWallVideos(tim,"video",userid.toString()));
    stream.listen((data) {
      var fullVideoLength;
      print("Videoss : "+data.toString());
      print("Videoss len: "+data.length.toString());
      setState(() {
        fullVideoLength = 0;
      });
      for(int i=0;i<data.length;i++){
        fullVideoLength = fullVideosList.length;
        if(data[i]["youtube_video_id"].toString().length==11 && data[i]["youtube_video_id"]!=null){
          setState(() {
            fullVideosList.insert(fullVideoLength, data[i]);
          });
        }
      }
      print("cutted : "+fullVideosList.toString());
      print("cutted len: "+fullVideosList.length.toString());
      fullVideosList.forEach((element) {
        if(element["id"]==sel){
          setState(() {
            mainVideo = element ;
            statusFollower = false;
          });
          print("Selected video "+element.toString());
        }
      });
    }, onDone: () {}, onError: (error) {});
  }

  void updateViewCountOfPost(postid) async {
    // getHome();
    repository.updateViewCountOfPost(postid).then((value) {
      print("Post view count update "+value.toString());

    });
  }

}

