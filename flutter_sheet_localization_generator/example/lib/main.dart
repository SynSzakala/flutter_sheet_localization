import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _currentLocale;

  @override
  void initState() {
    _currentLocale = AppLocalizations.languages.keys.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      locale: _currentLocale,
      localizationsDelegates: [
        const AppLocalizationsDelegate(), // <- Your custom delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales:
          AppLocalizations.languages.keys.toList(), // <- Supported locales
      home: MyHomePage(
        title: 'Internationalization demo',
        locale: _currentLocale,
        onLocaleChanged: (locale) {
          if (_currentLocale != locale) {
            setState(() => _currentLocale = locale);
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage(
      {Key key,
      this.title,
      @required this.locale,
      @required this.onLocaleChanged})
      : super(key: key);

  final String title;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context); // <- Accessing your labels
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          DropdownButton<Locale>(
            key: Key('Picker'),
            value: locale,
            items: AppLocalizations.languages.keys.map((locale) {
              return DropdownMenuItem<Locale>(
                value: locale,
                child: Text(
                  locale.toString(),
                ),
              );
            }).toList(),
            onChanged: onLocaleChanged,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(labels.dates.month.february),
                Text(labels.multiline),
                Text(labels.templated.hello(firstName: 'World')),
                Text(labels.templated.contact(Gender.male, lastName: 'John')),
                Text(labels.templated.contact(Gender.female, lastName: 'Jane')),
                Text('0 ' + labels.plurals.man(0.plural())),
                Text('1 ' + labels.plurals.man(1.plural())),
                Text('5 ' + labels.plurals.man(5.plural())),
                Text(labels.templated.numbers.simple(price: 10)),
                Text(labels.templated.numbers.formatted(price: 10)),
                Text(labels.templated.date.simple(date: DateTime.now())),
                Text(labels.templated.date.pattern(date: DateTime.now())),

                /*
                Text(labels.templated.datetime(DateFormatter.yMd,
                    now: DateTime.now().add(Duration(days: 2)))),
                Text(labels.amount(NumberFormatter.currency, amount: 1000000)),
                Text(labels.amount(NumberFormatter.compactCurrency,
                    amount: 1000000)),
                Text(labels.amount(NumberFormatter.decimalPattern,
                    amount: 1000000.101)),
                Text(labels.amount(null, amount: 1000000)),
                */
              ],
              // Displaying templated label
            ),
          ),
        ],
      ),
    );
  }
}
