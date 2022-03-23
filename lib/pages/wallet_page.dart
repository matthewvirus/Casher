import 'package:flutter/material.dart';
import './signup_page.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double _cash = 0;
  double _card = 0;
  double _number = 0;
  final _controller = TextEditingController();

  final List<String> _moneyStores = [
    'Наличные',
    'Карта'
  ];

  var _selectedStore = 'Наличные';

  void _addCash() {
    _cash += _number;
    //print("cash $_cash");
    _controller.clear();
    _number = 0;
  }

  void _addCard() {
    _card += _number;
    //print("card $_card");
    _controller.clear();
    _number = 0;
  }


  void _whichStoreSelected() {
    switch(_selectedStore) {
      case 'Наличные':
        _addCash();
        break;
      case 'Карта':
        _addCard();
        break;
    }
  }

  void _minus(){
    if (_number <= _cash) {
      _cash -= _number;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_errorSnackBar);
    }
    _number = 0;
    _controller.clear();
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
                    'Наличные: $_cash',
                    style: const TextStyle(fontSize: 20),
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
                    'Карта: $_card',
                    style: const TextStyle(fontSize: 20),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
          DropdownButton<String>(
            value: _selectedStore,
            icon: const Icon(Icons.keyboard_arrow_down),
            elevation: 16,
            style: const TextStyle(fontSize: 20),
            underline: Container(
              height: 2,
              color: Colors.redAccent,
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
                      _whichStoreSelected(); // Test
                    });
                  },
                  child: const Text(
                    'Добавить',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: Colors.redAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      _minus();
                    });
                  },
                  child: const Text(
                    'Отнять',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}