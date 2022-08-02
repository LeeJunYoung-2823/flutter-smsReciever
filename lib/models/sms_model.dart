import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sms/sms.dart';
import 'package:sms_reciever/page/test_db.dart';
import 'package:http/http.dart' as http;

class MessageProvider with ChangeNotifier {
  List<SmsMessage> _messageList; // 문자 전체 목록
  List<SmsMessage> get messageList => _messageList;
  List<SmsMessage> _notUploadList; // 업로드 안된 목록
  List<SmsMessage> get notUploadList => _notUploadList;
  String uploadTime;
  bool isChecked = false;

  SmsQuery query = SmsQuery();

  // 문자 목록 새로고침
  Future<void> smsRefresh(onFinished) async {
    _messageList = await query.getAllSms;

    // 국민은행 또는 스위트북 문자만 필터링
    _messageList =
        _messageList.where((element) => element.address == '16449999').toList();

    //element.address == '028860156'

    // 내부 DB에 있는 업로드 된 목록 가져오기
    List<DBSms> _uploadData = await DBHelper().selectData();
    var uploadList = _uploadData.map((element) => element.date).toList();

    // 업로드 안된 목록 필터링
    _notUploadList = _messageList
        .where((element) => !uploadList.contains(element.date))
        .toList();

    onFinished(true);
    notifyListeners();
  }

  // 문자 업로드
  Future<void> uploadSms(SmsMessage message, onFinished) async {
    final body = uploadSmsBody(message);
    //print('body: ${body.toString()}');

    var url = Uri.parse("https://www.sweetbook.com/mobile/api/sms-deposit");
    final response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      final decoded = response.body;
      print(decoded);
      if (decoded == "OK") {
        onFinished(true);
      }
    } else {
      if (onFinished != null) onFinished(false);
      throw Exception('upload fail');
    }
  }

  Map<String, String> uploadSmsBody(SmsMessage message) {
    return {
      'name': getSMSValue(message.body, 3),
      'money': getSMSValue(message.body, 5),
      'contents': message.body,
      'depositDate': getSMSValue(message.body, 1).replaceAll('[KB]', ''),
      'smsDate': message.date.toString(),
    };
  }

  // 최근 업로드 시간 가져오기
  Future<void> getUploadTime() async {
    var url = Uri.parse(
        "https://www.sweetbook.com/mobile/api/sms-deposit?uploadTimeChk=true");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = response.body;
      uploadTime = decoded;
      print(uploadTime);
    } else {
      throw Exception('uploadTime Select fail');
    }
  }
}

// 내부 DB Model
class DBSms {
  final DateTime date;

  DBSms({this.date});
}

// 문자 내용
String getSMSValue(String body, int index) {
  var list = body.split('\n');
  if (list == null || list.length <= index) return ' [null] ';
  return list[index];
}
