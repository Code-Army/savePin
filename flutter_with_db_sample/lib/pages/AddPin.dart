import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_db_sample/models/pin.dart';
import 'package:flutter_with_db_sample/widgets/SuccessAlert.dart';

/**
 * class to related to add pins to the db
 */
class AddPin extends StatefulWidget {
  const AddPin({Key key}) : super(key: key);

  @override
  _AddPinState createState() => _AddPinState();
}

class _AddPinState extends State<AddPin> {
  final _addItemFormKey = GlobalKey<FormState>();
  String type = '1';
  String category = 'Web/App';
  List types = ["Credit Card", "Web/App", "Other"];

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPin = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();

  //set numerical type based on the string type
  void setType(String category) {
    type = '1';
    switch (category) {
      case 'Web/App':
        setState(() {
          type = '1';
        });
        break;
      case 'Other':
        setState(() {
          type = '2';
        });
        break;
      default:
        setState(() {
          type = '3';
        });
    }
  }

  /**
   * method to decide the input fields based on the user selected type
   */
  Widget getFields(String type) {
    switch (type) {
      case '1':
        return Column(
          children: [
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    labelText: 'USERNAME',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.grey[700]),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.indigo[900]),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10))),
                controller: _controllerUsername,
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.grey[700]),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.indigo[900]),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10))),
                controller: _controllerPin,
              ),
            ),
          ],
        );
        break;

      case '2':
        return Column(
          children: [
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    labelText: 'PIN',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.grey[700]),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.indigo[900]),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10))),
                controller: _controllerPin,
              ),
            ),
          ],
        );
        break;

      default:
        return Column(
          children: [
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    labelText: 'PIN',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.grey[700]),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.indigo[900]),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10))),
                controller: _controllerPin,
              ),
            ),
          ],
        );
    }
  }

  /**
   * set the categories based on the  numerical type
   */
  void setCategory(int type) {
    if (type == 1) {
      setState(() {
        category = 'Credit Card';
      });
    } else if (type == 2) {
      setState(() {
        category = 'Web / App';
      });
    } else {
      setState(() {
        category = 'Other';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.lightBlue, Colors.indigo[900]])),
        ),
        title: Text('$category'),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 0.0),
                  child: Text(
                    '$category',
                    style:
                        TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    labelText: 'DISPLAY NAME',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.grey[700]),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.indigo[900]),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10))),
                controller: _controllerName,
              ),
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.indigo[900], width: 2.0)),
                child: DropdownButton(
                  dropdownColor: Colors.grey[200],
                  hint: Text(
                    'SELECT A TYPE',
                    style: TextStyle(color: Colors.grey),
                  ),
                  icon: Icon(Icons.arrow_drop_down_circle),
                  iconDisabledColor: Colors.grey,
                  iconEnabledColor: Colors.indigo[900],
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                  isExpanded: true,
                  elevation: 10,
                  value: category,
                  items: types.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      category = value;
                    });

                    setType(category);
                  },
                ),
              ),
            ),
            getFields(type),
            SizedBox(height: 50.0),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                height: 50.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.blueAccent,
                  color: Colors.lightBlue[700],
                  elevation: 6.0,
                  child: GestureDetector(
                    onTap: () async {
                      await Pin.addItem(
                        name: _controllerName.text,
                        pin: _controllerPin.text,
                        type: type,
                        username: _controllerUsername.text,
                      );

                      setState(() {
                        _controllerName.text = "";
                        _controllerPin.text = "";
                        _controllerUsername.text = "";
                      });
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SuccessAlert('Pin added Successfully');
                          });
                    },
                    child: Center(
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                )),
            SizedBox(height: 40.0)
          ],
        ),
      ),
    );
  }
}
