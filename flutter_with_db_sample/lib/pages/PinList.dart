import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_db_sample/models/pin.dart';

import 'UpdatePin.dart';

/**
 * class to retrive all the pins in the db
 */
class PinList extends StatelessWidget {
  String categoryImage;
  String pin;
  String username;
  String type;
  String name;
  List<Pin> categorizedList = [];
  List<Pin> pinlist = [];

  /**
   * method to set the string type of category
   */
  String getType(String t) {
    switch (t) {
      case '1':
        return 'Web/App';
        break;
      case '2':
        return 'Other';
        break;
      default:
        return 'Credit Card';
        break;
    }
  }

  /**
   * method to decide the image in the card based on the type
   */
  String getImage(String type) {
    switch (type) {
      case '1':
        return 'app.png';
        break;
      case '2':
        return 'other.png';
        break;
      default:
        return 'creditcard.png';
        break;
    }
  }

  /**
   * method to categorized pins from db to their types
   */
  List<Pin> _categorizeList(List<Pin> pinlist, String category) {
    pinlist.forEach((pin) {
      if (pin.type == category) {
        categorizedList.add(pin);
      }
    });
    return categorizedList;
  }

  /**
   * method to assign the DB retrieved pins to
   * Pin type List
   */
  void getPins(List<QueryDocumentSnapshot<Object>> pins) {
    print(pins.length);
    print(pins[0]["name"]);

    for (int index = 0; index < pins.length; index++) {
      name = pins[index]["name"];
      type = pins[index]["type"];
      username = pins[index]["username"];
      pin = pins[index]["pin"];

      Pin pinObject = Pin(name: name, type: type, username: username, pin: pin);
      pinlist.add(pinObject);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _pinStream = Pin.retrievePins();

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
        title: Text('Pins'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 8.0),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Icon(
                  Icons.widgets_outlined,
                  size: 30.0,
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                    onPrimary: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: EdgeInsets.all(15.0)),
              ),
              ElevatedButton(
                onPressed: () {
                  String t = '3';
                  String category = getType(t);
                  categorizedList.clear();
                  Navigator.pushNamed(context, '/categorizedList', arguments: {
                    'pinList': _categorizeList(pinlist, t),
                    'type': category,
                  });
                },
                child: Icon(Icons.credit_card, size: 30.0),
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                    onPrimary: Colors.indigo[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: EdgeInsets.all(15.0)),
              ),
              ElevatedButton(
                onPressed: () {
                  String t = '1';
                  String category = getType(t);
                  categorizedList.clear();
                  Navigator.pushNamed(context, '/categorizedList', arguments: {
                    'pinList': _categorizeList(pinlist, t),
                    'type': category,
                  });
                },
                child: Icon(Icons.phone_android, size: 30.0),
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                    onPrimary: Colors.indigo[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: EdgeInsets.all(15.0)),
              ),
              ElevatedButton(
                onPressed: () {
                  String t = '2';
                  String category = getType(t);
                  categorizedList.clear();
                  Navigator.pushNamed(context, '/categorizedList', arguments: {
                    'pinList': _categorizeList(pinlist, t),
                    'type': category,
                  });
                },
                child: Icon(
                  Icons.dialpad,
                  size: 30.0,
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                    onPrimary: Colors.indigo[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: EdgeInsets.all(15.0)),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _pinStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Container(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                value: 4.0,
                              )));
                    } else {
                      final pins = snapshot.data.docs;
                      pinlist.clear();
                      //print('all items');
                      print(pins.length); //20
                      getPins(pins);
                      return ListView.builder(
                        itemCount: pins.length,
                        itemBuilder: (context, index) {
                          var pinInfo = snapshot.data.docs[index].data();
                          String category = pins[index]["type"];
			                    String docId = pins[index].id;
                          String name = pins[index]["name"];
                          String username = pins[index]["username"];
                          String pin = pins[index]["pin"];

                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Card(
                              child: ListTile(
                                onTap: ()=>Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=> EditScreen(
                                  CurrentName: name,
                                  CurrentPin: pin,
                                  CurrentUsername: username,
                                  CurrentType: category, 
                                  documentId: docId,

                                ))
                                ),

                                title: Text(
                                  pins[index]["name"],
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Montserrat'),
                                ),
                                subtitle: Text(
                                  '${getType(pins[index]["type"])}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/${getImage(category)}'),
                                  backgroundColor: Colors.grey[300],
                                  foregroundColor: Colors.indigo[900],
                                  radius: 20.0,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              elevation: 6.0,
                            ),
                          );
                        },
                      );
                    }
                  })) // ,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addPin');
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue[900],
      ),
    );
  }
}
