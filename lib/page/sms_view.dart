// import 'package:flutter/material.dart';
// //import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:provider/provider.dart';
// import 'package:sms/sms.dart';
// import 'package:sms_reciever/models/sms_model.dart';
// import 'package:sms_reciever/page/test_db.dart';
//
// class SmsViewPage extends StatelessWidget {
//   final String smsName;
//   final String amount;
//   final SmsMessage messageItem;
//
//   SmsViewPage(this.smsName, this.amount, this.messageItem);
//
//   String msg = '';
//   List<SmsMessage> selectedList = [];
//
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<MessageState>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('입금대기 리스트'),
//         backgroundColor: Colors.red,
//         centerTitle: true,
//       ),
//       body: Stack(
//           children: <Widget> [
//             /*WebviewScaffold(
//               url: (
//                 "http://www.sweetbook.com/admin/regist_list-mweb_utf8.asp?"
//                     "app=regist_mweb&what=new&sms_name=$smsName&amount=$amount"
//               ),
//               withZoom: true,
//               withJavascript: true,
//               javascriptChannels: Set.from([
//                 JavascriptChannel(
//                   name: 'Print',
//                   onMessageReceived: (JavascriptMessage message){
//                     print(message.message);
//                     msg = message.message;
//                     print(msg);
//                     // selectedList 변수에 처리한 message 내용 추가
//                     if(msg == 'complete'){
//                       selectMessage(messageItem);
//                       // 처리 시 테이블에 데이터 삽입
//                       DBHelper().insertData(messageItem);
//                       provider.hideMessages(selectedList);
//                       selectedList.clear();
//                     }
//                   },
//                 ),
//               ]),
//             ),*/
//           ]
//       ),
//     );
//   }
//
//   // 메세지 내용 저장
//   selectMessage(message) {
//     selectedList.add(message);
//   }
// }
//
