import 'package:casher/listview_data/operation.dart';
import 'package:casher/pages/signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late double _cash;
  late double _card;
  final Future<SharedPreferences> preferences = SharedPreferences.getInstance();

  bool _isLoading = false;

  double _number = 0;

  String? getCurrency() {
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    return format.currencyName;
  }

  final _moneyController = TextEditingController();
  final _incomeController = TextEditingController();
  final _expenseController = TextEditingController();

  DocumentReference docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(firebaseUser?.uid.toString());

  Future<void> _updateMoney() async {
    docRef.update (
        {
          "cash": _cash,
          "card": _card
        }
    );
    await _getInfo();
  }
  Future<void> _getInfo() async {
    setState(() {
      _isLoading = true;
    });
    await docRef.get().then((snapshot){
      setState(() {
        _cash = snapshot['cash'];
        _card = snapshot['card'];
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _getInfo();
    _updateMoney();
    super.initState();
  }

  final List<String> _moneyStores = [
    'Наличные',
    'Карта'
  ];
  String _selectedStore = 'Наличные';

  void _addCash() async{
    _cash += _number;
    _moneyController.clear();
    _number = 0;
    await _updateMoney();
  }

  void _addCard() async{
    _card += _number;
    _moneyController.clear();
    _number = 0;
    await _updateMoney();
  }

  void _minusCash() async{
    if (_number <= _cash) {
      _cash -= _number;
      _moneyController.clear();
      await _updateMoney();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(_errorSnackBar);
    }
    _number = 0;
    _moneyController.clear();
  }

  void _minusCard() async{
    if (_number <= _card) {
      _card -= _number;
      _moneyController.clear();
      await _updateMoney();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(_errorSnackBar);
    }
    _number = 0;
    _moneyController.clear();
  }

  void _whichStoreSelectedToAdd() {
    switch(_selectedStore) {
      case 'Наличные':
        _addCash();
        break;
      case 'Карта':
        _addCard();
        break;
    }
  }

  void _whichStoreSelectedToDelete() {
    switch(_selectedStore) {
      case 'Наличные':
        _minusCash();
        break;
      case 'Карта':
        _minusCard();
        break;
    }
  }

  void press(var value) {
    _number = value;
  }

  final _errorSnackBar = SnackBar(
    content: Row(
      children: const <Widget>[
        Icon(Icons.error, color: Colors.redAccent),
        Padding(padding: EdgeInsets.only(left: 10)),
        Text('У вас недостаточно средств!'),
      ],
    ),
    duration: const Duration(seconds: 2),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    behavior: SnackBarBehavior.floating,
  );

  Widget circularBar() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E1F1),
      body: _isLoading? circularBar(): Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 10, color: Color(0xA0028326), offset: Offset(0,4)
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFDBD5A4),
                          Color(0xFF649173),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset("assets/images/banknote/dollar.png"),
                            ]
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const Text('Баланс', style: TextStyle(fontSize: 20, fontFamily: 'Raleway')),
                                  Text(
                                      '${_cash.toString()} ${getCurrency()}',
                                      style: const TextStyle(
                                          fontSize: 28,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset("assets/images/banknote/dollar.png"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 435,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 10, color: Color(0xA0FF0000), offset: Offset(0,4)
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFAFBD),
                        Color(0xFFFFC3A0),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/card/chip.png",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Баланс',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: 'Raleway'
                                  ),
                                ),
                                Text(
                                  '${_card.toString()} ${getCurrency()}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 28,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Image.asset("assets/images/card/card_operator.png"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const <Widget>[
                            Text(
                              'Instant card',
                              style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Raleway'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            setState(() {
                              showAddAlertDialog(context);
                            });
                          },
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0)
                            ),
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          label: const Align(
                              alignment: Alignment.center,
                              child:
                              Text(
                                  '+',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                      fontSize: 60,
                                      fontFamily: 'Raleway'
                                  ),
                              ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            setState((){
                              showDeleteAlertDialog(context);
                            });
                          },
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0)
                            ),
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          label: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                  '-',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 60,
                                      fontFamily: 'Raleway'),
                              ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showAddAlertDialog(BuildContext context) async {
    Widget addButton = TextButton(
      child: const Text(
        "Добавить",
        style: TextStyle(
            fontSize: 20,
            color: Colors.deepPurpleAccent
        ),
      ),
      onPressed: () async {
        _whichStoreSelectedToAdd();
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Доходы",
        style: TextStyle(
            fontWeight: FontWeight.bold
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      content: SizedBox(
        height: 200,
        width: 100,
        child: Column(
          children: <Widget>[
            const Text(
              'Введите сумму для добавления',
            ),
            TextFormField(
              textAlign: TextAlign.center,
              controller: _moneyController,
              cursorColor: Colors.deepPurpleAccent,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  press(double.parse(value));
                });
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 12)),
            DropdownButton<String>(
              value: _selectedStore,
              icon: const Icon(Icons.arrow_drop_down_rounded),
              elevation: 16,
              style: const TextStyle(fontSize: 20, color: Colors.black),
              underline: Container(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStore = newValue!;
                });
              },
              items: _moneyStores
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: _incomeController,
              cursorColor: Colors.deepPurpleAccent,
              keyboardType: TextInputType.text,
              onSubmitted: (value) {
                setState(() {
                  operations.add(
                    Operation(
                      id: operations.length,
                      text: value,
                      value: _number,
                      icon: const Icon(
                          Icons.arrow_upward,
                          color: Colors.lightGreen
                      ),
                    ),
                  );
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        addButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> showDeleteAlertDialog(BuildContext context) async {
    Widget minusButton = TextButton(
      child: const Text(
        "Отнять",
        style:
        TextStyle(
            fontSize: 20,
            color: Colors.deepPurpleAccent
        ),
      ),
      onPressed: () async {
        _whichStoreSelectedToDelete();
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Затраты",
        style: TextStyle(
            fontWeight: FontWeight.bold
        ),
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      content: SizedBox(
        height: 200,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Введите потраченную сумму',
            ),
            TextFormField(
              textAlign: TextAlign.center,
              controller: _moneyController,
              cursorColor: Colors.deepPurpleAccent,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  press(double.parse(value));
                });
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 12)),
            DropdownButton<String>(
              value: _selectedStore,
              icon: const Icon(Icons.arrow_drop_down_rounded),
              elevation: 16,
              style: const TextStyle(fontSize: 20, color: Colors.black),
              underline: Container(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStore = newValue!;
                });
              },
              items: _moneyStores
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: _expenseController,
              cursorColor: Colors.deepPurpleAccent,
              keyboardType: TextInputType.text,
              onSubmitted: (value) {
                setState(() {
                  operations.add(
                    Operation(
                      id: operations.length,
                      text: value,
                      value: _number,
                      icon: const Icon(
                          Icons.arrow_downward,
                          color: Colors.redAccent
                      ),
                    ),
                  );
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        minusButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}