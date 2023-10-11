import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/login/login.dart';

class User extends StatelessWidget {
  String email;
  BuildContext context;
  User(this.email, this.context, {super.key});

  void logOut() async {
    showDialog(
        context: context,
        builder: (context) {
          return const AbsorbPointer(
            // abosorbpointer to unable touch while loading icon
            absorbing: true,
            child: Center(
                child: CircularProgressIndicator(
              color: Color.fromARGB(255, 129, 8, 163),
            )),
          );
        });
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        // pop the dialog
        Navigator.of(context).pop();
        //
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const Login();
        }));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account",
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontFamily: "mainfont"),
        ),
        backgroundColor: const Color.fromARGB(255, 110, 0, 141),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 248, 222, 255),
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          const Icon(
            Icons.account_circle_outlined,
            size: 130,
            color: Color.fromARGB(255, 91, 4, 115),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Email: $email",
            style: const TextStyle(
                color: Color.fromARGB(255, 91, 4, 115),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'blogfont'),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              logOut();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 91, 4, 115),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23))),
            child: const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                "Logout",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "mainfont",
                    fontWeight: FontWeight.w200),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
