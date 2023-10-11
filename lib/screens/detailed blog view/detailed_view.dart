import 'dart:convert';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class Detailed_View extends StatelessWidget {
  String title;
  String url;
  bool offlineMode;
  Detailed_View(this.title, this.url, this.offlineMode, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          "Detailed View",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontFamily: "mainfont"),
        ),
        backgroundColor: const Color.fromARGB(255, 110, 0, 141),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(
              left: (width / .9) * .05, top: 20, right: (width / .9) * .05),
          width: width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: !offlineMode
                    ? Image.network(
                        url,
                        width: width,
                        height: 200,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                              child: Text(
                            "Image Not Available",
                            style: TextStyle(
                                color: Colors.red[900],
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ));
                        },
                      )
                    : Image.memory(
                        base64Decode(url),
                        width: width,
                        height: 200,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "blogfont",
                    color: Color.fromARGB(255, 91, 4, 115),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
//Color.fromARGB(255, 248, 222, 255),