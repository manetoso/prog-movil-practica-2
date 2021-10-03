import 'package:flutter/material.dart';
import 'package:practica_2/src/utils/colors_settings.dart';

class PropinasScreen extends StatefulWidget {
  PropinasScreen({Key? key}) : super(key: key);

  @override
  _PropinasScreenState createState() => _PropinasScreenState();
}

class _PropinasScreenState extends State<PropinasScreen> {
  TextEditingController numberCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextFormField txtNumber = TextFormField(
      controller: numberCon,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: 'Introduce el total a pagar',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
    );

    return Scaffold(
        backgroundColor: ColorSettings.colorPrimary,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: const Icon(Icons.calculate),
          foregroundColor: Colors.black54,
          elevation: 25,
          splashColor: Colors.black12,
          onPressed: () {
            if (numberCon.text.length < 2) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                        'Favor de insertar un número de dos dígitos o mayor!',
                        style: const TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      backgroundColor: Colors.redAccent,
                    );
                  });
            }
            numberCon.text.trim();
            if (numberCon.text.length < 2) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                        'Favor de insertar un número de dos dígitos o mayor!',
                        style: const TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      backgroundColor: Colors.redAccent,
                    );
                  });
            }
            var price = int.parse(numberCon.text);
            if (price < 0) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                        'Favor de no insertar número negativos!',
                        style: const TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      backgroundColor: Colors.redAccent,
                    );
                  });
            } else {
              var tip = price * 0.2;
              tip.round();
              var total = price + tip;
              total.toString();
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                        'El monto total a pagar, incluida la propina de: \$${tip.toStringAsFixed(2)} MX, es de: \n\$$total MX',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      backgroundColor: Colors.yellowAccent,
                    );
                  });
            }
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(35.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'La siguiente ventana es una calculadora del 20% de propina de un número total.',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Favor de insertar el costo de la compra y la aplicación responderá con un mensaje que indiqué el total a pagar con la propina incluida.',
                style: const TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              txtNumber
            ],
          ),
        ));
  }
}
