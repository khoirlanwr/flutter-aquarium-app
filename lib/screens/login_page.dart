import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser() {
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    var logo = Column(
      children: [
        Image(image: AssetImage('assets/images/icons-water.png')),
        Text('Aquarium Monitoring App',
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white))
      ],
    );

    var bannerLogin = Container(
      height: 300,
      width: 450,
      padding: EdgeInsets.only(top: 100, left: 30, right: 30),
      alignment: Alignment.center,
      child: logo,
      decoration: BoxDecoration(
          color: Colors.lightBlue[800],
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))),
    );

    var emailField = Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 54.0,
      width: 280.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 20.0),
        decoration: InputDecoration(
            hintText: 'username',
            prefixIcon: Icon(Icons.person),
            border: InputBorder.none),
      ),
    );

    var passwordField = Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 54.0,
      width: 280.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: _passwordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 20.0),
        decoration: InputDecoration(
            hintText: 'password',
            prefixIcon: Icon(Icons.lock),
            border: InputBorder.none),
      ),
    );

    var loginButton = GestureDetector(
      onTap: () {
        loginUser();
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: 54.0,
        width: 280.0,
        decoration: BoxDecoration(
            color: Colors.lightBlue[800],
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Text('Login',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    var registerLink = GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/register');
      },
      child: Container(
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          child: Text('Or register here',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45))),
    );

    var loginForm = Container(
      padding: EdgeInsets.only(top: 40, left: 30, right: 30),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [emailField, passwordField, loginButton, registerLink],
      ),
    );

    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          children: [bannerLogin, Expanded(child: loginForm)],
        ),
      ),
    ));
  }
}
