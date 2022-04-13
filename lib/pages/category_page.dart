import 'package:casher/listview_data/operation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  String? getCurrency(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    return format.currencyName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E1F1),
      body: operations.isEmpty?const Center(child: Text("Нет последних операций")):ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: operations.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 60,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(16)
                      ),
                  ),
                  child: Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      operations[index].icon,
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${operations[index].text} - ${operations[index].value} ${getCurrency(context)}',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}