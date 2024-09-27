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

  final FocusNode _focusNodePeso = FocusNode();
  final FocusNode _focusNodeAltura = FocusNode();

  String assetPath = "";
  late int _count;
  late String _result = "";
  late String _status = "";
  final Map<String, String> _imageDict = {
    'MIII': 'img1.png',
    'MII': 'img2.png',
    'MI': 'img3.jpg',
    'E': 'img4.jpg',
    'PO': 'img5.jpg',
    'OI': 'img6.jpg',
    'OII': 'img7.jpg',
    'OIII': 'img8.jpg',
  };

  double getValue(String text){
    try{    
      return double.parse(text);
    }catch(e){
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    assetPath = _imageDict['MIII']!;

    _focusNodePeso.addListener(() {
      if (_focusNodePeso.hasFocus) {
        // Action when weight TextField gains focus
        _count = 0;
      }
    });

    _focusNodeAltura.addListener(() {
      if (_focusNodeAltura.hasFocus) {
        // Action when height TextField gains focus
        _count = 1;
      }
    });
  }

  void _apagar() {
    if (_count == 0) {
      _peso.text = _peso.text.isNotEmpty
          ? _peso.text.substring(0, _peso.text.length - 1)
          : '';
    } else {
      _alt.text = _alt.text.isNotEmpty
          ? _alt.text.substring(0, _alt.text.length - 1)
          : '';
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final List<TextEditingController> _controllers = [_peso, _alt];

    _count = 0;

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
              Image.asset(assetPath, width: 300, height: 400),
              SizedBox(height: 10),
              _buildTextField('Peso', 'Digite o Peso', _controllers[0], _focusNodePeso),
              SizedBox(height: 10),
              _buildTextField('Altura', 'Digite a altura (cm)', _controllers[1], _focusNodeAltura),
              SizedBox(height: 10),
              Text(
                _result,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Text(
                _status,
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
                    _apagar();
                  }, child: Text('⌫')),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(onPressed: () {
                    if(getValue(_controllers[_count].text) != 0){
                      double? peso = getValue(_controllers[0].text);
                      double? altura = getValue(_controllers[1].text);

                      if(peso < 0 || altura < 0){
                        setState(() {
                          _result = 'Coloque valores válidos';
                        });
                      }else{
                        altura /= 100;
                        double resultado = peso / (altura * altura);
                        String status = "";

                        setState(() {
                          if(resultado >= 40){
                            assetPath = _imageDict['OIII']!;
                            _status = "Você está obeso";
                          }else if(resultado >= 35){
                            assetPath = _imageDict['OII']!;
                            _status = "Você está obeso";
                          }else if(resultado >= 30){
                            assetPath = _imageDict['OI']!;
                            _status = "Você está obeso";
                          }else if(resultado >= 25){
                            assetPath = _imageDict['PO']!;
                            _status = "Você está pré-obeso";
                          }else if(resultado >= 18.5){
                            assetPath = _imageDict['E']!;
                            _status = "Você está no peso ideal";
                          }else if(resultado >= 17){
                            assetPath = _imageDict['MI']!;
                            _status = "Você está magro";
                          }else if(resultado >= 16){
                            assetPath = _imageDict['MII']!;
                            _status = "Você está magro";
                          }else{
                            assetPath = _imageDict['MIII']!;
                            _status = "Você está muito magro";
                          }

                          _result = 'O seu IMC é ${resultado.toStringAsFixed(2)}';
                        });

                        _count == 0;
                      }
                    }else{
                      setState(() {
                        _result = 'Coloque valores válidos';
                      });
                    }
                  }, child: Text('Calcular')),
                ],
              ),
            ]
          ),
        )
      ),
    );
  }

  void dispose() {
    super.dispose();
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, FocusNode focusNode){
    return Container(
      width: 300,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
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

