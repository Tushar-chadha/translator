import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theTranslator/ui/translatePageUi.dart';
import 'package:translator/translator.dart';

// ignore: must_be_immutable
class TranslatePage extends StatelessWidget {
  String returnTranslation;

  Future translationProcess(
      String text1, String language, String language1) async {
    final translator = GoogleTranslator();
    final input = text1;
    var translation = language1 != null
        ? await translator.translate(input, from: language1, to: language)
        : await translator.translate(input, to: language);
    print(
        '${translation.source} (${translation.sourceLanguage}) == ${translation.text} (${translation.targetLanguage})');
    returnTranslation = translation.toString();
    return returnTranslation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(child: Text('Translate')),
      ),
      body: TranslatePageUi(),
    );
  }
}
