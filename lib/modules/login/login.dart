import 'package:course_udemy/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LohInScreen extends StatefulWidget {
  const LohInScreen({Key? key}) : super(key: key);


  @override
  State<LohInScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LohInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool isPassShow = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        // ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formState,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 40,
                      ),
                      defaultTextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Email Address Not br Empty";
                          }
                          return null!;
                        },
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        labelText: "Email",
                        icon: Icons.email,
                        onFieldSubmitted: (val) {
                          if (kDebugMode) {
                            print(val);
                          }
                        },
                        onChanged: (val) {
                          if (kDebugMode) {
                            print(val);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Password Not br Empty";
                            }
                            return null!;
                          },
                          controller: password,
                          keyboardType: TextInputType.visiblePassword,
                          labelText: "Password",
                          icon: Icons.lock,
                          suffixPressed: () {
                            setState(() {
                              isPassShow = !isPassShow;
                            });
                          },
                          isPassShow: isPassShow,
                          suffixIcon: isPassShow == true
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash_fill),
                      const SizedBox(
                        height: 40,
                      ),
                      defaultButton(
                          text: "login",
                          onPressed: () {
                            if (formState.currentState!.validate()) {
                              if (kDebugMode) {
                                print(email.text);
                                print(password.text);
                              }
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {},
                            child: const Text("Register Now"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
