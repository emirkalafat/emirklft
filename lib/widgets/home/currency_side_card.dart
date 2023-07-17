import 'dart:convert';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencySideCard extends StatefulWidget {
  const CurrencySideCard({super.key});

  @override
  State<CurrencySideCard> createState() => _CurrencySideCardState();
}

class _CurrencySideCardState extends State<CurrencySideCard> {
  final TextEditingController _controller = TextEditingController();
  String _fromCurrency = '';
  String _toCurrency = '';
  List<String> _currencies = [];
  String _result = '';

  @override
  void initState() {
    super.initState();
    _controller.value = const TextEditingValue(text: '1');
    getAmounts();
    _convertCurrency();
  }

  Future<void> getAmounts() async {
    final response = await http
        .get(Uri.parse('https://openexchangerates.org/api/currencies.json'));
    final Map data = jsonDecode(response.body);
    setState(() {
      _currencies = data.keys.toList() as List<String>;
      _fromCurrency = _currencies[_currencies.indexOf('EUR')];
      _toCurrency = _currencies[_currencies.indexOf('TRY')];
    });
  }

  Future<void> _convertCurrency() async {
    final response = await http.get(
        Uri.parse('https://api.exchangerate-api.com/v4/latest/$_fromCurrency'));
    final data = jsonDecode(response.body);

    final rate = data['rates'][_toCurrency];
    final amount = double.parse(_controller.text);
    final result = amount * rate;

    setState(() {
      _result = '${result.toStringAsFixed(2)} $_toCurrency';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Döviz Çevirici',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 20),
              ),
            ),
            SizedBox(
              //width: 118,
              child: TextField(
                textAlign: TextAlign.center,
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  labelText: 'Miktar',
                  alignLabelWithHint: true,
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      showCurrencyPicker(
                        context: context,
                        onSelect: (Currency currency) {
                          setState(() {
                            _fromCurrency = currency.code;
                          });
                        },
                      );
                    },
                    child: Text(_fromCurrency)),
                TextButton(
                    onPressed: () {
                      showCurrencyPicker(
                        context: context,
                        onSelect: (Currency currency) {
                          setState(() {
                            _toCurrency = currency.code;
                          });
                        },
                      );
                    },
                    child: Text(_toCurrency)),
              ],
            ),
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                  value: _fromCurrency,
                  onChanged: (value) {
                    setState(() {
                      _fromCurrency = value.toString();
                    });
                  },
                  items: _currencies.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: _toCurrency,
                  items: _currencies.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _toCurrency = value!;
                    });
                  },
                ),
              ],
            ),
            */
            const SizedBox(height: 8),
            (_result != '')
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      _result,
                      style: const TextStyle(fontSize: 20),
                    ),
                  )
                : const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Sonuç",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Çevir'),
            ),
          ],
        ),
      ),
    );
  }
}
