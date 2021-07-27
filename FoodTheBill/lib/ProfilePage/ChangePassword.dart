import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../UniversalWidgets/LogoBackButtonWidget.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _oldPassword = '';
  String _newPassword = '';
  bool _obscureTextOldPw = true;
  bool _obscureTextNewPw = true;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _oldPasswordFocusNode = FocusNode();
  final FocusNode _newPasswordFocusNode = FocusNode();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _oldPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    super.dispose();
  }

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
        final user = FirebaseAuth.instance.currentUser;
        final cred = EmailAuthProvider.credential(
            email: _email.toLowerCase().trim(), password: _oldPassword.trim());
        await user!.reauthenticateWithCredential(cred).then(
              (value) {
            user.updatePassword(_newPassword.trim()).then(
                    (value) =>
                    _auth.signOut().then((value) =>
                        Navigator.popUntil(context, ModalRoute.withName("/")))
                        .then((value) =>
                        Fluttertoast.showToast(
                            msg:
                            "Your Password has been changed, please log in again",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.grey,
                            fontSize: 20.0),),

            );
          },
        );

        print("Successfully changed password");
        // ignore: unnecessary_statements
        //Navigator.popUntil(context, ModalRoute.withName("/"));
      } catch (error) {
        authErrorHandling('Your Email or Your Passwords have been inputted wrongly', context);
        print("Password cannot be changed => " + error.toString());
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LogoBackButton(),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Change Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Form(
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
                            return 'Please enter a valid email';
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context)
                                .requestFocus(_oldPasswordFocusNode),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          filled: true,
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          fillColor: Colors.grey.shade200,
                        ),
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        key: ValueKey('old password'),
                        focusNode: _oldPasswordFocusNode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a valid Password';
                          } else if (value.length < 6) {
                            return 'Password needs to be at least 6 characters long';
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context)
                                .requestFocus(_newPasswordFocusNode),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          filled: true,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureTextOldPw = !_obscureTextOldPw;
                              });
                            },
                            child: Icon(
                              _obscureTextOldPw ? Icons.visibility : Icons
                                  .visibility_off,
                            ),
                          ),
                          labelText: 'Old Password',
                          fillColor: Colors.grey.shade200,
                        ),
                        obscureText: _obscureTextOldPw,
                        onSaved: (value) {
                          _oldPassword = value!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        key: ValueKey('new password'),
                        focusNode: _newPasswordFocusNode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a valid Password';
                          } else if (value.length < 6) {
                            return 'Password needs to be at least 6 characters long';
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
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureTextNewPw = !_obscureTextNewPw;
                              });
                            },
                            child: Icon(
                              _obscureTextNewPw ? Icons.visibility : Icons
                                  .visibility_off,
                            ),
                          ),
                          labelText: 'New Password',
                          fillColor: Colors.grey.shade200,
                        ),
                        obscureText: _obscureTextNewPw,
                        onSaved: (value) {
                          _newPassword = value!;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
            ),
          ],
        ),
      ),
    );
  }
}
