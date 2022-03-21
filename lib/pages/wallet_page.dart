import 'package:flutter/material.dart';

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
    'Wallet',
    'Credit Card'
  ];

  var _selectedStore;

  void _add() {
    _cash += _number;
    print("cash $_cash");
    _controller.clear();
  }

  void _minus(){
    if (_number <= _cash) {
      _cash -= _number;
    } else {
      _cash = 0;
    }
    _controller.clear();
  }

  void press(var value) {
    _number = value;
    // print("number $_number");
  }

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
          /*DropdownButton(
            value: _selectedStore,
            items: _moneyStores.map((String location)),
            onChanged: ,
          ),*/
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
                      _add();
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