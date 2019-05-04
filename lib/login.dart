import 'package:flutter/material.dart';
import 'Signup1.dart';
import 'package:vonaapp/MyVoice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/flare_actor.dart';


class Login extends StatefulWidget {

  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();

}

class _LoginState extends State<Login> {


  final formKey= new GlobalKey<FormState>();

  String _email;
  String _password;

  bool validateAndSave(){

    final form=formKey.currentState;

    if(form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit()async{
    if(validateAndSave()) {
      try {
         await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        navigateToMainScreen(context);

      }
      catch(e){
        print('Errorrr:$e');

      }
    }
  }



  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  Future navigateToSignup1(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp1()));
  }
  Future navigateToMainScreen(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyVoice()));
  }



  @override
  Widget build(BuildContext context) {

    //NO DEVICE ROTATION
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);



    final emailField =  TextFormField(
      
      style: style,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "johndoe@gmail.com",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.white),
        ),


      ),
           //Validation
          validator:(value) => value.isEmpty ? "field can't be empty!" : null,
           onSaved:(value) => _email = value,
    );


    final passwordField =  TextFormField(


      obscureText: true,
      style: style,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.vpn_key),
        filled: true,
        fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "password",


        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.white),

        ),
      ),

        validator:(value) => value.isEmpty ? "field can't be empty!" : null,
        onSaved:(value) => _password = value,

    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: const Color(0xFFEF8912),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          validateAndSubmit();
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    //hypertext
   final text=  new InkWell(
      child: new Text(
        "Create an account",
        style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
      ),

      onTap: () {
        navigateToSignup1(context);
      },
    );


    return Scaffold(

      //Removing Bottom overflowed error
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
          color: const Color(0xFFFFBC3E),
          child: Padding(
            padding: const EdgeInsets.all(36.0),
             child: Form(
              key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,


                  children: <Widget>[
                    new SizedBox(
                      height: 179.0,
                      width: 179.0,
                      child:
                      Image.asset(
                        "assets/Vona3x.png",
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                    ),/*
                    new SizedBox(
                      height: 200.0,
                      width: 200.0,
                      child:
                      Image.asset(
                        "assets/Vonaface3x.png",
                        fit: BoxFit.contain,
                      ),
                    ),*/


                SizedBox(height: 35.0),

                emailField,
                SizedBox(height: 20.0),

                passwordField,
                SizedBox(height: 20.0),

                    //warning,
              //      SizedBox(height: 10.0),

                    loginButon,
                SizedBox(height: 35.0),

                text,
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
