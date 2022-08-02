// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sms/sms.dart';
// import 'package:sms_reciever/page/test_db.dart';
// import '../models/sms_model.dart';
//
// class HiddenListPage extends StatefulWidget {
//   @override
//   _HiddenListPageState createState() => _HiddenListPageState();
// }
//
// class _HiddenListPageState extends State<HiddenListPage> {
//   List<SmsMessage> selectedList = [];
//   var sortingState = SortingOrder.date_reverse;
//   Timer timer;
//
//   @override
//   void initState() {
//     Provider.of<MessageState>(context, listen: false)
//         .fetchData();
//     super.initState();
//
//     // 3초마다 새로고침
//     timer = Timer.periodic(Duration(seconds: 3), (Timer t){
//       if(this.mounted) {
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
//     List<SmsMessage> messages = Provider.of<MessageState>(context).hiddenList;
//     provider.sortHiddenList(sortingState);
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
//                     child: getSortingTextWidget(SortingOrder.date, SortingOrder.date_reverse),
//                     onPressed: () {
//                       setState(() {
//                         if(sortingState == SortingOrder.date_reverse)
//                           sortingState = SortingOrder.date;
//                         else
//                           sortingState = SortingOrder.date_reverse;
//                       });
//                     },
//                   ),
//                   FlatButton(
//                     child: getSortingTextWidget(SortingOrder.name, SortingOrder.name_reverse),
//                     onPressed: () {
//                       setState(() {
//                         if(sortingState == SortingOrder.name_reverse)
//                           sortingState = SortingOrder.name;
//                         else
//                           sortingState = SortingOrder.name_reverse;
//                       });
//                     },
//                   ),
//                   FlatButton(
//                     child: getSortingTextWidget(SortingOrder.money, SortingOrder.money_reverse),
//                     onPressed: () {
//                       setState(() {
//                         if(sortingState == SortingOrder.money_reverse)
//                           sortingState = SortingOrder.money;
//                         else
//                           sortingState = SortingOrder.money_reverse;
//                       });
//                     },
//                   ),
// /*                  FlatButton(
//                     child: Text('처리', style: TextStyle(fontWeight: FontWeight.bold)),
//                   )*/
//                 ],
//               );
//             },
//           ),
//         ),
//         messages == null
//             ? Text('no messages')
//             : Expanded(
//                 child: ListView.builder(
//                   itemCount: messages == null ? 0 : messages.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     var messageItem = messages[index];
//
//                     return GestureDetector(
//                       onLongPress: (){
//                         showAlertDialog(context, messageItem, provider);
//                       },
//                       child: Container(
//                         //color: _selected[index] ? Colors.grey : null,
//                         child: ListTile(
//                           /*leading: Checkbox(
//                             onChanged: (bool value) {
//                               selectOrDeselectMessage(messageItem);
//                             },
//                             value: isSelectedMessage(messageItem),
//                           ),*/
//                           title: Container(
//                             decoration: BoxDecoration(
//                                 border: Border(
//                                     bottom: BorderSide(
//                                       color: Colors.grey,
//                                       width: 0.5,
//                                     )
//                                 ),
//                             ),
//                             child: Row(
//                               children: <Widget>[
//                                 Expanded(
//                                   flex: 2,
//                                   child: Container(
//                                     decoration: BoxDecoration(),
//                                     child: Text(
//                                         getSMSValue(messageItem.body, 1)
//                                         .replaceAll('[KB]', ''),
//                                         style: TextStyle(fontWeight: FontWeight.bold)
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     getSMSValue(messageItem.body, 3),
//                                     style: TextStyle(fontWeight: FontWeight.bold)
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(12.0),
//                                     child: Text(getSMSValue(messageItem.body, 5) + '원',
//                                         style: TextStyle(fontWeight: FontWeight.bold)),
//                                   ),
//                                 ),
//                                 /*Expanded(
//                                   flex: 1,
//                                   child: FlatButton(
//                                     child: Text(
//                                         '복원',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         )
//                                     ),
//                                     color: Colors.redAccent,
//                                     onPressed: (){
//                                       // selectedList 변수에 선택한 message 내용 추가
//                                       selectMessage(messageItem);
//
//                                       // 복원 시 테이블에 데이터 삭제
//                                       DBHelper().deleteData(messageItem);
//                                       provider.unHideMessages(selectedList);
//                                       selectedList.clear();
//                                     },
//                                   ),
//                                 ),*/
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//
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
//                   "복원",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.blueAccent),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     provider.unHideMessages(selectedList);
//                     selectedList.clear();
//                   });
//                 },
//               )
//             ],
//           ),
//         ),*/
//
//       ],
//     );
//   }
//
//   void showAlertDialog(BuildContext context, SmsMessage messageItem,
//       MessageState provider) async {
//     String result = await showDialog(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('입금확인관리'),
//           content: Text("해당 메세지를 미처리란으로 보내시겠습니까?"),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('OK'),
//               onPressed: () {
//                 selectMessage(messageItem);
//                 // 복원 시 테이블에 데이터 삭제
//                 DBHelper().deleteData(messageItem);
//                 provider.unHideMessages(selectedList);
//                 selectedList.clear();
//                 Navigator.pop(context, "OK");
//               },
//             ),
//             FlatButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context, "Cancel");
//               },
//             ),
//           ],
//         );
//       },
//     );
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
//     var isAccent = (sortingState  == order || sortingState == reverse);
//
//     if(sortingState == order) {
//       switch (order) {
//         case SortingOrder.date:
//           return Text("⬆시간", style: TextStyle(color: isAccent ? Theme
//               .of(context)
//               .accentColor : Colors.black38, fontWeight: FontWeight.bold));
//         case SortingOrder.money:
//           return Text("⬆금액", style: TextStyle(color: isAccent ? Theme
//               .of(context)
//               .accentColor : Colors.black38, fontWeight: FontWeight.bold));
//         case SortingOrder.name:
//           return Text("⬆이름", style: TextStyle(color: isAccent ? Theme
//               .of(context)
//               .accentColor : Colors.black38, fontWeight: FontWeight.bold));
//         default:
//           break;
//       }
//     }
//
//     switch(reverse){
//       case SortingOrder.date_reverse:
//         return Text("시간", style: TextStyle(color: Theme.of(context).accentColor,
//             fontWeight: FontWeight.bold) );
//       case SortingOrder.money_reverse:
//         return Text("금액", style: TextStyle(color: Theme.of(context).accentColor,
//             fontWeight: FontWeight.bold) );
//       case SortingOrder.name_reverse:
//         return Text("이름", style: TextStyle(color: Theme.of(context).accentColor,
//             fontWeight: FontWeight.bold) );
//       default :
//         break;
//     }
//     return Text('');
//   }
// }
