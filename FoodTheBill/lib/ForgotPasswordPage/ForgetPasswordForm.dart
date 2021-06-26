import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPasswordForm extends StatefulWidget {
  @override
  _ForgetPasswordFormState createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String _emailAddress = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> authErrorHandling(String text, BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 6.0),
                child: Image.network(
                  'http://image.flaticon.com/icons/png/128/564/564619.png',
                  width: 20,
                  height: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Error Occurred'),
              )
            ],
          ),
          content: Text(
            text,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        await _auth
            .sendPasswordResetEmail(email: _emailAddress.trim().toLowerCase())
            .then((value) => Fluttertoast.showToast(
            msg: "An email has been sent to your email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          fontSize: 16.0));
        // ignore: unnecessary_statements
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        authErrorHandling("Invalid Email", context);
        print('error occurred $error');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                key: ValueKey('email'),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  } else {
                    return null;
                  }
                },
                textInputAction: TextInputAction.next,
                onEditingComplete: _submitForm,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email Address',
                  fillColor: Colors.grey.shade200,
                ),
                onSaved: (value) {
                  _emailAddress = value!;
                },
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Change Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        letterSpacing: 2.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.lock,
                      size: 20,
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                onPressed: _submitForm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
