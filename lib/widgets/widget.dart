import 'package:flutter/material.dart';
import 'package:receipes/themes/colors.dart';


ListTile videoTile({String title , String subtitle, String imagePath}){
  return  ListTile(
    leading: Image(image: AssetImage(imagePath),height: 125.0,),
    title: Text(title,style: TextStyle(fontFamily: 'Mogella',fontWeight: FontWeight.w800),),
    subtitle: Text(subtitle),
    trailing: Icon(Icons.play_circle_outline,color: AppColor.nudedenim,size: 35.0,),
  );

}

ListTile drawerTile({IconData iconData,String title, }){
  return ListTile(
    leading: Icon(iconData, color: AppColor.iconColor,),
    title: Text(title, style: TextStyle(
        fontFamily: 'Mogella',
        fontSize: 16.0,
        color: AppColor.fontColor,
        fontWeight: FontWeight.bold)),
  );
}

 divider(){
  return Divider(
    height: 3.0,
    thickness: 1.2,
    color: Colors.black12,
  );
}

tipsContainer(String title){
  return Container(margin: EdgeInsets.only(left:10.0),child:Text(title,textAlign: TextAlign.start,style: TextStyle(color: Colors.black,fontSize:20.0,fontWeight: FontWeight.bold,letterSpacing: 1.0),),);
}
tipsCard(String image,String subtitle){
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Card(
      child: Column(
        children: [
          Image(image: AssetImage(image)),
          SizedBox(
            height: 15.0,
          ),
          Text(subtitle,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18.0),)
        ],
      ),
    ),
  );
}

InputDecoration textFieldInputDecoration(String hintText, IconData icon){
  return  InputDecoration(
      prefixIcon: Icon(icon,color:AppColor.midnightblue ,size: 22.5),
      hintText: hintText,
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      hintStyle: TextStyle(color: Colors.black54),
      fillColor: Colors.white,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color:Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(1.0),
      ));

}

