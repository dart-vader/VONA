import 'package:flutter/material.dart';
import 'Signup2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'database.dart';


class SignUp1 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //NO DEVICE ROTATION
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Flutter Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

 class _MyHomePageState extends State<MyHomePage> {

  String name;
  String email;
  String phone;
  String password;

  addUser userInfo = new addUser();

  final formKey= new GlobalKey<FormState>();

  bool validateAndSave(){

    final form=formKey.currentState;

    if(form.validate()) {
      form.save();
      navigateToSubPage(context);
      return true;
    }
    return false;
  }

  void validateAndSubmit()async{
    if (validateAndSave()) {
      try {
         await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
         navigateToSubPage(context);
        }
      catch (e) {
        print(e);
      }
    }
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);


  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp2()));
  }

  @override
  Widget build(BuildContext context) {

    final nameField = TextFormField(

      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),

          validator:(value) => value.isEmpty ? "field can't be empty!" : null,
          onSaved:(value) => name = value

    );

    final emailField = TextFormField(

      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),

          validator:(value) => value.isEmpty ? "field can't be empty!" : null,
          onSaved:(value) => email = value,


    );


    final phoneField = TextFormField(

      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Phone Number",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),

          validator:(value) => value.isEmpty ? "field can't be empty!" : null,
          onSaved:(value) => phone = value,


    );


    final passwordField = TextFormField(

      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:

          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),

          validator:(value) => value.isEmpty ? "field can't be empty!" : null,
          onSaved:(value) => password = value,
         // initialValue:password,



    );


    final passwordagainField = TextFormField(

      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirm password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),

        validator:(value) => value.isEmpty ? "field can't be empty!" : null
      // validator:(value) => value.isEmpty ? "field can't be empty!" : value == passwordField.initialValue ? null : "not same"


    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFFEF8912),
      //color: Color.fromRGBO(255, 188, 62, 1),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          validateAndSubmit();

          userInfo.addData({
            'Name': name,
            'Email': email,
            'Phone': phone,
            'Password': password,
           // 'Childname': childname,
           // 'Age': age,
           // 'Gender': gender,
          });

        },
        child: Text("Next",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );


    return Scaffold(
      //Removing Bottom overflowed error
    resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
              child: Form(
                key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

               /* SizedBox(
                  height: 80.0,
                  width: 179.0,
                  child:
                  Image.asset(
                    "assets/Vona3x.png",
                    fit: BoxFit.contain,
                  ),
                ),*/
                nameField,
                SizedBox(height: 15.0),

                emailField,
                SizedBox(height: 15.0),

                phoneField,
                SizedBox(height: 15.0),

                passwordField,
                SizedBox(height: 15.0),

                passwordagainField,
                SizedBox(height: 15.0),

                loginButon,
                SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
