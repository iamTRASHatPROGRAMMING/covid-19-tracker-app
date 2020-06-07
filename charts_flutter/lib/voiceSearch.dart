import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

class MicButton extends StatefulWidget {
  Function(String val) voiceSearchResult;
  MicButton({this.voiceSearchResult});
  @override
  _MicButtonState createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton> {
//final  is runtime final value of the object
//const is the compile time final value of a object
// suppose an object is pointing to a list and we declare it constant  that means its value wont change
// no matter what since its value was set during compile time
// in final the value will change since its run time and by that i mean we have a seperate custom widget
// which returns an icon of mic if we declare a string variable as constant and call the custom widget and provide
// the value of string in it then it will show the value we call but if we use setstate to u[date the previou value then
// build will again be called and the updated value will be sent hence we will be rebuilding or redrawing the app
// on the screen so the new value will be shown
// final is to be used when an object has gotten its value and const when an object knows what its value is and wants to keep it unchanged at all times

  SpeechRecognition _speechRecognition;
  bool isAvailable =false;
  bool isListening=false;
  String resultText = '';


  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler(
        (bool res)=> setState(() => isAvailable = res)
    );
    _speechRecognition.setRecognitionStartedHandler(() {
      setState(() {
        isListening = true;
      });
    });
    _speechRecognition.setRecognitionResultHandler((String speech)=>setState(()=>resultText = speech));
    _speechRecognition.setRecognitionCompleteHandler(()=> setState(()=> isListening = false));
    _speechRecognition.activate().then((result) => setState(()=> isAvailable = result));
  }


  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(Icons.mic), onPressed: () {
      if(isAvailable && !isListening) {
        _speechRecognition.listen(locale: 'en_US').then((res) {
          print(res);

        });

        Future.delayed(Duration(seconds: 5),()  {
          if(isListening) {
            _speechRecognition.stop().then((res)=> setState(()=> isListening=res));
          }
          widget.voiceSearchResult(resultText);
        });
      }
    });
  }
}


