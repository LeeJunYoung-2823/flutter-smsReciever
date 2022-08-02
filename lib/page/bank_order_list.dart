// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sms_reciever/models/bank_model.dart';
// import '../models/sms_model.dart';
//
// class BankOrderListPage extends StatefulWidget {
//   @override
//   _BankOrderListPageState createState() => _BankOrderListPageState();
// }
//
// class _BankOrderListPageState extends State<BankOrderListPage> {
//   List<BankOrderData> selectedList = [];
//   var sortingState = SortingOrder.date_reverse;
//
//   @override
//   void initState() {
//     Provider.of<BankState>(context, listen: false).fetchData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var bankProvider = Provider.of<BankState>(context);
//     List<BankOrderData> orderDataList =
//         Provider.of<BankState>(context).orderDataList;
//     bankProvider.sortMessages(sortingState);
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
//                       setState(() {
//                         if (sortingState == SortingOrder.date_reverse)
//                           sortingState = SortingOrder.date;
//                         else
//                           sortingState = SortingOrder.date_reverse;
//                       });
//                     },
//                   ),
//                   FlatButton(
//                     child: getSortingTextWidget(
//                         SortingOrder.name, SortingOrder.name_reverse),
//                     onPressed: () {
//                       setState(() {
//                         if (sortingState == SortingOrder.name_reverse)
//                           sortingState = SortingOrder.name;
//                         else
//                           sortingState = SortingOrder.name_reverse;
//                       });
//                     },
//                   ),
//                   FlatButton(
//                     child: getSortingTextWidget(
//                         SortingOrder.money, SortingOrder.money_reverse),
//                     onPressed: () {
//                       setState(() {
//                         if (sortingState == SortingOrder.money_reverse)
//                           sortingState = SortingOrder.money;
//                         else
//                           sortingState = SortingOrder.money_reverse;
//                       });
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//         orderDataList == null
//             ? Text('no messages')
//             : Expanded(
//                 child: ListView.builder(
//                   itemCount: orderDataList == null ? 0 : orderDataList.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     var orderData = orderDataList[index];
//                     return Container(
//                       color: isSelectedMessage(orderData)
//                           ? Colors.yellow
//                           : Colors.white,
//                       child: ListTile(
//                         //복수 입금확인처리할때 사용하면 될듯
// //                      leading: Checkbox(
// //                        onChanged: (bool value) {
// //                          selectOrDeselectMessage(orderData);
// //                        },
// //                        value: isSelectedMessage(orderData),
// //                      ),
//                         onTap: () {
//                           selectOrDeselectMessage(orderData);
//                         },
//                         title: Row(
//                           children: <Widget>[
//                             Expanded(
//                               flex: 2,
//                               child: Container(
//                                 decoration: BoxDecoration(),
//                                 child: Text(
//                                   '${orderData.dateDisplayString}',
//                                   style: TextStyle(fontSize: 13),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 3,
//                               child: Text('${orderData.name}'),
//                             ),
//                             Expanded(
//                               flex: 2,
//                               child: Text('${orderData.totalMoney}원'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//         AnimatedContainer(
//           duration: Duration(milliseconds: 100),
//           height: selectedList.length == 0 ? 0 : 50,
//           color: Colors.black12,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               Expanded(
//                 child: Container(),
//               ),
//               FlatButton(
//                 child: Text(
//                   "입금확인",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.blueAccent),
//                 ),
//                 onPressed: () {
//                   //todo: 입금확인처리 구현해야함
// //                  bankProvider.hideMessages(selectedList);
//                 },
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   selectOrDeselectMessage(message) {
//     if (isSelectedMessage(message))
//       deselectAllMessages();
//     else {
//       deselectAllMessages();
//       selectMessage(message);
//     }
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
//   deselectAllMessages() {
//     setState(() {
//       selectedList.clear();
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
//           return Text("︎⬆︎시간",
//               style: TextStyle(
//                 color:
//                     isAccent ? Theme.of(context).accentColor : Colors.black38,
//               ));
//         case SortingOrder.money:
//           return Text("⬆금액",
//               style: TextStyle(
//                 color:
//                     isAccent ? Theme.of(context).accentColor : Colors.black38,
//               ));
//         case SortingOrder.name:
//           return Text("⬆이름",
//               style: TextStyle(
//                 color:
//                     isAccent ? Theme.of(context).accentColor : Colors.black38,
//               ));
//         default:
//           break;
//       }
//     }
//
//     switch (reverse) {
//       case SortingOrder.date_reverse:
//         return Text("⬇시간",
//             style: TextStyle(
//               color: isAccent ? Theme.of(context).accentColor : Colors.black38,
//             ));
//       case SortingOrder.money_reverse:
//         return Text("⬇금액",
//             style: TextStyle(
//               color: isAccent ? Theme.of(context).accentColor : Colors.black38,
//             ));
//       case SortingOrder.name_reverse:
//         return Text("⬇이름",
//             style: TextStyle(
//               color: isAccent ? Theme.of(context).accentColor : Colors.black38,
//             ));
//       default:
//         break;
//     }
//     return Text('');
//   }
// }
