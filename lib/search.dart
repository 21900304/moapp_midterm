import 'dart:math';

import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Search")),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

// stores ExpansionPanel state information
class Item {
  Item({
    this.isExpanded = false,
  });
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item();
  });
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {


  DateTime? _selectedDate;

  final List<Item> _data = generateItems(1);
  bool _noKidzone = false;
  bool _petFriendly = false;
  bool _freebreakfast = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _data[index].isExpanded = !isExpanded;
              });
            },
            children: _data.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return const ListTile(
                    title: Text(
                      "Filter",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
                body: Column(
                  children: [
                    CheckboxListTile(
                      title: const Text('No Kidzone'),
                      value: _noKidzone,
                      onChanged: (bool? value) {
                        setState(() {
                          _noKidzone = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Pet Friendly'),
                      value: _petFriendly,
                      onChanged: (bool? value) {
                        setState(() {
                          _petFriendly = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Free Breakfast'),
                      value: _freebreakfast,
                      onChanged: (bool? value) {
                        setState(() {
                          _freebreakfast = value!;
                        });
                      },
                    ),
                  ],
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(14.5, 15, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Date",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 90
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        // do something with the selected date
                        _selectedDate = pickedDate;
                      }
                    },
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              SizedBox(
                height: 300,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 18),
                      backgroundColor: Colors.blue,
                      primary: Colors.white),
                  child: const Text('Sreach'),
                  onPressed: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Please check your choice :) '),
                          content: Column(
                            children: [
                              Container(
                                  child:  Text('\n Selected My option => \n'  ,style: TextStyle(color: Colors.black))
                              ),
                              Container(
                                  child: _noKidzone == true ? const Text("NoKidZone", style: TextStyle(color: Colors.blueAccent),) : const Text(".")
                              ),
                              Container(
                                  child: _petFriendly == true ? const Text("PetFriendly",style: TextStyle(color: Colors.blueAccent)) : const Text(".")
                              ),
                              Container(
                                  child: _freebreakfast == true ? const Text("Freebreakfast",style: TextStyle(color: Colors.blueAccent)) : const Text(".")
                              ),
                              Container(
                                  child:  Text('\n Check IN time =>  \n'  ,style: TextStyle(color: Colors.black))
                              ),
                              Container(
                                  child:  Text(' ${_selectedDate}'  ,style: TextStyle(color: Colors.blueAccent))
                              )
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: const Text('Search'),
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              } ,
                              child: const Text('Cancel'),
                            ),
                          ],
                        ));

                  },
                ),
              )

            ],
          ),
        )
      ],
    );
  }
}
