import 'package:expense_recorder/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class start extends StatefulWidget {
  start({super.key});

  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
  late List<transact> l1 = [
    transact(amount: 16.99, title: "New Shoes", time: DateTime.now())
  ];
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  bool input = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(child: Text("Expenses")),
            IconButton(
                onPressed: () {
                  input = !input;
                  setState(() {});
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          ],
        ),
      ),
      body: Column(
        children: [
          input == true
              ? Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: t1,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "Name of Product",
                            hintText: "Enter the Name",
                            prefixIcon: Icon(Icons.type_specimen),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: t2,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.currency_rupee),
                              border: OutlineInputBorder(),
                              labelText: "Amount",
                              hintText: "Enter the Amount"),
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          input == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_upward),
                        onPressed: () {
                          input = false;
                          setState(() {});
                        }),
                    Container(
                      child: TextButton(
                        onPressed: () {
                          if (t1.text == "" || double.parse(t2.text) <= 0)
                            return;
                          l1.add(transact(
                              amount: double.parse(
                                  double.parse(t2.text).toStringAsFixed(2)),
                              title: t1.text,
                              time: DateTime.now()));
                          setState(() {
                            t1.text = "";
                            t2.text = "";
                          });
                        },
                        child: Text(
                          "Add to list",
                          style: TextStyle(
                              color: Colors.purple, fontFamily: 'Schyler'),
                        ),
                        style: ButtonStyle(),
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),
          Column(
              children: l1.map((t1) {
            return Card(
              child: Container(
                margin: EdgeInsets.all(8),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          child: Center(
                            child: Text(
                              "\$ " + t1.amount.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              border:
                                  Border.all(color: Colors.purple, width: 5.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              t1.title,
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              DateFormat.yMd().format(t1.time),
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        l1.remove(t1);
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
