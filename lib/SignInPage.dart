import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignInPage extends StatefulWidget {
  @override
   _SignInPageState createState() => _SignInPageState();
}
class _SignInPageState extends State<SignInPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _email, _password;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) async{
      if(user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }

    });
  }

  navigateToSignUpScreen(){
    Navigator.pushReplacementNamed(context, "/SignUpPage");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthentication();
  }

  void signin() async {
    if(_formkey.currentState.validate()) {
      _formkey.currentState.save();
      
      try {
        AuthResult user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      } catch (e) {
        showError(e.message);
      }
    }
  }


  showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } 
    );

  }

   @override
   Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Sign in'),
       ),
       body: Container(
         child: Center(
           child: ListView(
             children: <Widget>[
               Container(
                 padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
                 child: Image(image: AssetImage("assets/logo.png"),
                 width: 100.0,
                 height: 100.0,
                 ),
               ),
               Container(
                 padding: EdgeInsets.all(16.0),
                 child: Form(
                   key: _formkey,
                   child: Column(
                     children: <Widget>[
                       //email
                       Container(
                         padding: EdgeInsets.only(top: 20.0),
                         child: TextFormField(
                           validator: (input){
                             if (input.isEmpty) {
                               return 'Provide an email';
                             }
                           },
                           decoration: InputDecoration(
                             labelText: 'Email',
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(5.0)
                             )
                           ),
                           onSaved: (input) => _email = input,
                         ),
                       ),
                       //password
                       Container(
                         padding: EdgeInsets.only(top: 20.0),
                         child: TextFormField(
                           validator: (input){
                             if (input.length < 6) {
                               return 'Password should be 6 character atleast';
                             }
                           },
                           decoration: InputDecoration(
                             labelText: 'Password',
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(5.0)
                             )
                           ),
                           onSaved: (input) => _password = input,
                           obscureText: true,
                         ),
                       ),
                       Container(
                         padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                         child: RaisedButton(
                           padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                           color: Colors.blue,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(5.0)
                           ),
                           onPressed: signin,
                           child: Text('Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                            ),
                           ),
                         ),
                       ),
                       //redirect to Signup page
                       GestureDetector(
                         onTap: navigateToSignUpScreen,
                         child: Text(
                           'Create an account',
                           textAlign: TextAlign.center,
                           style: TextStyle(fontSize: 16.0) 
                         ),
                       )
                     ],
                   )
                 ),
               )
             ],
           )
         )
       ),
    );
  }


} 