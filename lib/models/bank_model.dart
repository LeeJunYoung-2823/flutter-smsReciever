// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:sms/sms.dart';
// import 'package:http/http.dart' as http;
// import 'sms_model.dart';
// import 'util.dart';
//
// class BankResponse {
//
//   String returnType;
//   String returnCode;
//   String returnMessage;
//   List<BankOrderData> result;
//
//   BankResponse( {this.returnType, this.returnCode, this.returnMessage});
//
//   Map<String, dynamic> _json;
//
//   BankResponse.fromJson(String keyResult, Map<String, dynamic> json) {
//     _json = json;
//     returnType = json['returnType'];
//     returnCode = json['returnCode'];
//     returnMessage = json['returnMessage'];
//     if (json[keyResult] != null) {
//       result =  List<BankOrderData>();
//       json[keyResult].forEach((value) {
//         result.add(BankOrderData.fromJson(value));
//       });
//     }
//
//   }
//
//   bool isSuccess(){
//     return returnCode == 'Sucess';
//   }
// }
//
//
// class BankState with ChangeNotifier {
//   List<BankOrderData> _orderDataList =[];
//   List<BankOrderData> get orderDataList => _orderDataList;
//   List<BankOrderData> _hiddenList = [];
//   List<BankOrderData> get hiddenList => _hiddenList;
//
//   bool isFetching;
//
//   SmsQuery query;
//   BankState() {
//   }
//
//
//   fetchData(){
//     isFetching = true;
//     _fetchData().then((result){
//       _orderDataList = result;
//
//       isFetching = false;
//       notifyListeners();
//     }).catchError((error){
//       isFetching = false;
//       notifyListeners();
//     });
//   }
//
//   Future<List<BankOrderData>> _fetchData() async {
//
// //    var response = await http.get('http://www.sweetbook.com/mobile/api/get-offbank-data.aspx?cid=a12fg54gg9e');
// //    var decoded = await Util().decodeEucKr(response.bodyBytes);
// //    print(decoded);
// //    if (200 <= response.statusCode && response.statusCode < 300){
// //      var bankResponse = BankResponse.fromJson('result',json.decode(decoded));
// //      if (bankResponse.isSuccess()){
// //        return bankResponse.result;
// //      }
// //    }
// //    return null;
//
//
//
// ////    _orderDatas = await query.getAllSms;
// ////    _orderDatas = _orderDatas.where((element) => element.address == '16449999').toList();
// //
// ////    var tempList = _hiddenList.map((element)=>element.id).toList();
// ////    _orderDatas = _orderDatas.where((element) => !tempList.contains(element.id)).toList();
// ////    notifyListeners();
//   }
//
//
//   hideMessages(List<BankOrderData> messageList) {
//     _hiddenList.addAll(messageList);
//     messageList.forEach((element) => orderDataList.remove(element));
//     messageList.clear();
//     notifyListeners();
//   }
//
//   unHideMessages(messageList) {
//     orderDataList.addAll(messageList);
//     messageList.forEach((element) => _hiddenList.remove(element));
//     messageList.clear();
//     notifyListeners();
//   }
//
//   void sortMessages(soringOrder){
//     _sort(_orderDataList, soringOrder);
//   }
//   void sortHiddenList(soringOrder){
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
//   _sortDate(List<BankOrderData> list, isReverse) {
//     list.sort((a, b) =>
//     isReverse ? b.dateString.compareTo(a.dateString) : a.dateString.compareTo(b.dateString));
//     notifyListeners();
//   }
//
//   _sortMoney(List<BankOrderData> list, isReverse) {
//     list.sort((a, b) => isReverse
//         ? b.money.compareTo(a.money)
//         : a.money.compareTo(b.money));
//     notifyListeners();
//   }
//
//   _sortName(List<BankOrderData> list ,isReverse) {
//     list.sort((a, b) => isReverse
//         ? b.name.compareTo(a.name)
//         : a.name.compareTo(b.name));
//     notifyListeners();
//   }
// }
//
// class BankOrderData {
//   String num;
//   String sendName;
//   String name;
//   String phone;
//   String email;
//   String totalMoney;
//   String besongMoney;
//   String pay;
//   String dateString;
//   String get dateDisplayString{
//     return dateString.substring(0,dateString.length-3).substring(5).replaceAll('오', '\n오');
// }
//
//   int get money {
//     return int.parse(totalMoney);
//   }
//   DateTime get date {
//     var isPM = dateString.contains('오후');
//     var str = dateString.replaceAll('오후', '').replaceAll('오전', '');
//     var date = DateTime.parse(str);
//     return isPM ? date.add(Duration(hours: 12)) : date;
//   }
//
//   BankOrderData(
//       {this.num,
//         this.sendName,
//         this.name,
//         this.phone,
//         this.email,
//         this.totalMoney,
//         this.besongMoney,
//         this.pay,
//         this.dateString});
//
//   BankOrderData.fromJson(Map<String, dynamic> json) {
//     num = json['num'];
//     sendName = json['send_name'];
//     name = json['name'];
//     phone = json['phone'];
//     email = json['email'];
//     totalMoney = json['totalmoney'];
//     besongMoney = json['besongmoney'];
//     pay = json['pay'];
//     dateString = json['date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['num'] = this.num;
//     data['send_name'] = this.sendName;
//     data['name'] = this.name;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['totalmoney'] = this.totalMoney;
//     data['besongmoney'] = this.besongMoney;
//     data['pay'] = this.pay;
//     data['date'] = this.dateString;
//     return data;
//   }
// }
