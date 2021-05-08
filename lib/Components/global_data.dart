import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_player/video_player.dart';
import 'package:Butomy/VIMEO/quality_links.dart';
/* "https://img.youtube.com/vi/" +
                                                                  _con
                                                                      .timelinePostData[
                                                                  index][
                                                                  "youtube_video_id"]
                                                                      .toString() +
                                                                  "/0.jpg",*/
var len_timewall = 0;
var postid;
var showClearDialog = false;
var showCartProceedButton = false;
var showCartClearButton = true;
var userid;
var minPic = " min qty";
var mainVideo;
var fullVideoLength;
var timelineIdFoodi;
var userNAME;
var cartTotal;
int cartCount =0;
var NAME;
var urlPost;
var LNAME;
var EMAIL;
var PHONE;
var userPIC;
List orderStatusList = [];

var notificationCount = 0;
var name = "";
var commentlist = [];
var likecommentstatus;
var user_location;
var user_lat;
var user_long;
var fire_id;
var fire_name;
var fire_username;
var fire_pic;
var fire_token;
var msg_count;
var total_count;
var cat = "Chinese";
var cat_id;
var catid_store;
var catid_rest;

int x =0;

int main_currentind = 0;
var catStore = "Fruits";
var catRest = "Snacks";
var pageid_HomeKitchen;
var pageid_LocalStore;
var pageid_Restaurant;
var timelineid_Homekitchen;
var timelineid_LocalStore;
var timelineid_Restaurant;
List Catids = [];
var starttim = 0;
List timelinePostData = [];

String baseurl = "htthhgfg";

List Splashtotimdata = [];
List KitCat = [];
List MenuSubCat = [];
List MKitCat = [];
List Stocat = [];
List ResCat = [];
List KITCHENDATA = [];
List popKitchen = [];
List popStore = [];
List popRest = [];
List STOREDATA = [];
List TimMARKET = [];
List TimBANK = [];

List RESTAURANTDATA = [];
List favouriteList = [];
List BUS_KITCHEN_WALL = [];
List BUS_STORE_WALL = [];
List BUS_RESTAURANT_WALL = [];
List ACCCWall = [];
List BLOGLIST = [];
File videooooWid;
bool acc = true;
var UserKitchen;
var UserStore;
var UserRestaurant;
var res_sum = 0;
var sto_sum = 0;
var kit_sum = 0;
VideoPlayerController videoooooooooooo;
List IMAGELISTS = [];
List<File> imageList;
bool daaaaaaaaaaaaa = false;
bool timuloadinggg = false;
bool kituploadgg = false;
bool stoupldggg = false;
bool resuplldgg = false;
int notificationReadStatus;
var chatmsgcount = 0;
var businesschatcount = 0;
TextEditingController timeLineLocation = TextEditingController();
var purchasecount = 0;
List PURCHASELIST = [];
List SuggestionList = [];
var NOTIFICATIONLIST;
String Bus_NAME;
String Bus_Address;
String Bus_Profile;
bool verified=false;
bool Bus_Upld;
List STATES = [];
List DISTRICTS = [];
var BusinessProfileData;
var IDS;
String Market_pageid;
String Foodbank_pageid;
String Market_timid;
String Foodbank_timid;

List Distance = ["1 km","2 km","3 km","4 km","5 km"];
List Days = ["1 Days","2 Days","3 Days","4 Days","5 Days"];
List requestVerify = ["News/Media","Sports","Government/Politics","Music","Fashion","Entertainment",
                        "Blogger/Influencer","Business/Brand/Organisation","Others"];
List listingItem = ["List As Single Item","List As Multiple Item","List As Triple Item"];
List ShowUsers = ["Show to All","Only Organization",];
List Quantity = ["1","2","3","4","5","6","7","8","9","10"];
List GST = ["4","5","6","7","8","9","10"];

var location;
var location_address;
var location_lat;
var location_long;
bool work_save=false;
bool home_save=false;
Position userLocation;
