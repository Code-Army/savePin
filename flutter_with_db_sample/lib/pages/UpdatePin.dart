import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_db_sample/models/pin.dart';
import 'package:flutter_with_db_sample/widgets/edit_pin_form.dart';


class EditScreen extends StatefulWidget{
  final String CurrentName;
  final String CurrentPin;
  final String CurrentUsername;
  final String CurrentType;
  final String documentId;

  EditScreen({
     this.CurrentName,
     this.CurrentPin,
     this.CurrentType,
     this.CurrentUsername,
     this.documentId,
});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen>{

  final FocusNode _NameFocusNode = FocusNode();
  final FocusNode _PinFocusNode = FocusNode();
  final FocusNode _TypeFocusNode = FocusNode();
  final FocusNode _UserNameFocusNode = FocusNode();

  bool _isDeleting = false;

  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        _NameFocusNode.unfocus();
        _PinFocusNode.unfocus();
        _UserNameFocusNode.unfocus();
        _TypeFocusNode.unfocus();
      },
     child: Scaffold(
       backgroundColor: Colors.grey[200],
       appBar: AppBar(
         flexibleSpace: Container(
           decoration: BoxDecoration(
               gradient: LinearGradient(begin: Alignment.topRight,end: Alignment.bottomLeft,
                   colors:[Colors.lightBlue,Colors.blue[900]] )
           ),
         ),

         title: Text('Pins'),
         centerTitle: true,
         elevation: 0,
         actions: [
           _isDeleting ? Padding(
             padding: const EdgeInsets.only(
               top: 10.0,
               bottom: 10.0,
               right: 16.0
             ),
             //delete pin progress and delete button
             child: CircularProgressIndicator(
               valueColor: AlwaysStoppedAnimation<Color>(
                 Colors.redAccent,
               ),
               strokeWidth: 3,
             ),
           )
               :IconButton(
             icon: Icon(
               Icons.delete,
               color: Colors.redAccent,
               size: 32,
             ),
             onPressed: () async {
               setState(() {
                 _isDeleting = true;
               });
               // delete pin
               await Pin.deletePin(
                 docId: widget.documentId,
               );

               setState(() {
                 _isDeleting = false;
               });

               Navigator.of(context).pop();
               //success alert
               CoolAlert.show(
                 context: context,
                 type: CoolAlertType.success,
                 text: "Pin delete was successful!",
               );
             },
           ),
         ],
       ),
       body: SafeArea(
         child: Align(
           alignment: Alignment.center,
         child: Padding(
           padding: const EdgeInsets.only(
             left: 10.0,
             right: 10.0,
             bottom: 0.0,
             top: 100.0
           ),
           //widget call edit form
           child: EditPinForm(
             documentId: widget.documentId,
             nameFocusNode: _NameFocusNode,
             pinFocusNode: _PinFocusNode,
             userNameFocusNode: _UserNameFocusNode,
             typeFocusNode: _TypeFocusNode,

             CurrentName: widget.CurrentName,
             CurrentPin: widget.CurrentPin,
             CurrentUserName: widget.CurrentUsername,
             CurrentType: widget.CurrentType,

           ),
         ),
       ),
       ),
     ),
    );
  }
}