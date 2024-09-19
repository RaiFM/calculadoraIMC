import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _peso = TextEditingController();
  final TextEditingController _alt = TextEditingController();
  final TextEditingController _imc = TextEditingController();
  late int _count;
  late String _result = "";
  final Map<String, String> _imageDict = {
    'MIII': 'img1.png',
    'MII': 'img2.png',
    'MI': 'img3.png',
    'E': 'img4.png',
    'PO': 'img5.png',
    'OI': 'img6.png',
    'OII': 'img7.png',
    'OIIII': 'img8.png',
  };

  double getValue(String text){
    try{    
      return double.parse(text);
    }catch(e){
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final List<TextEditingController> _controllers = [_peso, _alt, _imc];

    _count = 0;
    String assetPath = _imageDict['MIII']!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: 
      Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(assetPath),
              SizedBox(height: 10),
              _buildTextField('Peso', 'Digite o Peso', _controllers[0]),
              SizedBox(height: 10),
              _buildTextField('Altura', 'Digite a altura', _alt),
              SizedBox(height: 10),
              Text(
                _result,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(onPressed: () {
                    _controllers[_count].text += '7';
                  }, child: Text('7')),
                  TextButton(onPressed: () {
                    _controllers[_count].text += '8';
                  }, child: Text('8')),
                  TextButton(onPressed: () {
                    _controllers[_count].text += '9';
                  }, child: Text('9')),
                  TextButton(onPressed: () {
                    if(getValue(_controllers[_count].text) != 0){
                      double? peso = getValue(_controllers[0].text);
                      double? altura = getValue(_controllers[1].text);

                      if(_count == 1) {
                        if(peso == 0 || altura == 0){
                          setState(() {
                            _result = 'Coloque valores válidos';
                          });
                        }else{
                          double resultado = peso / (altura * altura);

                          
                          if(resultado >= 40){
                            assetPath = _imageDict['OIII']!;
                          }else if(resultado >= 35){
                            assetPath = _imageDict['OII']!;
                          }else if(resultado >= 30){
                            assetPath = _imageDict['OI']!;
                          }else if(resultado >= 25){
                            assetPath = _imageDict['PO']!;
                          }else if(resultado >= 18.5){
                            assetPath = _imageDict['E']!;
                          }else if(resultado >= 17){
                            assetPath = _imageDict['MI']!;
                          }else if(resultado >= 16){
                            assetPath = _imageDict['MII']!;
                          }else{
                            assetPath = _imageDict['MIII']!;
                          }

                          setState(() {
                            _result = 'O seu IMC é ${resultado.toStringAsFixed(2)}';
                          });

                          _count == 0;
                        }
                      } else {
                        _count++;
                      }
                    }else{
                      setState(() {
                        _result = 'Coloque valores válidos';
                      });
                    }
                  }, child: Text('Enter')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(onPressed: () {
                    _controllers[_count].text += '4';
                  }, child: Text('4')),
                  TextButton(onPressed: () {
                    _controllers[_count].text += '5';
                  }, child: Text('5')),
                  TextButton(onPressed: () {
                    _controllers[_count].text += '6';
                  }, child: Text('6')),
                  TextButton(onPressed: () {
                    _controllers[_count].text += '.';
                  }, child: Text('.')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(onPressed: () {
                    _controllers[_count].text += '1';
                  }, child: Text('1')),
                  TextButton(onPressed: () {
                    _controllers[_count].text += '2';
                  }, child: Text('2')),
                  TextButton(onPressed: () {
                    _controllers[_count].text += '3';
                  }, child: Text('3')),
                  TextButton(onPressed: () {
                    _controllers[_count].text += '0';
                  }, child: Text('0')),
                ],
              ),
            ]
          ),
        )
      ),
      // endDrawer: Drawer(
      //   child: Icon(Icons.code)
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void dispose() {
    // Dispose of the controller when the widget is disposed
    // _controller.dispose();
    super.dispose();
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller){
    return Container(
      width: 300,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(height: 2.0),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint
        ),
      ),
    );
  }
}

