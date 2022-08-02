// import 'package:flutter/cupertino.dart';
// import 'package:sms/sms.dart';
// import 'package:sms_reciever/models/util.dart';
// import 'package:sms_reciever/page/test_db.dart';
//
// import 'hidden_model.dart';
//
// class MessageState with ChangeNotifier {
//   List<SmsMessage> _messages;
//   List<SmsMessage> get messages => _messages;
//   List<SmsMessage> _hiddenList = [];
//   List<SmsMessage> get hiddenList => _hiddenList;
//   List<bool> _selected = [];
//   List<bool> get selected => _selected;
//
//   SmsQuery query;
//   MessageState() {
//     query = SmsQuery();
//     _messages = [];
//   }
//
//   Future<void> fetchData() async {
//     _messages = await query.getAllSms;
//     _hiddenList = await query.getAllSms;
//
//     //국민은행 또는 스위트북 문자만 필터링
//     _messages = _messages
//         .where((element) =>
//             element.address == '16449999' || element.address == '028860156')
//         .toList();
//     _hiddenList = _hiddenList
//         .where((element) =>
//             element.address == '16449999' || element.address == '028860156')
//         .toList();
//
//     // 미처리 문자 List 선택 여부 초기값 지정
//     //_selected = List.generate(_messages.length, (i) => false);
//
//     //DB에서 가져온 내용 필터링 (처리 문자)
//     //문자 받은 시간으로 맵핑
//     List<HiddenSms> _hiddenSelect = await DBHelper().selectData();
//     var hiddenSms = _hiddenSelect.map((element) => element.date).toList();
//
//     //처리 문자 탭에 DB에 있는 처리 문자 리스트 나타내기 (실제 문자 받은 시간으로 비교)
//     _hiddenList = _hiddenList
//         .where((element) => hiddenSms.contains(element.date))
//         .toList();
//
//     //var tempList = _hiddenList.map((element)=>element.date).toList();
//     //_messages = _messages.where((element) => !tempList.contains(element.date)).toList();
//
//     //미처리 문자 탭에 DB에 있는 처리된 문자는 필터링 (실제 문자 받은 시간으로 비교)
//     _messages = _messages
//         .where((element) => !hiddenSms.contains(element.date))
//         .toList();
//
//     notifyListeners();
//   }
//
//   // 미처리 문자 리스트에서 처리한 문자 제외
//   hideMessages(List<SmsMessage> messageList) {
//     _hiddenList.addAll(messageList);
//     messageList.forEach((element) => messages.remove(element));
//     messageList.clear();
//     notifyListeners();
//   }
//
//   // 처리 문자 리스트에서 미처리한 문자 제외
//   unHideMessages(messageList) {
//     messages.addAll(messageList);
//     messageList.forEach((element) => _hiddenList.remove(element));
//     messageList.clear();
//     notifyListeners();
//   }
//
//   void sortMessages(soringOrder) {
//     _sort(_messages, soringOrder);
//   }
//
//   void sortHiddenList(soringOrder) {
//     _sort(_hiddenList, soringOrder);
//   }
//
//   void _sort(list, sortingOrder) {
//     switch (sortingOrder) {
//       case SortingOrder.date:
//         _sortDate(list, false);
//         break;
//       case SortingOrder.name:
//         _sortName(list, false);
//         break;
//       case SortingOrder.money:
//         _sortMoney(list, false);
//         break;
//
//       case SortingOrder.date_reverse:
//         _sortDate(list, true);
//         break;
//       case SortingOrder.name_reverse:
//         _sortName(list, true);
//         break;
//       case SortingOrder.money_reverse:
//         _sortMoney(list, true);
//         break;
//     }
//   }
//
//   _sortDate(List<SmsMessage> list, isReverse) {
//     list.sort((a, b) =>
//         isReverse ? b.date.compareTo(a.date) : a.date.compareTo(b.date));
//     //notifyListeners();
//   }
//
//   _sortMoney(List<SmsMessage> list, isReverse) {
//     list.sort((a, b) => isReverse
//         ? getMoneyFromBody(b.body).compareTo(getMoneyFromBody(a.body))
//         : getMoneyFromBody(a.body).compareTo(getMoneyFromBody(b.body)));
//     //notifyListeners();
//   }
//
//   _sortName(List<SmsMessage> list, isReverse) {
//     list.sort((a, b) => isReverse
//         ? getNameFromBody(b.body).compareTo(getNameFromBody(a.body))
//         : getNameFromBody(a.body).compareTo(getNameFromBody(b.body)));
//     //notifyListeners();
//   }
// }
//
// //UtilMethod
// String getSMSValue(String body, int index) {
//   var list = body.split('\n');
//   if (list == null || list.length <= index) return ' [null] ';
//   return list[index];
// }
//
// String getNameFromBody(body) {
//   try {
//     return body.split('\n')[3];
//   } on Exception catch (e) {}
//   return '[error]';
// }
//
// int getMoneyFromBody(body) {
//   try {
//     return int.parse(body.split('\n')[5].replaceAll(',', ''));
//   } on Exception catch (e) {}
//   return 0;
// }
//
// enum SortingOrder {
//   date,
//   money,
//   name,
//   date_reverse,
//   money_reverse,
//   name_reverse,
// }
