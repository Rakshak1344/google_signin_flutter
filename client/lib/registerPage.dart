import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/userResponseModels/userFailureModel.dart';
import 'models/userResponseModels/userSuccessModel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  registerWithEmailPassword() async {
    try {
      String email = emailController.text;
      String password = passwordController.text;
      Uri uri = Uri.parse("http://10.0.2.2:3000/register");
      Map<String, String> body = {"email": email, "password": password};
      // String jsonBody = jsonEncode(body);
      http.Response response = await http.post(uri, body: body);
      // print("Response.body ===> ${response.body}");

      if (response.statusCode == 201) {
        UserSuccessModel successData = UserSuccessModel.fromJson(jsonDecode(response.body));
        print(successData);
        print(successData.token);
      } else {
        UserFailureModel failedData = UserFailureModel.fromJson(jsonDecode(response.body));
        print(failedData);
        print(failedData.message);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "example@gamil.com",
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "*********",
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.app_registration),
                      label: Text("Register"),
                      onPressed: registerWithEmailPassword,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
