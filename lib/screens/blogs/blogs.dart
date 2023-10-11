import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/custom%20widgets/blog.dart';

class Blogs extends StatefulWidget {
  List blogs;
  Function() fetchBlogs;
  Function updateFav;
  bool isLoading;
  bool offlineMode;
  List isFav;

  Blogs(this.blogs, this.fetchBlogs, this.isLoading, this.offlineMode,
      this.isFav, this.updateFav,
      {super.key});

  @override
  State<Blogs> createState() => _Blogsstate();
}

class _Blogsstate extends State<Blogs> {
  @override
  void initState() {
    // print(widget.blogs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Blogs",
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontFamily: "mainfont"),
        ),
        backgroundColor: const Color.fromARGB(255, 110, 0, 141),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 248, 222, 255),
          ),
          child: widget.blogs.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Blog(
                        index,
                        MediaQuery.of(context).size.width * .9,
                        widget.blogs[index]["title"],
                        widget.blogs[index]["image_url"],
                        widget.offlineMode,
                        widget.isFav[index],
                        widget.updateFav,
                        context);
                  },
                  itemCount: widget.blogs.length,
                )
              : !widget.isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Something went wrong",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                        IconButton(
                            onPressed: () {
                              widget.fetchBlogs();
                            },
                            icon: const Icon(Icons.refresh_sharp))
                      ],
                    )
                  : const CircularProgressIndicator(
                      color: Color.fromARGB(255, 110, 0, 141),
                    )),
    );
  }
}
