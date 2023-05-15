// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// import 'dart:async';
// import 'package:dialogflow_flutter/dialogflowFlutter.dart';
// import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:sound_stream/sound_stream.dart';
// import 'package:dialogflow_grpc/dialogflow_grpc.dart';
// import 'package:dialogflow_grpc/generated/google/cloud/dialogflow/v2beta1/session.pb.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import '../shared/constants.dart';

class Chat extends StatefulWidget {
  Chat({required Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}


class _ChatState extends State<Chat> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();

  // bool _isRecording = false;
  // RecorderStream _recorder = RecorderStream();
  // StreamSubscription? _recorderStatus;
  // StreamSubscription<List<int>>? _audioStreamSubscription;
  // BehaviorSubject<List<int>>? _audioStream;
  // DialogflowGrpcV2Beta1? dialogflow;
  late DialogFlowtter dialogFlowtter;


  @override
  void initState() {
    super.initState();
    initPlugin();

  }

  Future<void> initPlugin() async {
    DialogAuthCredentials credentials = await DialogAuthCredentials.fromFile('lib/assets/credentials.json');
    DialogFlowtter i = DialogFlowtter(credentials: credentials,);
    DialogFlowtter.fromFile(path:'lib/assets/credentials.json').then((instance) => dialogFlowtter = instance);
    // _recorderStatus = _recorder.status.listen((status) {
    //   if (mounted) {
    //     setState(() {
    //       _isRecording = status == SoundStreamStatus.Playing;
    //     });
    //   }
    // });
    // await Future.wait([_recorder.initialize()]);
    // final serviceAccount = ServiceAccount.fromString(
    //     (await rootBundle.loadString('lib/assets/credentials.json')));
    // dialogflow = DialogflowGrpcV2Beta1.viaServiceAccount(serviceAccount);
    // AuthGoogle authGoogle = await AuthGoogle(fileJson: "lib/assets/credentials.json").build();
    // DialogFlow dialogflow = DialogFlow(authGoogle: authGoogle, language: "en");
    // AIResponse aiResponse = await dialogflow.detectIntent(query);
  }

  void dispose() {
    // _recorderStatus?.cancel();
    // _audioStreamSubscription?.cancel();
    dialogFlowtter.dispose();
    super.dispose();
  }

  void handleSubmitted(text) async {
    print(text);
    _textController.clear();

    ChatMessage message = ChatMessage(
      text: text,
      name: "You",
      type: true,
    );

    setState(() {
      _messages.insert(0, message);
    });

    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text:text)),
    );

    ChatMessage botMessage = ChatMessage(
                  text: '${response.message}',
                  name: "Bot",
                  type: false,
                );
                setState(() {
                  _messages.insert(0, botMessage);
                });

    // DetectIntentResponse? data = await dialogflow?.detectIntent(text, 'en-US');
    // String? fulfillmentText = data?.queryResult.fulfillmentText;
    // print(fulfillmentText);
    // AuthGoogle authGoogle = await AuthGoogle(fileJson: "lib/assets/credentials.json").build();
    // DialogFlow dialogflow = DialogFlow(authGoogle: authGoogle, language: "en");
    // AIResponse aiResponse = await dialogflow.detectIntent(text);
    // ChatMessage botMessage = ChatMessage(
    //           text:aiResponse.getListMessage()![0]["text"]["text"][0].toString(),
    //           name: "Bot",
    //           type: false,
    //         );
    //         setState(() {
    //           _messages.insert(0, botMessage);
    //         });
    // if (fulfillmentText != null) {
    //   if (fulfillmentText.isNotEmpty) {
    //     ChatMessage botMessage = ChatMessage(
    //       text: fulfillmentText,
    //       name: "Bot",
    //       type: false,
    //     );
    //     setState(() {
    //       _messages.insert(0, botMessage);
    //     });
    //   }
    // }
  }

  // void handleStream() async {
  //   // _recorder.start();
  //   // _audioStream = BehaviorSubject<List<int>>();
  //   // _audioStreamSubscription = _recorder.audioStream.listen((data) {
  //   //   print(data);
  //   //   _audioStream!.add(data);
  //   // });
  //
  //   var biasList = SpeechContextV2Beta1(phrases: [
  //     'Dialogflow CX',
  //     'Dialogflow Essentials',
  //     'Action Builder',
  //     'HIPAA'
  //   ], boost: 20.0);
  //
  //   var config = InputConfigV2beta1(
  //       encoding: 'AUDIO_ENCODING_LINEAR_16',
  //       languageCode: 'en-US',
  //       sampleRateHertz: 16000,
  //       singleUtterance: false,
  //       speechContexts: [biasList]);
  //
  //   final responseStream =
  //   dialogflow!.streamingDetectIntent(config, _audioStream!);
  //
  //   responseStream.listen((data) {
  //     setState(() {
  //       String transcript = data.recognitionResult.transcript;
  //       String queryText = data.queryResult.queryText;
  //       String fulfillmentText = data.queryResult.fulfillmentText;
  //
  //       if (fulfillmentText.isNotEmpty) {
  //         ChatMessage message =  ChatMessage(
  //           text: queryText,
  //           name: "You",
  //           type: true,
  //         );
  //
  //         ChatMessage botMessage =  ChatMessage(
  //           text: fulfillmentText,
  //           name: "Bot",
  //           type: false,
  //         );
  //
  //         _messages.insert(0, message);
  //         _textController.clear();
  //         _messages.insert(0, botMessage);
  //       }
  //       if (transcript.isNotEmpty) {
  //         _textController.text = transcript;
  //       }
  //     });
  //   }, onError: (e) {}, onDone: () {});
  // }

  // void stopStream() async {
  //   // await _recorder.stop();
  //   await _audioStreamSubscription?.cancel();
  //   await _audioStream?.close();
  // }

  // The chat interface
  //
  //------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Chatbot'),
    elevation: 0,
    ),
      body: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            )),
        const Divider(height: 1.0),
        Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: IconTheme(
              data: IconThemeData(color: Theme.of(context).accentColor),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: _textController,
                        onSubmitted: handleSubmitted,
                        decoration:
                        const InputDecoration.collapsed(hintText: "Send a message"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                        color: primaryColor,
                        icon: const Icon(Icons.send),
                        onPressed: () => handleSubmitted(_textController.text),
                      ),
                    ),
                    // IconButton(
                    //   iconSize: 30.0,
                    //   icon: Icon(_isRecording ? Icons.mic_off : Icons.mic),
                    //   onPressed: _isRecording ? stopStream : handleStream,
                    // ),
                  ],
                ),
              ),
            )),
      ]),
    );
  }
}

//------------------------------------------------------------------------------------
// The chat message balloon
//
//------------------------------------------------------------------------------------
class ChatMessage extends StatelessWidget {
  ChatMessage({required this.text, required this.name, required this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: const CircleAvatar(child: Text('B')),
          ),
          Container(
            margin: const EdgeInsets.only(right: 4.0, top: 6),
            child:
            Text(this.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 5.0),
          child: BubbleSpecialOne(
            text: text,
            isSender: false,
            color: Colors.grey,
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: BubbleSpecialOne(
                text: text,
                isSender: true,
                color: primaryColor,
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      Column(
        children: [
          Container(
            child: CircleAvatar(
              child: Text(
                this.name[0],
                style: const TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 4.0, top: 6),
            child:
            Text(this.name, style: Theme.of(context).textTheme.subtitle1),
          )
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}