import 'package:flutter/material.dart';
import 'package:flutter_with_db_sample/models/pin.dart';
import 'package:flutter_with_db_sample/pages/PinList.dart';

/**
 * class to display the categorized pins
 */
class PinListCategorized extends StatelessWidget {
  Map data = {};
  PinList pins;
  List<Pin> pinList = [];
  String category;

  /**
   * get the image for the card based on the string type category
   */
  String getImage(String type) {
    switch (type) {
      case 'Web/App':
        return 'app.png';
        break;
      case 'Other':
        return 'other.png';
        break;
      default:
        return 'creditcard.png';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    pinList.clear();
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    pinList = data['pinList'];
    category = data['type'];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.lightBlue, Colors.indigo[900]])),
        ),
        title: Text('${data['type']}'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: pinList.length,
        itemBuilder: (context, index) {
          // print(pinList);
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Card(
              child: ListTile(
                onTap: () {},
                title: Text(
                  pinList[index].name,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat'),
                ),
                subtitle: Text(
                  data['type'],
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${getImage(category)}'),
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.indigo[900],
                  radius: 25.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 6.0,
            ),
          );
        },
      ),
    );
  }
}
