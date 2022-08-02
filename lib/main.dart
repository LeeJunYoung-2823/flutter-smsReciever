// @dart=2.9
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sms/sms.dart';
import 'package:sms_reciever/models/sms_model.dart';
import 'package:sms_reciever/page/test_db.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<MessageProvider>(
      create: (_) => MessageProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // sms 목록, 업로드 시간 가져오기
    Provider.of<MessageProvider>(context, listen: false).smsRefresh((success) {
      Provider.of<MessageProvider>(context, listen: false).getUploadTime();
    });

    // 5초마다 문자목록 새로고침
    Timer.periodic(Duration(seconds: 5), (Timer t) {
      if (this.mounted) {
        Provider.of<MessageProvider>(context, listen: false)
            .smsRefresh((success) {});
      }
    });

    super.initState();
  }

  TextEditingController _textEditingController;
  String text = "";
  Timer timer;
  int cursorPos = 0;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final smsProvider = Provider.of<MessageProvider>(context);
    _textEditingController = TextEditingController(text: text);

    if (_textEditingController.text != "") {
      if (cursorPos == 0) {
        cursorPos = _textEditingController.text.length;
      }

      _textEditingController.selection =
          TextSelection.fromPosition(TextPosition(offset: cursorPos));
    }

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.pink,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('입금확인관리'),
          backgroundColor: Colors.red,
          centerTitle: true,
          actions: <Widget>[
            Builder(builder: (context) {
              return IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  smsProvider.smsRefresh((success) {
                    print('refresh: ${smsProvider.notUploadList.length}');
                  });
                },
              );
            })
          ],
        ),
        body: smsProvider.notUploadList == null
            ? Center(child: CircularProgressIndicator())
            : Builder(
                builder: (context) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    width: 1000,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              color: Colors.red,
                              onPressed: () {
                                int cnt = 0;
                                if (smsProvider.notUploadList != null &&
                                    smsProvider.notUploadList.length > 0) {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) {
                                      /// 문자 업로드 중에 오류가 있다면 문자 내용이 잘못된게 있는지 확인
                                      /// 문자 내용에 이상 없으면 서버 api 확인
                                      return smsUpload();
                                    },
                                  );
                                  smsProvider.notUploadList.forEach((list) {
                                    DBHelper().insertData(list);
                                    smsProvider.uploadSms(list, (success) {
                                      setState(() {
                                        cnt++;
                                        if (cnt ==
                                            smsProvider.notUploadList.length) {
                                          smsProvider.getUploadTime();

                                          Timer(Duration(seconds: 2), () {
                                            Navigator.of(context).pop();
                                          });
                                        }
                                      });
                                    });
                                  });
                                }
                              },
                              child: Text('문자 업로드',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 40,
                                    child: TextField(
                                      controller: _textEditingController,
                                      onChanged: (txt) {
                                        text = _textEditingController.text;
                                        smsProvider.isChecked = false;
                                        cursorPos = _textEditingController
                                            .selection.baseOffset;

                                        if (timer != null) {
                                          print('cancel1');
                                          timer.cancel();
                                        }
                                      },
                                    )),
                                Text('분 마다 자동 업로드 '),
                                Checkbox(
                                    value: smsProvider.isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        print(value);
                                        print(text);

                                        smsProvider.isChecked = value;
                                        if (smsProvider.isChecked &&
                                            int.tryParse(text) != null) {
                                          timer = Timer.periodic(
                                              Duration(
                                                  minutes: int.parse(text)),
                                              (Timer t) {
                                            if (this.mounted) {
                                              print(text);
                                              int cnt = 0;
                                              if (smsProvider.notUploadList !=
                                                      null &&
                                                  smsProvider.notUploadList
                                                          .length >
                                                      0) {
                                                print('자동 업로드');
                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (_) {
                                                    /// 문자 업로드 중에 오류가 있다면 문자 내용이 잘못된게 있는지 확인
                                                    /// 문자 내용에 이상 없으면 서버 api 확인
                                                    return smsUpload();
                                                  },
                                                );
                                                smsProvider.notUploadList
                                                    .forEach((list) {
                                                  DBHelper().insertData(list);
                                                  smsProvider.uploadSms(list,
                                                      (success) {
                                                    setState(() {
                                                      cnt++;
                                                      if (cnt ==
                                                          smsProvider
                                                              .notUploadList
                                                              .length) {
                                                        smsProvider
                                                            .getUploadTime();
                                                        Timer(
                                                            Duration(
                                                                seconds: 2),
                                                            () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      }
                                                    });
                                                  });
                                                });
                                              }
                                            }
                                          });
                                        } else {
                                          print('cancel2');
                                          timer.cancel();
                                        }
                                      });
                                    })
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                                '업로드 필요 갯수: ${smsProvider.notUploadList.length}'),
                            smsProvider.uploadTime == null
                                ? Container(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator())
                                : Text(
                                    '최근 업로드 시간: ${smsProvider.uploadTime == "" ? "" : smsProvider.uploadTime}',
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  AlertDialog smsUpload() {
    return AlertDialog(
      content: Container(
        width: 100,
        height: 150,
        child: Container(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator()),
              SizedBox(
                height: 50,
              ),
              Text('업로드 중')
            ],
          ),
        ),
      ),
    );
  }
}
