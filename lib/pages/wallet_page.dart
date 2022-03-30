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
  late double _cash = 0;
  late double _card = 0;
  late double _other = 0;
  late double _food = 0;
  late double _clothes = 0;
  late double _supplies = 0;
  late TooltipBehavior _toolTipBehavior;
  late List<ExpenseData> _chartData;

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
    await docRef.get().then((snapshot){
      setState(() {
        _cash = snapshot['cash'];
        _card = snapshot['card'];
        _other = snapshot['other'];
        _food = snapshot['food'];
        _clothes = snapshot['clothes'];
        _supplies = snapshot['supplies'];
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
    super.initState();
    _chartData = getExpenseData();
    _getInfo();
    _updateMoney();
    _toolTipBehavior = TooltipBehavior(enable: true);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.attach_money,
              ),
              SizedBox(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Наличные: ${_cash.toString()}',
                    style: const TextStyle(color: Colors.black,fontSize: 20),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.credit_card,
              ),
              SizedBox(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Карта: ${_card.toString()}',
                    style: const TextStyle(color: Colors.black,fontSize: 20),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
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
              controller: _controller,
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
          SfCircularChart(
            title: ChartTitle(text: 'Расходы'),
            tooltipBehavior: _toolTipBehavior,
            legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
            series: <CircularSeries>[
              PieSeries<ExpenseData, String>(
                dataSource: _chartData,
                xValueMapper: (ExpenseData data,_) => data.name,
                yValueMapper: (ExpenseData data,_) => data.expense,
              ),
            ],
          ),
        ],
      )
    );
  }
}

class ExpenseData {
  ExpenseData(this.name, this.expense);
  final String name;
  late double? expense;
}