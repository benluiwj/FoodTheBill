import 'package:flutter/material.dart';
import 'package:foodthebillv2/RandomOrInputPage/RandomOrListPage.dart';
import './FoodQuery.dart';
import 'HomePageForm.dart';

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
  double CONTAINER_MARGIN = 20;
  double HORIZONTAL_PADDING = 64;
  double VERTICAL_PADDING = 16;
  double FONT_SIZE = 20;
  double LETTER_SPACING = 2.0;
  double SUBMIT_BUTTON_MARGIN = 40;
  int LOCATION_FIELD = 0;
  int CUISINE_FIELD = 1;
  int DISTANCE_FIELD = 2;
  int PRICE_FIELD = 3;
  String EMPTY_FIELD_MESSAGE = "Please enter";
  String SUBMIT_BUTTON_TEXT = "HELP ME!!";

  @override
  void dispose() {
    formFieldController.dispose();
    super.dispose();
  }

  String? fieldValidator(String? fieldInput) {
    if (fieldInput == null || fieldInput.isEmpty) {
      return EMPTY_FIELD_MESSAGE + fieldInput!.toLowerCase();
    }
    return null;
  }

  Widget submitButtonText() {
    return Text(
      SUBMIT_BUTTON_TEXT,
      style: TextStyle(
        color: Colors.white,
        fontSize: FONT_SIZE,
        letterSpacing: LETTER_SPACING,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget formField(String input) {
    return Container(
      margin: EdgeInsets.only(top: CONTAINER_MARGIN),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: HORIZONTAL_PADDING, vertical: VERTICAL_PADDING),
        child: TextFormField(
          validator: (fieldInput) {
            return fieldValidator(fieldInput);
          },
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            hintText: '$input',
          ),
          controller: formFieldController,
        ),
      ),
    );
  }

  Widget dropDownField(String field) {
    List<String>? res;
    switch (field) {
      case 'Cuisine':
        res = _query.cuisine!.getCuisines()!;
        break;

      case 'Price Range':
        res = _query.price!.getPrices()!;
        break;

      case 'Distance to restaurant':
        res = _query.distance!.getDistances()!;
        break;
    }

    String dropDownValue = res!.elementAt(0);

    return Container(
        margin: EdgeInsets.only(top: CONTAINER_MARGIN),
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: HORIZONTAL_PADDING, vertical: VERTICAL_PADDING),
            child: DropdownButtonFormField<String>(
                validator: (fieldInput) {
                  return fieldValidator(fieldInput);
                },
                value: dropDownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownValue = newValue!;
                  });
                  switch (newValue) {
                    case 'Cuisine':
                      _query.setCuisine(dropDownValue);
                      break;

                    case 'Price Range':
                      _query.setPrice(dropDownValue);
                      break;

                    case 'Distance to restaurant':
                      _query.setDistance(dropDownValue);
                      break;
                  }
                },
                items: res.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList())));
  }

  Widget submitButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(SUBMIT_BUTTON_MARGIN),
      child: ElevatedButton(
          child: submitButtonText(),
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
          ),
          onPressed: () {
            _query.setLocation(formFieldController.text);
            if (_formKey.currentState!.validate()) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return RandomOrListPage(
                    query: _query,
                  );
                }),
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            formField(_inputs[LOCATION_FIELD]),
            dropDownField(_inputs[CUISINE_FIELD]),
            dropDownField(_inputs[DISTANCE_FIELD]),
            dropDownField(_inputs[PRICE_FIELD]),
            submitButton(),
          ],
        ));
  }
}
