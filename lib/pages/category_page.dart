import 'package:casher/Model/database.dart';
import 'package:casher/Model/operations_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late MyDatabase _database;
  bool isChecked = false;

  @override
  void initState() {
    _database = MyDatabase();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _database.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Casher', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurpleAccent,
      ),
      backgroundColor: const Color(0xFFE7E1F1),
      body: FutureBuilder<List<Operation>>(
        future: _database.getOperations(),
        builder: (context, snapshot) {
          operationsList = snapshot.data;
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error with fetching data!'),
            );
          }
          return operationsList!.isEmpty ?const Center(child: Text("Нет последних операций")):ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: operationsList!.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onLongPress: () {
                  if (!selectedOperation.contains(index)) {
                    setState(() {
                      selectedOperation.add(index);
                      isChecked = true;
                    });
                  }
                },
                onTap: () {
                  if (selectedOperation.contains(index)) {
                    setState(() {
                      selectedOperation.removeWhere((element) => element == index);
                      isChecked = false;
                    });
                  }
                },
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                        color: (selectedOperation.contains(index))?Colors.deepPurpleAccent.withOpacity(0.2):Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ignore: unrelated_type_equality_checks
                              if (operationsList![index].tag == 1)
                                const Icon(CupertinoIcons.arrow_turn_left_up, color: Colors.lightGreen)
                              else
                                const Icon(CupertinoIcons.arrow_turn_left_down, color: Colors.redAccent),
                              Text(
                                // ignore: invalid_use_of_protected_member
                                '${operationsList![index].operation} - ${operationsList![index].value} BYN',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 4)),
                  ],
                ),
              );
            },
          );
        }
      ),
    );
  }
}