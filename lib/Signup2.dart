import 'package:flutter/material.dart';
import 'package:vonaapp/MyVoice.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';
import 'package:vonaapp/Signup1.dart';


class SignUp2 extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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



/*
  void validateAndSubmit()async{
    if(_MyHomePageState().validateAndSave()) {
      try {
        FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        print('Signed in: ${user.uid}');
        navigateToSubPage(context);

      }
      catch(e){
        print('Error:$e');
      }
    }

  }
*/


  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    String childname;
    String age;
    String genderr;

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


  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyVoice()));
  }

//Radio buttons creation

  int value;
  // a method for radio buttons
  void something(int e){
    setState(() {
      if(e==0){
        value = 0;
        genderr="0";
      }
      else if(e==1){
        value = 1;
        genderr="1";
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    //NO DEVICE ROTATION
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


    final childnameField = TextFormField(

      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Child's name",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),

          validator:(value) => value.isEmpty ? "field can't be empty!" : null,
          onSaved:(value) => childname = value



    );

    final ageField  = TextFormField(

      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Age",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),

          validator:(value) => value.isEmpty ? "field can't be empty!" : null,
          onSaved:(value) => age = value

    );



    final gender= new Row(
    children: <Widget>[
      new Radio(value: 0, groupValue: value, onChanged: (int e) => something(e),activeColor: Colors.blue),new Text("Male"),
      new Radio(value: 1, groupValue: value, onChanged: (int e) => something(e),activeColor: Colors.pink),new Text("Female"),
    ],

    );




    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: const Color(0xFFEF8912),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          validateAndSave();

          userInfo.addData({

            'Childname': childname,
            'Age': age,
            'Gender': genderr,
          });

        },
        child: Text("Done",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
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

               SizedBox(
                  height: 179.0,
                  width: 179.0,
                  child:
                  Image.asset(
                    "assets/Vona3x.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),

                childnameField,
                SizedBox(height: 20.0),

                ageField,
                SizedBox(height: 20.0),

                Text("Gender"),
                gender,

                loginButon,
                SizedBox(
                  height: 15.0,

                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
