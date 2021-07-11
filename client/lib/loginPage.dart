import 'package:client/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  navigateRegisterPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  }

  loginWithEmailPassword() async {
    try {
      String email = emailController.text;
      String password = passwordController.text;
      Uri uri = Uri.parse("http://10.0.2.2:3000/login");
      Map<String, String> body = {"email": email, "password": password};
      // String jsonBody = jsonEncode(body);
      var response = await http.post(uri, body: body);
      print("Response.body ===> ${response.body}");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic Authentication"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
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
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      icon: Icon(Icons.login),
                      label: Text("Login"),
                      onPressed: loginWithEmailPassword,
                    ),
                    Divider(thickness: 2),
                    Text("OR"),
                    ElevatedButton.icon(
                      icon: Icon(Icons.app_registration),
                      label: Text("Register"),
                      onPressed: navigateRegisterPage,
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.app_registration),
                      label: Text("Google"),
                      onPressed: () async {
                        SharedPreferences prefs = await _prefs;
                        var token = prefs.getString("token");
                        print('token from shared prefs $token');
                      },
                    ),
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
