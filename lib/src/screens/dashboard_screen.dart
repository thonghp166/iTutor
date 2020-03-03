import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("iTutor"),
        automaticallyImplyLeading: false,
      ),
      body: Material(
          child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  Text(
                    "Tìm kiếm gia sư đủ tiêu chuẩn",
                    style: TextStyle(color: Colors.black, fontSize: 32),
                  ),
                  Container(
                      // color: Colors.red,
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      height: 50,
                      width: width - 24,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.search,
                              size: 30,
                              color: Colors.grey,
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Text(
                                  "Thu tim Ha Noi",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ))
                          ],
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 60, 0, 12),
                      child: Text(
                        "Tìm kiếm gia sư tại nhà phù hợp",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ))),
    );
  }
}
