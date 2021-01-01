import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipes/screens/registration_page.dart';
import 'package:receipes/services/network_status_service.dart';
import 'package:receipes/themes/colors.dart';


class ProviderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   StreamProvider<NetworkStatus>(
          create: (context) =>
          NetworkStatusService().networkStatusController.stream,
          child: IntroScreen(),
        );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NetworkStatus networkStatus = Provider.of<NetworkStatus>(context);
    return  Scaffold(
        body: Stack(
          children: [
            Image(image: AssetImage('images/plating.jpg'),
              width: 500.0,
              height: 1000.0,
              fit: BoxFit.fitHeight,),
            Container(
                margin: EdgeInsets.only(top: 50.0, left: 15.0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        children: [
                          Text(
                            'Everyday',
                            style: TextStyle(color: AppColor.midnightblue,
                                fontSize: 36.0,
                                fontFamily: 'TypeWriter',
                                letterSpacing: 2.0),),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'is  ',
                          style: TextStyle(color:AppColor.midnightblue,
                              fontSize: 36.0,
                              fontFamily: 'TypeWriter',
                              letterSpacing: 2.0),),
                        Text(
                          'Tasty!',
                          style: TextStyle(color: AppColor.midnightblue,
                              fontSize: 40.0,
                              fontFamily: 'TypeWriter',
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold),)
                      ],
                    )
                  ],
                )),
            Container(
              //margin: EdgeInsets.only(top: 500.0,left: 90.0),
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: OutlineButton(
                      child: Text('Get Started'),
                      borderSide: BorderSide(
                          color: AppColor.midnightblue,
                          width: 2,
                          style: BorderStyle.solid
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.0)
                      ),
                      onPressed: () {
                        if (networkStatus == NetworkStatus.WiFi ) {
                          return  Navigator.push(context,(MaterialPageRoute(builder: (context)=> RegistrationPage())));
                        } else if( networkStatus == NetworkStatus.Cellular){
                          return Navigator.push(context,(MaterialPageRoute(builder: (context)=> RegistrationPage())));
                        }
                        else {
                          return _showDialog(context);
                        }
                      }
                  ),
                )
            )
          ],
        ),

    );
  }
  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  Container(
            width: 250.0,
            height: 100.0,
            child: AlertDialog(
              title:  Align(alignment: Alignment.center,child: Text('Message')),
              content: Text('Please check your internet connection and try again!',textAlign:TextAlign.start,),
              actions: [
                FlatButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text('OK'),)
              ],
            )
        );

      },
    );
  }
}


