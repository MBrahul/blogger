import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_application_3/blog_model.dart';
import 'package:flutter_application_3/blog_repo.dart';
import 'package:flutter_application_3/database_handler.dart';
import 'package:flutter_application_3/screens/blogs/blogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/user/user.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  String email;
  Home(this.email, {super.key});
  @override
  // ignore: no_logic_in_create_state
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedIndex = 0;
  bool isLoading = true;
  Database? _database;
  List blogs = [];
  List offlineBlogs = [];
  List images = [];
  bool offlineMode = false;
  List isFav = [];
  _HomeState();
  @override
  void initState() {
    getBlogs();
    fetchBlogs();
    super.initState();
  }

  //open database;
  Future<Database?> openDB() async {
    _database = await DatabaseHandler().openDB();
    return _database;
  }

  // ignore: non_constant_identifier_names
  Future<void> insertDB(List blogs, List images) async {
    try {
      _database = await openDB();
      BlogRepo blogRepo = BlogRepo();
      blogRepo.createTable(_database);

      for (int i = 0; i < min(blogs.length, 50); i++) {
        BlogModel blogModel =
            BlogModel(blogs[i]["title"].toString(), images[i]);
        await _database?.insert('Blog', blogModel.toMap());
      }
      await _database?.close();
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> getBlogs() async {
    try {
      _database = await openDB();
      BlogRepo blogRepo = BlogRepo();
      offlineBlogs = await blogRepo.getBlogs(_database);
      // print(offlineBlogs.length);
      await _database?.close();
    } catch (e) {
      offlineBlogs = [];
    }
  }

  void updateFav(int index) {
    if (isFav[index]) {
      isFav[index] = false;
    } else {
      isFav[index] = true;
    }
    setState(() {});
  }

  void fetchBlogs() async {
    setState(() {
      isLoading = true;
    });
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        // Request successful, handle the response data here

        var res = jsonDecode(response.body);

        for (int i = 0; i < res["blogs"].length; i++) {
          isFav.insert(i, false);
        }

        setState(() {
          blogs = res["blogs"];
          isLoading = false;
        });
        if (offlineBlogs.isEmpty) {
          getImages(blogs);
        }
      } else {
        // Request failed
        print('Request failed with status code: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      setState(() {
        offlineMode = true;
        blogs = offlineBlogs;
        for (int i = 0; i < offlineBlogs.length; i++) {
          isFav.insert(i, false);
        }
      });
      print('Error: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getImages(List blogs) async {
    List<String> temp = [];
    for (int i = 0; i < min(blogs.length, 50); i++) {
      String base64 = "";
      http.Response response =
          await http.get(Uri.parse(blogs[i]['image_url'].toString()));

      base64 = base64Encode(response.bodyBytes);
      temp.insert(i, base64);
    }
    images = temp;
    insertDB(blogs, images);
  }

  // ignore: non_constant_identifier_names
  Widget Body() {
    if (selectedIndex == 0) {
      return Blogs(blogs, fetchBlogs, isLoading, offlineMode, isFav, updateFav);
    } else {
      return User(widget.email, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Body(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          // showSelectedLabels: true,
          iconSize: 18,
          // elevation: 30,
          type: BottomNavigationBarType.shifting, // Shifting
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(255, 150, 148, 148),
          backgroundColor: const Color.fromARGB(255, 91, 4, 115),
          // type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Color.fromARGB(255, 110, 0, 141)),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: "Account",
                backgroundColor: Color.fromARGB(255, 110, 0, 141))
          ],
        ),
      ),
    );
  }
}
