// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sms/sms.dart';
// import 'package:sms_reciever/page/sms_view.dart';
// import 'package:sms_reciever/page/test_db.dart';
// import '../models/sms_model.dart';
//
// class SmsListPage extends StatefulWidget {
//   @override
//   _SmsListPageState createState() => _SmsListPageState();
// }
//
// class _SmsListPageState extends State<SmsListPage> {
//   List<SmsMessage> selectedList = [];
//   var sortingState = SortingOrder.date_reverse;
//   List<bool> _selected = [];
//   Timer timer;
//
//   @override
//   void initState() {
//     Provider.of<MessageState>(context, listen: false).fetchData();
//     super.initState();
//
//     // 3초마다 새로고침
//     timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
//       if (this.mounted) {
//         //setState(() {
//         Provider.of<MessageState>(context, listen: false).fetchData();
//         //});
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<MessageState>(context);
//     List<SmsMessage> messages = Provider.of<MessageState>(context).messages;
//     provider.sortMessages(sortingState);
//     _selected = Provider.of<MessageState>(context).selected;
//
//     return Column(
//       children: <Widget>[
//         Container(
//           color: Colors.black12,
//           padding: const EdgeInsets.only(top: 2),
//           alignment: Alignment.center,
//           child: Builder(
//             builder: (context1) {
//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   FlatButton(
//                     child: getSortingTextWidget(
//                         SortingOrder.date, SortingOrder.date_reverse),
//                     onPressed: () {
//                       /*setState(() {
//                         _selected = List.generate(messages.length, (i) => false);
//                         if(sortingState == SortingOrder.date_reverse)
//                           sortingState = SortingOrder.date;
//                         else
//                           sortingState = SortingOrder.date_reverse;
//                       });*/
//                     },
//                   ),
//                   FlatButton(
//                     child: getSortingTextWidget(
//                         SortingOrder.name, SortingOrder.name_reverse),
//                     onPressed: () {
//                       /*setState(() {
//                         _selected = List.generate(messages.length, (i) => false);
//                         if(sortingState == SortingOrder.name_reverse)
//                           sortingState = SortingOrder.name;
//                         else
//                           sortingState = SortingOrder.name_reverse;
//                       });*/
//                     },
//                   ),
//                   FlatButton(
//                     child: getSortingTextWidget(
//                         SortingOrder.money, SortingOrder.money_reverse),
//                     onPressed: () {
//                       /*setState(() {
//                         _selected = List.generate(messages.length, (i) => false);
//                         if(sortingState == SortingOrder.money_reverse)
//                           sortingState = SortingOrder.money;
//                         else
//                           sortingState = SortingOrder.money_reverse;
//                       });*/
//                     },
//                   ),
//                   FlatButton(
//                     child: Text('처리',
//                         style: TextStyle(
//                             color: Theme.of(context).accentColor,
//                             fontWeight: FontWeight.bold)),
//                   )
//                 ],
//               );
//             },
//           ),
//         ),
//         if (messages == null)
//           Text('no messages')
//         else
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages == null ? 0 : messages.length,
//               itemBuilder: (BuildContext context, int index) {
//                 var messageItem = messages[index];
//                 //return Dismissible(
//                 /*key: UniqueKey(),
//                       onDismissed: (direction){
//                         selectMessage(messageItem);
//                         // 처리 시 테이블에 데이터 삽입
//                         DBHelper().insertData(messageItem);
//                         provider.hideMessages(selectedList);
//                         selectedList.clear();
//                       },*/
//                 return Container(
//                   //color: _selected[index] ? Colors.grey : null, // 선택한 Row 색 지정
//                   child: ListTile(
//                     /*leading: Checkbox(
//                             onChanged: (bool value) {
//                               selectOrDeselectMessage(messageItem);
//                             },
//                             value: isSelectedMessage(messageItem),
//                           ),*/
//                     onTap: () {
//                       /*setState(() {
//                               _selected[index] = !_selected[index];
//                             });*/
//                       /*Navigator.of(context)
//                                 .push(MaterialPageRoute(builder: (context) =>
//                                     MultiProvider(
//                                       providers: [
//                                         ChangeNotifierProvider<MessageState>(
//                                           create: (_) => MessageState(),
//                                         )
//                                       ],
//                                       child: SmsViewPage(getSMSValue(messageItem.body, 3),
//                                         getSMSValue(messageItem.body, 5).replaceAll(',',''),
//                                         messageItem),
//                                     ))
//                             );*/
//                     },
//                     title: Container(
//                       decoration: BoxDecoration(
//                           border: Border(
//                               bottom: BorderSide(
//                         color: Colors.grey,
//                         width: 0.5,
//                       ))),
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             flex: 2,
//                             child: Container(
//                               decoration: BoxDecoration(),
//                               child: Text(
//                                   getSMSValue(messageItem.body, 1)
//                                       .replaceAll('[KB]', ''),
//                                   style:
//                                       TextStyle(fontWeight: FontWeight.bold)),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Text(getSMSValue(messageItem.body, 3),
//                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                           ),
//                           Expanded(
//                             flex: 2,
//                             child: Padding(
//                               padding: const EdgeInsets.all(12.0),
//                               child: Text(
//                                   getSMSValue(messageItem.body, 5) + '원',
//                                   style:
//                                       TextStyle(fontWeight: FontWeight.bold)),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: FlatButton(
//                               child: Text('처리',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 12,
//                                   )),
//                               color: Colors.redAccent,
//                               onPressed: () {
//                                 // 삭제하기 전 Row 선택 여부 값 재 지정
//                                 //selectRowSort(index, messages);
//
//                                 // selectedList 변수에 선택한 message 내용 추가
//                                 selectMessage(messageItem);
//
//                                 // 처리 시 테이블에 데이터 삽입
//                                 DBHelper().insertData(messageItem);
//                                 provider.hideMessages(selectedList);
//                                 selectedList.clear();
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//                 //);
//               },
//             ),
//           ),
//         /*AnimatedContainer(
//           duration: Duration(milliseconds: 100),
//           height: selectedList.length == 0 ? 0 : 50,
//           color: Colors.black12,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               FlatButton(
//                 child: Text(
//                   "선택해제",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.blueAccent),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     selectedList.clear();
//                   });
//                 },
//               ),
//               Expanded(child: Container(),),
//               FlatButton(
//                 child: Text(
//                   "숨기기",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.blueAccent),
//                 ),
//                 onPressed: () {
//
//                   for(var i = 0; i < selectedList.length; i++){
//                     var hiddenItem = selectedList[i];
//
//                     List<HiddenSms> hiddenList = [
//                       HiddenSms(
//                           date: getSMSValue(hiddenItem.body, 1)
//                                 .replaceAll('[KB]', ''),
//                           name: getSMSValue(hiddenItem.body, 3),
//                           totalmoney: int.parse(getSMSValue(hiddenItem.body, 5)
//                                         .replaceAll(',', ''))
//                       )
//                     ];
//                     print(hiddenList[0].date);
//                     HiddenSms hidden = hiddenList[0];
//
//                     DBHelper().insertData(hidden);
//                   }
//
//                   provider.hideMessages(selectedList);
//                 },
//               )
//             ],
//           ),
//         ),*/
//       ],
//     );
//   }
//
//   selectRowSort(int index, List<SmsMessage> messages) {
//     // 첫번째 Row를 삭제하는 경우 (삭제하기 전)
//     // 다음 Row부터 선택 여부 값 체크
//     // 선택 여부에 따라 이전 Row와 현재 Row의 선택 여부 값을 새로 지정
//     if (index == 0) {
//       for (var i = 1; i < messages.length; i++) {
//         if (_selected[i] == true) {
//           _selected[i - 1] = true;
//           _selected[i] = false;
//         } else {
//           _selected[i - 1] = false;
//           _selected[i] = true;
//         }
//       }
//     }
//     // 중간 Row를 삭제하는 경우 (삭제하기 전)
//     // 삭제할 Row의 다음 Row부터 선택 여부 값 체크
//     // 선택 여부에 따라 이전 Row와 현재 Row의 선택 여부 값을 새로 지정
//     else if (index != messages.length - 1 && index != 0) {
//       for (var j = index + 1; j < messages.length; j++) {
//         if (_selected[j] == true) {
//           _selected[j - 1] = true;
//           _selected[j] = false;
//         } else {
//           _selected[j - 1] = false;
//           _selected[j] = true;
//         }
//       }
//     }
//   }
//
//   selectOrDeselectMessage(message) {
//     if (isSelectedMessage(message))
//       deselectMessage(message);
//     else
//       selectMessage(message);
//   }
//
//   selectMessage(message) {
//     setState(() {
//       selectedList.add(message);
//     });
//   }
//
//   deselectMessage(message) {
//     setState(() {
//       selectedList.remove(message);
//     });
//   }
//
//   bool isSelectedMessage(message) {
//     return selectedList.contains(message);
//   }
//
//   Widget getSortingTextWidget(SortingOrder order, SortingOrder reverse) {
//     var isAccent = (sortingState == order || sortingState == reverse);
//
//     if (sortingState == order) {
//       switch (order) {
//         case SortingOrder.date:
//           return Text("⬆시간",
//               style: TextStyle(
//                   color:
//                       isAccent ? Theme.of(context).accentColor : Colors.black38,
//                   fontWeight: FontWeight.bold));
//         case SortingOrder.money:
//           return Text("⬆금액",
//               style: TextStyle(
//                   color:
//                       isAccent ? Theme.of(context).accentColor : Colors.black38,
//                   fontWeight: FontWeight.bold));
//         case SortingOrder.name:
//           return Text("⬆이름",
//               style: TextStyle(
//                   color:
//                       isAccent ? Theme.of(context).accentColor : Colors.black38,
//                   fontWeight: FontWeight.bold));
//         default:
//           break;
//       }
//     }
//
//     switch (reverse) {
//       case SortingOrder.date_reverse:
//         return Text("시간",
//             style: TextStyle(
//                 color: Theme.of(context).accentColor,
//                 fontWeight: FontWeight.bold));
//       case SortingOrder.money_reverse:
//         return Text("금액",
//             style: TextStyle(
//                 color: Theme.of(context).accentColor,
//                 fontWeight: FontWeight.bold));
//       case SortingOrder.name_reverse:
//         return Text("이름",
//             style: TextStyle(
//                 color: Theme.of(context).accentColor,
//                 fontWeight: FontWeight.bold));
//       default:
//         break;
//     }
//     return Text('');
//   }
// }
