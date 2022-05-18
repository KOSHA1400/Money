// ignore_for_file: use_build_context_synchronously
import 'dart:ui';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:moeayexchange/models/convert_currency_model.dart';
import 'package:moeayexchange/models/symbols_model.dart';
import 'package:moeayexchange/network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Currency',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> symbolsList = [""];

  TextEditingController firstPriceController = TextEditingController(text: "0");
  String firstSymbol = "";
  String secondSymbol = "";
  double resultPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () async {
                    SymbolsModel symbolsObject = await BaseNetwork.getSymbols();
                    symbolsList = symbolsObject.symbols;
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Got Symbols !'),
                      ),
                    );
                  },
                  child: const Text('Get Symbols'),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 200.0,
                height: 50.0,
                child: CustomSearchableDropDown(
                  items: symbolsList,
                  label: 'Select Currency',
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.blue)),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(Icons.search),
                  ),
                  dropDownMenuItems: symbolsList,
                  onChanged: (value) {
                    firstSymbol = value;
                  },
                ),
              ),
              SizedBox(
                width: 200.0,
                height: 50.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: firstPriceController,
                  decoration: const InputDecoration(
                    hintText: 'First Price',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 200.0,
                height: 50.0,
                child: CustomSearchableDropDown(
                  items: symbolsList,
                  label: 'Select Currency',
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.blue)),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(Icons.search),
                  ),
                  dropDownMenuItems: symbolsList,
                  onChanged: (value) {
                    secondSymbol = value;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 200.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () async {
                    ConvertCurrencyModel convertCurrencyObject =
                        await BaseNetwork.convertCurrency(
                      from: firstSymbol,
                      to: secondSymbol,
                      amount: firstPriceController.text,
                    );

                    resultPrice = convertCurrencyObject.result;

                    setState(() {});

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Converted'),
                      ),
                    );
                  },
                  child: const Text('Convert'),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "${resultPrice.toStringAsFixed(2)} $secondSymbol",
                style: const TextStyle(
                 
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 20.0),
             
            ],
          ),
        ),
      ),
    );
  }
}
