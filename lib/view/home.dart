import 'package:falemais_app_flutter/controller/call_controller.dart';
import 'package:falemais_app_flutter/model/call_model.dart';
import 'package:falemais_app_flutter/model/product_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const List<String> dddsList = <String>["011", "016", "017", "018"];
Product product = Product(
    id: 0,
    name: "FaleMais",
    plan: {"FaleMais 30": 30, "FaleMais 60": 60, "FaleMais 120": 120});

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String originValue = dddsList.first;
  String destinyValue = dddsList.last;

  int planValue = 30;
  TextEditingController controllerTime = TextEditingController();

  String _formatValue(double value) {
    final NumberFormat numberFormat = new NumberFormat("##0.00", "en_US");
    return numberFormat.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Telzir - FaleMais")),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Calcular Valor da Ligação",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 120,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'ORIGEM (DDD)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: originValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String value) {
                            // This is called when the user selects an item.
                            setState(() {
                              originValue = value;
                            });
                          },
                          items: dddsList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 120,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'DESTINO (DDD)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: destinyValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String value) {
                            // This is called when the user selects an item.
                            setState(() {
                              destinyValue = value;
                            });
                          },
                          items: dddsList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 120,
                      child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'TEMPO (minutos)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: TextField(
                            controller: controllerTime,
                            keyboardType: TextInputType.number,
                          )),
                    )),
              ],
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 50.0, right: 50.0),
                    child: Container(
                        width: 292.7,
                        child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'PLANO FALEMAIS',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: DropdownButton<int>(
                              isExpanded: true,
                              iconSize: 20,
                              icon: Icon(Icons.arrow_downward_sharp),
                              items: product.plan
                                  .map((description, value) {
                                    return MapEntry(
                                        description,
                                        DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(description),
                                        ));
                                  })
                                  .values
                                  .toList(),
                              value: planValue,
                              onChanged: (int newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    planValue = newValue;
                                  });
                                }
                              },
                            )))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                  onPressed: () {
                    if (controllerTime.text.isEmpty) {
                      print("digite o tempo");
                    } else {
                      CallController call = CallController();
                      double tariff =
                          call.tariffValue(originValue, destinyValue);

                      var valueCallPlan = call.callPlan(
                          tariff, int.parse(controllerTime.text), planValue);

                      var valueCallNoPlan = call.callNoPlan(
                          tariff, int.parse(controllerTime.text));

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Container(
                              height: 250,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: 'DDD de Origem: ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: "$originValue",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16),
                                            )
                                          ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: 'DDD de Destino: ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: "$destinyValue",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16),
                                            )
                                          ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: 'Duração da Chamada: ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  "${controllerTime.text} minutos",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16),
                                            )
                                          ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: 'Plano Escolhido: ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  "${planValue == 30 ? "FaleMais 30" : planValue == 60 ? "FaleMais 60" : planValue == 120 ? "FaleMais 120" : ""}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16),
                                            )
                                          ]),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 50.0),
                                      child: Center(
                                          child: Text(
                                        "Valor da Ligação",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              text: 'Com Plano FaleMais: ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      "\$ ${_formatValue(valueCallPlan)}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 18),
                                                )
                                              ]),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: RichText(
                                            text: TextSpan(
                                                text: 'Sem o Plano FaleMais: ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        "\$ ${_formatValue(valueCallNoPlan)}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 16),
                                                  )
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            title: Center(
                                child: Text(
                              "Telzir Fale mais App",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                          );
                        },
                      );
                    }
                  },
                  child: Text("Calcular")),
            )
          ],
        ),
      ),
    );
  }
}
