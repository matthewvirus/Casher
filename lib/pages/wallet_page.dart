import 'package:casher/pages/signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late double _cash;
  late double _card;
  late double _other = 0;
  late double _food = 0;
  late double _clothes = 0;
  late double _supplies = 0;
  late TooltipBehavior _toolTipBehavior;
  late List<ExpenseData> _chartData;

  bool _isLoading = false;

  double _number = 0;

  final _controller = TextEditingController();

  DocumentReference docRef = FirebaseFirestore.instance.collection('users').doc(firebaseUser?.uid.toString());

  Future<void> _updateMoney() async {
    await docRef.update (
      {
        "cash": _cash,
        "card": _card,
        "other": _other,
        "food": _food,
        "clothes": _clothes,
        "supplies": _supplies
      }
    );
  }
  Future<void> _getInfo() async {
    setState(() {
      _isLoading = true;
    });
    await docRef.get().then((snapshot){
      setState(() {
        _cash = snapshot['cash'];
        _card = snapshot['card'];
        _other = snapshot['other'];
        _food = snapshot['food'];
        _clothes = snapshot['clothes'];
        _supplies = snapshot['supplies'];
        _isLoading = false;
      });
    });
  }

  List<ExpenseData> getExpenseData() {
    final List<ExpenseData> chartData = [
      ExpenseData('Продукты', _food),
      ExpenseData('Одежда', _clothes),
      ExpenseData('Коммунальные расходы', _supplies),
      ExpenseData('Прочие расходы', _other)
    ];
    return chartData;
  }

  @override
  void initState() {
    _getInfo();
    _updateMoney();
    _chartData = getExpenseData();
    _toolTipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  final List<String> _moneyStores = [
    'Наличные',
    'Карта'
  ];
  var _selectedStore = 'Наличные';

  final List<String> _categories = [
    'Продукты',
    'Одежда',
    'Коммунальные расходы',
    'Прочие расходы'
  ];
  var _selectedCategory = 'Продукты';

  void _addCash() async{
    _cash += _number;
    _controller.clear();
    _number = 0;
    await _updateMoney();
  }

  void _addCard() async{
    _card += _number;
    _controller.clear();
    _number = 0;
    setState(() {

    });
    await _updateMoney();
  }

  void _minusCash() async{
    if (_number <= _cash) {
      _cash -= _number;
      _whichCategorySelected();
      _controller.clear();
      await _updateMoney();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_errorSnackBar);
    }
    _number = 0;
    _controller.clear();
  }

  void _minusCard() async{
    if (_number <= _card) {
      _card -= _number;
      _whichCategorySelected();
      _controller.clear();
      await _updateMoney();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_errorSnackBar);
    }
    _number = 0;
    _controller.clear();
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

  double _setOtherExpense() {
    _other += _number;
    setState(() {
      _chartData = <ExpenseData>[];
      _chartData = getExpenseData();
    });
    return _other;
  }

  double _setFoodExpense() {
    _food += _number;
    setState(() {
      _chartData = <ExpenseData>[];
      _chartData = getExpenseData();
    });
    return _food;
  }

  double _setClothesExpense() {
    _clothes += _number;
    setState(() {
      _chartData = <ExpenseData>[];
      _chartData = getExpenseData();
    });
    return _clothes;
  }

  double _setSuppliesExpense() {
    _supplies += _number;
    setState(() {
      _chartData = <ExpenseData>[];
      _chartData = getExpenseData();
    });
    return _supplies;
  }

  void _whichCategorySelected() async {
    switch(_selectedCategory) {
      case 'Прочие расходы':
        _setOtherExpense();
        await _updateMoney();
        break;
      case 'Продукты':
        _setFoodExpense();
        await _updateMoney();
        break;
      case 'Одежда':
        _setClothesExpense();
        await _updateMoney();
        break;
      case 'Коммунальные расходы':
        _setSuppliesExpense();
        await _updateMoney();
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
                  margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 10, color: Color(0xA0028326), offset: Offset(0,4)
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
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
                                Text('${_cash.toString()} BYN', style: const TextStyle(fontSize: 28, fontFamily: 'Raleway', fontWeight: FontWeight.bold))
                              ],
                            )
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 10, color: Color(0xA0FF0000), offset: Offset(0,4)
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
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
                                  style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Raleway'),
                                ),
                                Text(
                                  '${_card.toString()} BYN',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontFamily: 'Raleway', fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
                                )
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
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton<String>(
                value: _selectedStore,
                icon: const Icon(Icons.keyboard_arrow_down),
                elevation: 16,
                style: const TextStyle(fontSize: 20, color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
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
              const Padding(padding: EdgeInsets.only(left: 10)),
              DropdownButton<String>(
                value: _selectedCategory,
                icon: const Icon(Icons.keyboard_arrow_down),
                elevation: 16,
                style: const TextStyle(fontSize: 20, color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: _categories
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: _controller,
              cursorColor: Colors.deepPurpleAccent,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  press(double.parse(value));
                });
              },
            ),
            width: 100,
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      _whichStoreSelectedToAdd();
                    });
                  },
                  child: const Text(
                    'Добавить',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: Colors.deepPurpleAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      _whichStoreSelectedToDelete();
                    });
                  },
                  child: const Text(
                    'Отнять',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ExpenseData {
  ExpenseData(this.name, this.expense);
  final String name;
  late double? expense;
}