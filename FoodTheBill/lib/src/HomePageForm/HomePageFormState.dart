import 'package:flutter/material.dart';
import 'package:milestone1/src/Secondpage/SecondPage.dart';
import './FoodQuery.dart';
import 'HomePageForm.dart';

/// This class contains the main logic of the form to be filled in by users

class HomePageFormState extends State<HomePageForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _inputs = [
    'Your Location',
    'Cuisine',
    'Distance to restaurant',
    'Price Range'
  ];
  final formFieldController = TextEditingController();
  FoodQuery _query = new FoodQuery();

  /// Disposing the form controller once it is done

  @override
  void dispose() {
    formFieldController.dispose();
    super.dispose();
  }

  /// Returns a widget that displays the current value selected by the user.
  /// This widget is meant for users to input in a location.

  Widget formField(String value) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
        child: TextFormField(
          validator: (val) {
            if (val == null || val.isEmpty)
              return "Please enter ${value.toLowerCase()}";
            return null;
          },
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            hintText: '$value',
          ),
          controller: formFieldController,
        ),
      ),
    );
  }

  /// Returns a widget that changes the display based on what the user
  /// has selected from the drop down list of options.
  /// For example, there are 4 valid cuisine choices. When the user selects one of them,
  /// that choice would be displayed in the widget.

  Widget dropDownField(String val) {
    List<String>? res;
    if (val == 'Cuisine') {
      res = _query.cuisine!.getCuisines()!;
    } else if (val == 'Price Range') {
      res = _query.price!.getPrices()!;
    } else {
      res = _query.distance!.getDistances()!;
    }

    String dropDownValue = res.elementAt(0);

    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
            child: DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == res!.elementAt(0))
                    return "Please enter ${val.toLowerCase()}";
                  return null;
                },
                value: dropDownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownValue = newValue!;
                  });
                  if (val == 'Cuisine')
                    _query.setCuisine(dropDownValue);
                  else if (val == 'Price Range')
                    _query.setPrice(dropDownValue);
                  else
                    _query.setDistance(dropDownValue);
                },
                items: res.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList())));
  }

  /// Returns a widget that brings the user to the next page

  Widget submitButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(40),
      padding: EdgeInsets.only(top: 20),
      child: ElevatedButton(
          child: Text(
            "HELP ME!!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 2.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
          ),
          onPressed: () {
            _query.setLocation(formFieldController.text);
            if (_formKey.currentState!.validate()) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  /*return Recommended(
                    query: _query,
                  );*/
                  return SecondPage(query: _query);
                  //return GoNext();
                }),
              );
            }
          }),
    );
  }

  /// Returns a widget that returns a form together with a submission button

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            formField(_inputs[0]),
            dropDownField(_inputs[1]),
            dropDownField(_inputs[2]),
            dropDownField(_inputs[3]),
            submitButton(),
          ],
        ));
  }
}
