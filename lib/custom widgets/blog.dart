import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/detailed%20blog%20view/detailed_view.dart';

// ignore: non_constant_identifier_names
Widget Blog(int index, double width, String title, String url, bool offlineMode,
    bool isFav, var updateFav, BuildContext context) {
  double d = width;
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Detailed_View(title, url, offlineMode);
      }));
    },
    child: Stack(
      children: [
        Container(
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
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Center(
                                child: Text(
                              "*Image Not Available*",
                              style: TextStyle(
                                  color: Colors.red[900],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )),
                          );
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
                    fontWeight: FontWeight.w600,
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
        !offlineMode
            ? Positioned(
                right: (d / .9) * .05,
                top: 219,
                child: IconButton(
                    onPressed: () {
                      updateFav(index);
                    },
                    icon: !isFav
                        ? const Icon(Icons.favorite_border)
                        : const Icon(
                            Icons.favorite,
                            color: Colors.pink,
                          )))
            : const SizedBox(
                height: 0,
              )
      ],
    ),
  );
}
