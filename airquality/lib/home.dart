import 'package:airquality/photo.dart';
import 'package:airquality/profile.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Post> post;
  @override
  void initState() {
    super.initState();
    post = fetchPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    return MaterialApp(
        home: Scaffold(
            body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.red,
            expandedHeight: 400.0,
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
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: FutureBuilder<Post>(
                                future: post,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var myint = int.parse(
                                        snapshot.data.stations[0]['LastUpdate']
                                            ['PM25']['value']);
                                    Widget _getColor() {
                                      if (myint <= 25) {
                                        return bk(0xFF1cb0ff);
                                      } else if (myint <= 50) {
                                        return bk(0xFF048000);
                                      } else if (myint <= 100) {
                                        return bk(0xFF84ff00);
                                      } else if (myint <= 200) {
                                        return bk(0xFFFFB74D);
                                      } else if (myint > 200) {
                                        return bk(0xFFff0000);
                                      }
                                    }
                                    return _getColor();
                                  }
                                }),
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
                                              Text(
                                                (snapshot
                                                    .data.stations[0]['nameTH']
                                                    .toString()),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "Kanit",
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Center(
                                                child: Container(
                                                  child: CustomPaint(
                                                      painter:
                                                          Drawhorizontalline()),
                                                ),
                                              ),
                                              Container(
                                                  child: Text(
                                                (snapshot
                                                    .data
                                                    .stations[0]['LastUpdate']
                                                        ['PM25']['value']
                                                    .toString()),
                                                style: TextStyle(
                                                    fontSize: 100,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    (snapshot
                                                        .data
                                                        .stations[0]
                                                            ['LastUpdate']
                                                            ['PM25']['unit']
                                                        .toString()),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
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
              child: Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0))),
                height: 220,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: ListView(
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Air Quality",
                          style: TextStyle(
                            fontFamily: "Kanit",
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
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
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color(0xFFCD5C5C),
                                    Color(0xFFE9967A)
                                  ])),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "  PM10",
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
                              Expanded(
                                child: Text(
                                  (snapshot
                                          .data
                                          .stations[0]['LastUpdate']['PM10']
                                              ['value']
                                          .toString() +
                                      "  " +
                                      snapshot
                                          .data
                                          .stations[0]['LastUpdate']['PM10']
                                              ['unit']
                                          .toString()),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              IconButton(
                                  // Use the EvaIcons class for the IconData
                                  icon: Icon(
                                    WeatherIcons.wiDaySunnyOvercast,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {}),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                            return Aqi();
                          }));
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          ('ข้อมูลอัพเดทเวลา ' +
                              snapshot.data.stations[0]['LastUpdate']['time']
                                  .toString() +
                              "  วันที่ " +
                              snapshot.data.stations[0]['LastUpdate']['date']
                                  .toString()),
                          style: TextStyle(
                            fontFamily: "Kanit",
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text("ความหมายของสีพื้นหลัง"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PhotoHero(
                        photo: 'assets/images/air.png',
                        width: 300.0,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                            return Scaffold(
                              appBar: AppBar(
                                backgroundColor: Color(0xFF81B4DC),
                                title: const Text('info'),
                              ),
                              body: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF81B4DC),
                                          Color(0xFFEAEBE5)
                                        ]),
                                  ),
                                  // The blue background emphasizes that it's a new route.
                                  // color: Colors.white,
                                  padding: const EdgeInsets.all(16.0),
                                  alignment: Alignment.topCenter,
                                  child: ListView(
                                    children: <Widget>[
                                      PhotoHero(
                                        photo: 'assets/images/air.png',
                                        width: 400,
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Text(
                                          "ตารางที่ 1 เกณฑ์ของดัชนีคุณภาพอากาศของประเทศไทย",
                                          style: TextStyle(
                                            fontFamily: "Kanit",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      PhotoHero(
                                        photo: 'assets/images/air2.png',
                                        width: 400,
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  )),
                            );
                          }));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
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

Widget bk(int colors) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(colors), Color(0xFF9cc5db)]),
    ),
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
      ..color = Colors.white
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
