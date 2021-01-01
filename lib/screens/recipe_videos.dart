import 'package:flutter/material.dart';
import 'package:receipes/screens/videosCollection/chickencurryvideo.dart';
import 'package:receipes/screens/videosCollection/coconutnoodlevideo.dart';
import 'package:receipes/screens/videosCollection/coconutvideo.dart';
import 'package:receipes/screens/videosCollection/eggpuddingvideo.dart';
import 'package:receipes/screens/videosCollection/gimbapvideo.dart';
import 'package:receipes/screens/videosCollection/mohnhinngarvideo.dart';
import 'package:receipes/screens/videosCollection/oilyricevideo.dart';
import 'package:receipes/screens/videosCollection/porkcurryvideo.dart';
import 'package:receipes/screens/videosCollection/porkpoutsivideo.dart';
import 'package:receipes/screens/videosCollection/prawncurry.dart';
import 'package:receipes/screens/videosCollection/stickychickenvideo.dart';
import 'package:receipes/themes/colors.dart';
import 'package:receipes/widgets/widget.dart';

class RecipeVideos extends StatefulWidget {
  @override
  _RecipeVideosState createState() => _RecipeVideosState();
}

class _RecipeVideosState extends State<RecipeVideos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.denim,
      body: Stack(
        children:[
          Container(
            margin: EdgeInsets.only(top: 30.0,left:10.0),
            child: Column(
                  children: [
                  Row(
                    children: [
                      IconButton(icon: Icon(Icons.arrow_back_ios),color: AppColor.nudeblue,iconSize: 30, onPressed: (){
                        Navigator.pop(context);
                      }),
                    Text('Cooking Videos',style: TextStyle(fontSize:
                    32.0,fontWeight: FontWeight.bold,fontFamily: 'Lovely Kids',color:AppColor.nudeblue,letterSpacing: 3.0),),
                    ],
                    ),
                    SizedBox(height:10.0,),
                  Column(
                    children: [
                      Text('Food videos with tips and tricks that help you learn the ways like these videos or you can innovate with your own ways of creations for food.',style: TextStyle(fontSize: 15.0,color: AppColor.nudeblue,fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),

    ])
    ),
                    Container(
                          margin: EdgeInsets.only(top: 190),
                          decoration: BoxDecoration(
                            color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                              )
                          ),
                      child: ListView(
                        children: [
                           GestureDetector(
                               child: videoTile(title: 'Myanmar Rice Noodle Soup', subtitle: '7:39',imagePath:'images/ricenoodlesoup.jpeg', ),
                             onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> MohnhinngarVideo()));
                                 }, ),

                          GestureDetector(
                            child: videoTile(title: 'Pork Poutsi', subtitle: '8:45',imagePath:'images/porkpoutsi.jpg', ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> PorkPoutsiVideo()));
                            }, ),

                          GestureDetector(
                            child: videoTile(title: 'Avocado Gimbap', subtitle: '3:23',imagePath:'images/Avocado.jpg', ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> GimbapVideo()));
                            }, ),

                          GestureDetector(
                            child: videoTile(title: 'Prawn Curry', subtitle: '2:05',imagePath:'images/prawncurry.jpeg', ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> PrawnCurryVideo()));
                            }, ),

                          GestureDetector(
                            child: videoTile(title: 'Chicken curry', subtitle: '3:18',imagePath:'images/chickencurry.jpg', ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ChickenCurryVideo()));
                            }, ),

                          GestureDetector(
                            child: videoTile(title: 'Pork Curry with Bean Paste', subtitle: '3:04',imagePath:'images/porkwithbeanpaste.jpg', ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> PorkCurryVideo()));
                            }, ),

                          GestureDetector(
                            child: videoTile(title: 'Egg Pudding', subtitle: '6:08',imagePath:'images/eggpudding.jpg', ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> EggPuddingVideo()));
                            }, ),

                          GestureDetector(
                            child: videoTile(title: 'Coconut Dessert', subtitle: '2:46',imagePath:'images/coconut.jpg', ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> CoconutVideo()));
                            }, ),

                          GestureDetector(
                            child: videoTile(title: 'Coconut Noddle', subtitle: '6:15',imagePath:'images/coconutnoodle.jpg', ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> CoconutNoodleVideo()));
                            }, ),

                          GestureDetector(
                            child: videoTile(title: 'Sticky Rice with Chicken', subtitle: '5:14',imagePath:'images/stickyricewithchicken.jpg', ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> StickyChickenVideo()));
                            }, ),

                          GestureDetector(
                            child: videoTile(title: 'Oily Rice', subtitle: '2:19',imagePath:'images/oilyrice.jpg', ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> OilyRiceVideo()));
                            }, ),
                            ],
                            ),

    )
        ]),
    );
  }
}

