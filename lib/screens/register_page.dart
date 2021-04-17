import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
      TextEditingController();

  void registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);

    Navigator.pop(context);
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

    var registerBanner = Container(
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

    var passwordConfirmationField = Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 54.0,
      width: 280.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: _passwordConfirmationController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 20.0),
        decoration: InputDecoration(
            hintText: 'confirm password',
            prefixIcon: Icon(Icons.lock),
            border: InputBorder.none),
      ),
    );

    var registerButton = GestureDetector(
      onTap: () {
        // loginUser();
        if (_passwordController.text == _passwordConfirmationController.text)
          registerUser();
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: 54.0,
        width: 280.0,
        decoration: BoxDecoration(
            color: Colors.lightBlue[800],
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Text('Register',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    var loginLink = GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          child: Text('Or login here',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45))),
    );

    var registerForm = Container(
      padding: EdgeInsets.only(top: 40, left: 30, right: 30),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          emailField,
          passwordField,
          passwordConfirmationField,
          registerButton,
          loginLink
        ],
      ),
    );

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [registerBanner, Expanded(child: registerForm)],
      ),
    ));
  }
}
