import 'package:flutter/material.dart';
/*
** class for success message
* refered from https://www.warmodroid.xyz/tutorial/flutter/custom-alert-dialog-in-flutter/
 */
class SuccessAlert extends StatelessWidget {
  final title;
  SuccessAlert(this.title);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
       height: 200,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white70,
                  child: Image.asset('assets/success.png'),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.green[600],
                  child: SizedBox.expand(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(title,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.green
                            ),

                            child: Text('Got it'),
                            onPressed: ()=> {
                            Navigator.of(context).pop(),

                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}