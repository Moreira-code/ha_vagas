import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "Há Vagas", home: Home()));
}
///////////////////////////////////////////////////////
////////////////////////MENU//////////////////////////
/////////////////////////////////////////////////////

class menuScreen extends StatefulWidget {
  @override
  _menuScreen createState() => _menuScreen();
}

class _menuScreen extends State<menuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estacionamento'),
      ),
      body: Center(
        child: Text('My Page!'),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Calculadora de Preços'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => calculationScreen()));
              },
            ),
            ListTile(
              title: Text('Mensalistas'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => monthlyScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////
//////////////////TELA MENSALISTAS////////////////////
/////////////////////////////////////////////////////

class monthlyScreen extends StatefulWidget {
  @override
  _monthlyScreen createState() => _monthlyScreen();
}

class _monthlyScreen extends State<monthlyScreen> {
  List<String> items = <String>['Joao', 'Maria'];

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> listTiles =
        items.map((String item) => buildListTile(context, item));

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Listas Page'),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.sort_by_alpha),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: Scrollbar(
        child: ListView(
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          children: listTiles.toList(),
        ),
      ),
    );
  }
}

Widget buildListTile(BuildContext context, String item) {
  Widget secondary = const Text('Texto Secondario');

  return new MergeSemantics(
      child: ListTile(
    title: Text('Este item representa a letra $item.'),
    subtitle: secondary,
  ));
}

///////////////////////////////////////////////////////
//////////////////TELA CALCULO HORA///////////////////
/////////////////////////////////////////////////////

class calculationScreen extends StatefulWidget {
  @override
  _calculationScreenState createState() => _calculationScreenState();
}

class _calculationScreenState extends State<calculationScreen> {
  String _modeloCarro;
  TextEditingController modeloController = TextEditingController();

  TextEditingController horasController = TextEditingController();

  TextEditingController tipoController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Dados";

  int t;

  void _resetFields() {
    modeloController.text = "";
    horasController.text = "";
    tipoController.text = "";
    setState(() {
      _infoText = "Informe os dados!";
      _formKey = GlobalKey<FormState>(); //SUMIR MSG DE ERRO DEPOIS DO RESET
    });
  }

  void _calculate() {
    setState(() {
      String modeloAutomovel = modeloController.text;
      double horas = double.parse(horasController.text);
      int tipo = int.parse(tipoController.text);
      double preco = 0;
      int desconto = 0;

      if (horas < 1) {
        if (tipo == 1) {
          preco = 3.0;
        } else if (tipo == 2) {
          preco = 5.0;
        } else if (tipo == 3) {
          preco = 8.0;
        }
      } else if (horas >= 1) {
        switch (tipo) {
          case 1:
            {
              preco = 3.0 + (horas * 3);
            }
            break;
          case 2:
            {
              preco = 5.0 + (horas * 3);
            }
            break;

          case 3:
            {
              preco = 8.0 + (horas * 3);
            }

            break;

          default:
            {
              preco = 0;
            }

            break;
        }
      }

      // Desconto

      print(preco);

      _infoText = "$modeloAutomovel, ${preco.toStringAsPrecision(3)} Reais!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cálculo do Preço"),
          backgroundColor: Colors.blue,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.directions_car, size: 120, color: Colors.red),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Modelo",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                    controller: modeloController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira o modelo!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Horas Ocupadas",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                    controller: horasController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira as horas gastas!";
                      }
                    },
                  ),
                  ListTile(
                    title: const Text('Moto'),
                    leading: Radio(
                        activeColor: Colors.blue,
                        value: 1,
                        groupValue: tipoController.text.toString(),
                        onChanged: (t) {
                          setState(() {
                            tipoController.text = t.toString();
                          });
                        }),
                  ),
                  ListTile(
                    title: const Text('Carro'),
                    leading: Radio(
                        activeColor: Colors.blue,
                        value: 2,
                        groupValue: tipoController.text,
                        onChanged: (t) {
                          setState(() {
                            tipoController.text = t.toString();
                          });
                        }),
                  ),
                  ListTile(
                    title: const Text('Camionete'),
                    leading: Radio(
                        activeColor: Colors.blue,
                        value: 3,
                        groupValue: tipoController.text,
                        onChanged: (t) {
                          setState(() {
                            tipoController.text = t.toString();
                          });
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            //validando o calculo
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                  ),
                ],
              ),
            )));
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/vagas.jpg",
          fit: BoxFit.fill,
          height: 1000.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text(
                      "Há Vagas",
                      style: TextStyle(fontSize: 50.0, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => menuScreen()));
                    },
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
