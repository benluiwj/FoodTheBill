import 'package:flutter/material.dart';
import '../../RandomOrInputPage/RandomOrInputPageWidget.dart';
import 'FoodQuery.dart';
import 'HomePageForm.dart';
import 'Cuisines.dart';
import 'PriceRanges.dart';

class HomePageFormState extends State<HomePageForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _inputs = ['Your Location', 'Cuisine', 'Price Range'];
  final formFieldController = TextEditingController();
  Cuisines cuisines = Cuisines();
  PriceRanges price = PriceRanges();
  FoodQuery _query = FoodQuery();

  @override
  void dispose() {
    formFieldController.dispose();
    super.dispose();
  }

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

  Widget dropDownField(String val) {
    List<String> res;
    if (val == 'Cuisine')
      res = _query.cuisines!.getCuisines()!;
    else
      res = _query.price!.getPrices()!;

    String dropDownValue = res.elementAt(0);

    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
            child: DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == res.elementAt(0))
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
                  else
                    _query.setPrice(dropDownValue);
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
                MaterialPageRoute(
                    builder: (context) => RandomOrInputPageWidget(
                          query: _query,
                        )),
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
            formField(_inputs[0]),
            dropDownField(_inputs[1]),
            dropDownField(_inputs[2]),
            submitButton(),
          ],
        ));
  }
}
