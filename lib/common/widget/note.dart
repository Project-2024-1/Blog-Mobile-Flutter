// Widget _buildButtonBody() {
//   return Align(
//     alignment: Alignment.bottomLeft,
//     child: Container(
//       // height:ScreenUtil().setHeight(50),
//       // margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).viewPadding.bottom, horizontal: 2.w),
//       padding: EdgeInsets.only(left: 5.w,right: 5.w),
//       width: double.infinity,
//       color: Colors.white,
//       child: Row(
//         children: <Widget>[
//
//           SizedBox(
//             width: 5,
//           ),
//           Expanded(
//               child: TextFieldChatUser(
//                 hint: 'メッセージを入力',
//                 textController: _textUserController,
//                 onFocusChange: (bool valueChange){
//                   _isCheck = valueChange;
//                   print('valueChange $_isCheck');
//                 },
//               )),
//           SizedBox(
//             // width: 10,
//           ),
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 this._keywordTextUserSend = _textUserController.text;
//                 if(_keywordTextUserSend.isNotEmpty) {
//                   // _fetchDataUserSendMessage(checkType: 1);
//                   _fetchDataUserSendMessage(checkType: 1);
//                 }
//                 print(_keywordTextUserSend);
//                 // _scrollController.animateTo(0.0, curve: Curves.bounceInOut, duration: const Duration(milliseconds: 300),
//                 // );
//               });
//             },
//             child: _isCheckHiveButton
//                 ? Container()
//                 : _isCheck
//                     ? Container(
//                 margin: EdgeInsets.only(right: 5.w, left: 5.w),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Icon(Icons.send, color: Color(0xffA5A5A5), size: 26,))
//                     : GestureDetector(
//                         onTap: () {
//                           _showPicker(context);
//                         },
//                         child: Container(
//                             margin: EdgeInsets.only(right: 5.w, left: 5.w),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Icon(Icons.add_a_photo, color: Color(0xffA5A5A5), size: 26,
//                             )),
//                       ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
