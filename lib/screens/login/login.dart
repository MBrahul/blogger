import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_3/screens/blogs/blogs.dart';
import 'package:flutter_application_3/screens/home/home.dart';
import 'package:flutter_application_3/screens/sign%20up/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obsure = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String error = "";

  void login() async {
    // show loading pop

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
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
        //pop the dialog
        Navigator.of(context).pop();
        // move to main home
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Home(email.text.toString());
        }));
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = "Invalid login credentials";
      });
      // pop the dialog
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      if (e.code == 'user-not-found') {
        // snackbar("User Not Found", context);
        setState(() {
          error = 'user-not-found';
        });
      } else if (e.code == 'wrong-password') {
        // snackbar("Wrong Credentials", context);
        setState(() {
          error = 'wrong-password';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color.fromARGB(255, 249, 238, 252),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                'Blogger',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'mainfont',
                    color: Color.fromARGB(255, 91, 4, 115),
                    fontSize: 35,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Welcome',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'blogfont',
                    color: Color.fromARGB(255, 91, 4, 115),
                    fontSize: 27,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: email,
                style: const TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: 'blogfont'),
                decoration: InputDecoration(
                    label: const Text(
                      "Email",
                      style: TextStyle(
                          color: Color.fromARGB(255, 91, 4, 115),
                          fontSize: 18,
                          fontFamily: 'blogfont'),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 91, 4, 115),
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 91, 4, 115)))),
              ),
              const SizedBox(
                height: 17,
              ),
              TextField(
                controller: password,
                obscureText: obsure,
                style: const TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: 'blogfont'),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (obsure) {
                            obsure = false;
                          } else {
                            obsure = true;
                          }
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.remove_red_eye,
                          size: 28,
                          color: Color.fromARGB(255, 91, 4, 115),
                        )),
                    label: const Text(
                      "Password",
                      style: TextStyle(
                          color: Color.fromARGB(255, 91, 4, 115),
                          fontSize: 18,
                          fontFamily: 'blogfont'),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 91, 4, 115))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 91, 4, 115),
                        ))),
              ),
              const SizedBox(
                height: 10,
              ),
              error.isNotEmpty
                  ? Text(
                      "*$error*",
                      style: TextStyle(
                          color: Colors.red[900], fontWeight: FontWeight.bold),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 91, 4, 115),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23))),
                child: const Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: "mainfont",
                        fontWeight: FontWeight.w200),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const SignUp();
                  }));
                },
                child: RichText(
                    textAlign: TextAlign.end,
                    text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: "Don't have an account? "),
                          // TextSpan(
                          //     text: "Sign Up",
                          //     style: TextStyle(
                          //         color: Color.fromARGB(255, 91, 4, 115),
                          //         fontSize: 18))
                        ],
                        style: TextStyle(
                          color: Color.fromARGB(255, 91, 4, 115),
                          fontSize: 17,
                        ))),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
