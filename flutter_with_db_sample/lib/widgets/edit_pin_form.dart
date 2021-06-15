import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_with_db_sample/models/pin.dart';


class EditPinForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode pinFocusNode;
  final FocusNode userNameFocusNode;
  final FocusNode typeFocusNode;

  final String CurrentName;
  final String CurrentPin;
  final String CurrentUserName;
  final String CurrentType;
  final String documentId;

  const EditPinForm({
     this.nameFocusNode,
     this.pinFocusNode,
     this.userNameFocusNode,
     this.typeFocusNode,

     this.CurrentName,
     this.CurrentPin,
     this.CurrentUserName,
     this.CurrentType,
     this.documentId,
  });

  @override
  _EditPinFormState createState() => _EditPinFormState();
}

class _EditPinFormState extends State<EditPinForm> {
  final _editPinFormKey = GlobalKey<FormState>();



  bool _isProcessing = false;

   TextEditingController _nameController;
   TextEditingController _pinController;
   TextEditingController _usernameController;
   TextEditingController _typeController;

  bool _isVisible = true;

  @override
  void initState() {
    _nameController = TextEditingController(
      text: widget.CurrentName,
    );

    _pinController = TextEditingController(
      text: widget.CurrentPin,
    );

    _usernameController = TextEditingController(
      text: widget.CurrentUserName,
    );

    _typeController = TextEditingController(
      text: widget.CurrentType,
    );
    super.initState();


    }

  @override
  Widget build(BuildContext context) {
    return Form(
    key: _editPinFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.0),
                // name
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0),
                  child: TextField(decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
                        labelText: 'Name',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.grey[700]
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: Colors.indigo[900]),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: Colors.lightBlue),
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    controller: _nameController,
                    focusNode: widget.nameFocusNode, cursorColor: Colors.lightBlue,
                  ),
                ),

                // user name
                Visibility(
            visible: ((_typeController.text == "1"? true:false)),
            child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,0.0),
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
                        labelText: 'User Name',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.grey[700]
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: Colors.indigo[900]),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: Colors.lightBlue),
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    controller: _usernameController,
                    focusNode: widget.userNameFocusNode,
                  ),
                  ),
),
                SizedBox(height: 15.0),
                // Pin
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0),
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
                        labelText: 'PIN',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.grey[700]
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: Colors.indigo[900]),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: Colors.lightBlue),
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    controller: _pinController,
                    focusNode: widget.pinFocusNode,
                  ),
                ),
              ],
            ),
          ),
          _isProcessing
              ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.lightBlue[700],
              ),
            ),
          )
              : Container(
            width: double.maxFinite,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.lightBlue[700],
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () async {
                widget.nameFocusNode.unfocus();
                widget.pinFocusNode.unfocus();

                  setState(() {
                    _isProcessing = true;
                  });
                  //pin update
                  await Pin.updatePins(
                    docId: widget.documentId,
                    name: _nameController.text,
                    pin: _pinController.text,
                    username: _usernameController.text,
                  );

                  setState(() {
                    _isProcessing = false;
                  });
                  Navigator.of(context).pop();
                  // pin update success alert
                  CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  text: "Pin Update was successful!",
                );
                },


              child: Padding(
                //pin update button
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Text(
                  'UPDATE PIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
}
}
