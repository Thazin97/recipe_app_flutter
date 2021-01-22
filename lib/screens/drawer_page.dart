import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:receipes/model/recipe_model.dart';
import 'package:receipes/screens/recipe_videos.dart';
import 'package:receipes/services/auth.dart';
import 'package:receipes/themes/colors.dart';
import 'package:http/http.dart'as http;
import 'package:receipes/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'kitchen_tips.dart';
import 'login_page.dart';
import 'recipe_view.dart';

class HeaderProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   Provider<AuthService>(
      create : (_) => AuthService(),
      child: DrawerPage(),
    );
  }
}


class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {

  bool showProgress = false;
  final _auth = FirebaseAuth.instance;

  signOut() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _auth.signOut();
  }
  List<RecipeModel> recipes = new List();
  String ingredients;

  bool _loading = false ;
  String query = "";
  TextEditingController textEditingController = new TextEditingController();



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Cook Studio',style: TextStyle(fontFamily: 'Mogella',color:Colors.white),),
        backgroundColor: AppColor.denim,
        elevation: 0,
      ),
      backgroundColor:  Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: SingleChildScrollView(
                child: Column(
                    children: [
                      FutureBuilder(
                        future: Provider.of<AuthService>(context).getCurrentUser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done &&
                              snapshot.data != null) {
                            return displayUserInformation(context, snapshot);
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )
                    ]),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                      image: AssetImage('images/download.png',),
                  )
              ),
            ),
            GestureDetector(child: drawerTile(iconData: Icons.home,title: 'Recipe Options'),onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HeaderProvider()));
            },),

            divider(),
            GestureDetector(child: drawerTile(iconData: Icons.ondemand_video,title: 'Recipe Videos'),onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => RecipeVideos()
              ));
            },),
            divider(),
            GestureDetector(child: drawerTile(iconData: Icons.announcement,title: 'Kitchen Tips'),onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> KitchenTips()));  //edit
            },),
            divider(),
            GestureDetector(child: drawerTile(iconData: Icons.logout,title: 'Log Out'),onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email');
              signOut();
              setState(() {
                final route = MaterialPageRoute(builder: (BuildContext context) => MyLoginPage());
                Navigator.of(this.context).pushAndRemoveUntil(route, (Route<dynamic> route) => false);
                showProgress = true;

                Fluttertoast.showToast(
                    msg: "Logout Successful...",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.blueAccent,
                    textColor: Colors.white,
                    fontSize: 16.0);
              });
            },),
            divider(),
          ],
        ),
      ),
      body: ModalProgressHUD(
      inAsyncCall: _loading,
      child:Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: !kIsWeb ? Platform.isIOS? 60: 30 : 30, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "What will you cook today?",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Mogella'),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Just Enter Ingredients you have and we will show the best recipe for you",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: textEditingController,
                            style: TextStyle(
                                fontSize: 16,
                                color:  Colors.black,
                                fontFamily: 'Mogella'),
                            decoration: InputDecoration(
                              hintText: "Enter Ingredients",
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color:  Colors.black.withOpacity(0.5),
                                  fontFamily: 'TypeWriter'),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: AppColor.denim),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color:  AppColor.midnightblue),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        InkWell(
                            onTap: () async {
                              if (textEditingController.text.isNotEmpty) {
                                setState(() {
                                  _loading = true;
                                });
                                recipes = new List();
                                String url =
                                    "https://api.edamam.com/search?q=${textEditingController.text}&app_id=90040b20&app_key=7c7103bfc3bd7daa4662e7d9e0bce23b";
                                var response = await http.get(url);
                                print(" $response this is response");
                                Map<String, dynamic> jsonData =
                                jsonDecode(response.body);
                                print("this is json Data $jsonData");
                                jsonData["hits"].forEach((element) {
                                  print(element.toString());
                                  RecipeModel recipeModel = new RecipeModel();
                                  recipeModel =
                                      RecipeModel.fromMap(element['recipe']);
                                  recipes.add(recipeModel);
                                  print(recipeModel.url);
                                });
                                setState(() {
                                  _loading = false;
                                });

                                print("success search");
                              } else {
                                print("fail");
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColor.fontColor,
                                        AppColor.iconColor
                                      ],
                                      begin: FractionalOffset.topRight,
                                      end: FractionalOffset.bottomLeft)),
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                      Icons.search,
                                      size: 26,
                                      color: Colors.white
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:2.0,
                  ),
                  Container(
                    child: GridView(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 10.0, maxCrossAxisExtent: 200.0),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        children: List.generate(recipes.length, (index) {
                          return GridTile(
                              child: RecipeTile(
                                title: recipes[index].label,
                                imgUrl: recipes[index].image,
                                source: recipes[index].source,
                                url: recipes[index].url,
                              ));
                        })),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget displayUserInformation(context, snapshot) {
    final authData = snapshot.data;
    return
     Padding(
       padding: const EdgeInsets.only(top:117.0),
       child: Text(
                    " ${authData.email ?? 'Anonymous'}",
                    style: TextStyle(fontSize:16,color:AppColor.fontColor,fontFamily: 'Mogella',fontWeight: FontWeight.bold),
       ),
     );
  }
}


class RecipeTile extends StatefulWidget {
  final String title, source, imgUrl, url;

  RecipeTile({this.title, this.source, this.imgUrl, this.url});

  @override
  _RecipeTileState createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecipeView(
                      postUrl: widget.url,
                    )));
            // }
          },
          child: Container(
            margin: EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imgUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white,Colors.amber[200]],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              ),
                        ),
                        Text(
                          widget.source,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GradientCard extends StatelessWidget {
  final Color topColor;
  final Color bottomColor;
  final String topColorCode;
  final String bottomColorCode;

  GradientCard(
      {this.topColor,
        this.bottomColor,
        this.topColorCode,
        this.bottomColorCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 160,
                  width: 180,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [topColor, bottomColor],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight)),
                ),
                Container(
                  width: 180,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          topColorCode,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          bottomColorCode,
                          style: TextStyle(fontSize: 16, color: bottomColor),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}













