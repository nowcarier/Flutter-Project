import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Developer extends StatefulWidget {
  Developer({Key key}) : super(key: key);
  @override
  _DeveloperState createState() => _DeveloperState();
}

class _DeveloperState extends State<Developer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1cb0ff), Color(0xFF9cc5db)]),
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              image: AssetImage("assets/images/bg4.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                  child: Center(
                      child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                    'https://scontent.fbkk5-6.fna.fbcdn.net/v/t1.0-9/p960x960/60804703_2835734089985756_7251521979683962880_o.jpg?_nc_cat=101&_nc_eui2=AeFwyFbJFRk5kzuAqZMAoKFRpV0zPyYvGYMhEbDi8WoE5JJyEWU9TvvH-t3utTScotb4TS7h1I0b920UEnFE8ctVFfEc2sUPjlgzN1mgvdwkpw&_nc_oc=AQmHl7DQiA5Aa1XWq8jvpyd7KHCwL-WLdi_8c3MrJwTCEEdEnCD1AHapCIURH4rd_os&_nc_ht=scontent.fbkk5-6.fna&_nc_tp=6&oh=6808b8122b32faceb5061b26b425ac5a&oe=5E91F8A2'),
              ))),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 250,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                      bottomLeft: const Radius.circular(40.0),
                      bottomRight: const Radius.circular(40.0),
                    )),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'นายปิยะวัฒน์ จังอินทร์',
                        style: TextStyle(fontFamily: "Kanit", fontSize: 20),
                      ),
                    ),
                    Center(
                      child: Text(
                        'รหัสนักศึกษา 60114440198',
                        style: TextStyle(fontFamily: "Kanit", fontSize: 20),
                      ),
                    ),
                    Center(
                      child: Text(
                        'คณะวิทยาศาสตร์',
                        style: TextStyle(fontFamily: "Kanit", fontSize: 20),
                      ),
                    ),
                    Center(
                      child: Text(
                        'สาขาวิทยาการคอมพิวเตอร์',
                        style: TextStyle(fontFamily: "Kanit", fontSize: 20),
                      ),
                    ),
                    Center(
                      child: Text(
                        'ขอบคุณข้อมูลจาก',
                        style: TextStyle(fontFamily: "Kanit", fontSize: 20),
                      ),
                    ),
                     Center(
                      child: Text(
                        'Air4Thai',
                        style: TextStyle(fontFamily: "Kanit", fontSize: 20),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    ));
  }
}
