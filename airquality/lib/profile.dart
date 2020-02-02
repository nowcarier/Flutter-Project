import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_weather_icons/flutter_weather_icons.dart';

Future<Post> fetchPost() async {
  final response = await http
      .get('http://air4thai.pcd.go.th/services/getNewAQI_JSON.php?region=5');
  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final String regionID;
  final String nameTH;
  final String nameEN;
  final List stations;

  Post({this.regionID, this.nameTH, this.nameEN, this.stations});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      regionID: json['regionID'],
      nameTH: json['nameTH'],
      nameEN: json['nameEN'],
      stations: json['stations'],
    );
  }
}

class Aqi extends StatefulWidget {
  Aqi({Key key}) : super(key: key);
  @override
  _AqiState createState() => _AqiState();
}

class _AqiState extends State<Aqi> {
  Future<Post> post;
  @override
  void initState() {
    super.initState();
    post = fetchPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.red,
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("คุณภาพอากาศ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: "Kanit")),
                background: Flex(
                  direction: Axis.vertical,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF1cb0ff),
                                    Color(0xFF9cc5db)
                                  ]),
                            ),
                          ),
                          Container(
                            child: FutureBuilder<Post>(
                              future: post,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: <Widget>[
                                      Container(
                                        child: Container(
                                          margin: EdgeInsets.all(20),
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 110,
                                              ),
                                              Center(
                                                child: Text(
                                                  (snapshot.data
                                                      .stations[0]['nameTH']
                                                      .toString()),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: "Kanit",
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w100,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                // By default, show a loading spinner.
                                return CircularProgressIndicator();
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ];
      },
      body: FutureBuilder<Post>(
        future: post,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                color: Color(0xFF9cc5db),
                child: ClipPath(
                  clipper: WaveClipperTwo(reverse: true),
                  child: Container(
                    color: Colors.white,
                    height: 220,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                'Air Quality',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          item(
                            "  PM10",
                            Text(
                              (snapshot
                                      .data
                                      .stations[0]['LastUpdate']['PM10']
                                          ['value']
                                      .toString() +
                                  "  " +
                                  snapshot.data
                                      .stations[0]['LastUpdate']['PM10']['unit']
                                      .toString()),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          item(
                            "  O3",
                            Text(
                              (snapshot.data
                                      .stations[0]['LastUpdate']['O3']['value']
                                      .toString() +
                                  "  " +
                                  snapshot.data
                                      .stations[0]['LastUpdate']['O3']['unit']
                                      .toString()),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          item(
                            "  CO",
                            Text(
                              (snapshot.data
                                      .stations[0]['LastUpdate']['CO']['value']
                                      .toString() +
                                  "  " +
                                  snapshot.data
                                      .stations[0]['LastUpdate']['CO']['unit']
                                      .toString()),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          item(
                            "  NO2",
                            Text(
                              (snapshot.data
                                      .stations[0]['LastUpdate']['NO2']['value']
                                      .toString() +
                                  "  " +
                                  snapshot.data
                                      .stations[0]['LastUpdate']['NO2']['unit']
                                      .toString()),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          item(
                            "  SO2",
                            Text(
                              (snapshot.data
                                      .stations[0]['LastUpdate']['SO2']['value']
                                      .toString() +
                                  "  " +
                                  snapshot.data
                                      .stations[0]['LastUpdate']['SO2']['unit']
                                      .toString()),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          item(
                            "  AQI",
                            Text(
                              (snapshot.data
                                      .stations[0]['LastUpdate']['AQI']['Level']
                                      .toString() +
                                  "  " +
                                  snapshot.data
                                      .stations[0]['LastUpdate']['AQI']['aqi']
                                      .toString()),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              ('ข้อมูลอัพเดทเวลา ' +
                                  snapshot
                                      .data.stations[0]['LastUpdate']['time']
                                      .toString() +
                                  "  วันที่ " +
                                  snapshot
                                      .data.stations[0]['LastUpdate']['date']
                                      .toString()),
                              style: TextStyle(
                                fontFamily: "Kanit",
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    )));
  }
}

Widget item(String text, value) {
  return InkWell(
    child: Container(
      height: 100,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 8,
                offset: Offset(0, 15),
                color: Color(0xff00D99E).withOpacity(.9),
                spreadRadius: -9)
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF6E95F3), Color(0xFF9FB9F8)])),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: "Kanit",
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 20,
            ),
          ),
          Expanded(child: value),
          IconButton(
              // Use the EvaIcons class for the IconData
              icon: Icon(
                WeatherIcons.wiDaySunnyOvercast,
                color: Colors.white,
              ),
              onPressed: () {}),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
    onTap: () {},
  );
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.grey;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Drawhorizontalline extends CustomPainter {
  Paint _paint;

  Drawhorizontalline() {
    _paint = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(-160.0, 0.0), Offset(160.0, 0.0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
