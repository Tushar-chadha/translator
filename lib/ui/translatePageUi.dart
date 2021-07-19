import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:theTranslator/lists/words.dart';
import 'package:theTranslator/logic/translatePage.dart';

class TranslatePageUi extends StatefulWidget {
  final String translatedWord;

  TranslatePageUi({this.translatedWord});

  @override
  _TranslatePageUiState createState() => _TranslatePageUiState();
}

class _TranslatePageUiState extends State<TranslatePageUi> {
  final _form = GlobalKey<FormState>();
  var convertedTranslation = TextEditingController();
  TranslatePage translatePage = TranslatePage();
  String finalTranslated, languageValue, languageValue1;
  LanguageList languageList = LanguageList();
  var _text1 = '',
      _inItValues = {
        'text1': '', // initial values
      };

  void _translate() {
    final isValid = _form.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _form.currentState.save();
      print(_text1);
    }
  }

  Widget androidDropDown1() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: DropdownButton<String>(
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        underline: Container(
          height: 1,
          color: Theme.of(context).primaryColor,
        ),
        hint: Text(
          'TRANSLATED From',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        items: languageList.languages
            .map((abv, language) {
              return MapEntry(
                  abv,
                  DropdownMenuItem<String>(
                    value: abv,
                    child: Text(language),
                  ));
            })
            .values
            .toList(),
        value: languageValue1,
        onChanged: (value) {
          setState(() {
            languageValue1 = value;
          });
        },
      ),
    );
  }

  Widget androidDropDown() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: DropdownButton<String>(
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        underline: Container(height: 1, color: Theme.of(context).primaryColor),
        hint: Text(
          'TRANSLATED TO',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        items: languageList.languages
            .map((abv, language) {
              return MapEntry(
                  abv,
                  DropdownMenuItem<String>(
                    value: abv,
                    child: Text(language),
                  ));
            })
            .values
            .toList(),
        value: languageValue,
        onChanged: (value) {
          setState(() {
            languageValue = value;
          });
        },
      ),
    );
  }

  updateUi() async {
    String yes = await translatePage.translationProcess(
        _text1, languageValue, languageValue1);
    finalTranslated = yes;
    print(yes);
    setState(() {
      convertedTranslation.text = finalTranslated;
    });
  } //this is used to show translated text in textField

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(),
              TextFormField(
                  initialValue: _inItValues['text1'],
                  textInputAction: TextInputAction.done,
                  minLines: 1,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 45),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Text',
                      hintStyle: TextStyle(
                        fontSize: 45,
                      )),
                  validator: (value) {
                    if (value.isEmpty || value == null) {
                      return 'please enter Text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _text1 = value;
                  }),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: androidDropDown1()),
                  SizedBox(
                    width: 20,
                  ),
                  Center(child: androidDropDown()),
                ],
              ),
              Spacer(),
              TextField(
                controller: convertedTranslation,
                readOnly: true,
                minLines: 1,
                maxLines: 4,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 45),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Translated Text',
                    hintStyle: TextStyle(
                      fontSize: 45,
                    )),
              ),
              Spacer(),
              FloatingActionButton(
                child: Icon(Icons.translate),
                onPressed: () {
                  _translate();
                  setState(() {
                    updateUi();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
