// import 'dart:async';
//
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:loading_overlay/loading_overlay.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:io';
//
// import '../../../common/snack_bar_helper/snack_bar_helper.dart';
// import '../../../common/utils/regex.dart';
// import '../../../common/widget/widget_item/item_check_box.dart';
// import '../../../config/config.dart';
// import '../../../service/device_id/DeviceId.dart';
// import '../../../service/networking/apis/auth_api.dart';
//
//
// class RegisterPage extends StatefulWidget {
//   const RegisterPage({Key? key}) : super(key: key);
//
//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }
//
// class _RegisterPageState extends State<RegisterPage> {
//
//   Uint8List? _file;
//   final _formKey = GlobalKey<FormState>();
//   var _isLoading = false;
//   var _isAgree = false;
//   String? _errorMsg;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     inputEmailCtrler.addListener(() {
//       final text = inputEmailCtrler.text.trim();
//       if( inputEmailCtrler.text != text) {
//         inputEmailCtrler.value = inputEmailCtrler.value.copyWith(
//           text: text,
//           selection: TextSelection.collapsed(offset: text.length)
//         );
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     inputEmailCtrler.dispose();
//     super.dispose();
//   }
//
//   final inputNameCtrler = TextEditingController();
//   final inputEmailCtrler = TextEditingController();
//   final inputPasswordCtrler = TextEditingController();
//   final inputRePasswordCtrler = TextEditingController();
//
//
//   final RoundedLoadingButtonController _btnSubmitController = RoundedLoadingButtonController();
//
//   // let Create the variable to store the file image
//   File? _image;
//
//   // We will create a function to get image from camera
//   void _imageFromCamera() async {
//     PickedFile? imageCamera = await ImagePicker().getImage(source : ImageSource.camera, imageQuality: 50);
//     // Image Quality is your choice for selecting quality of image you need is your app
//
//     if(imageCamera != null) {
//       setState(() {
//         _image = File(imageCamera.path);
//         print("imageCamera: $_image");
//       });
//     }
//   }
//
//   // Let Create a function to get image from gallery
//   void _imageFromGallery() async {
//     PickedFile? imageGallery = await ImagePicker().getImage(source : ImageSource.gallery, imageQuality: 50);
//     if(imageGallery !=  null) {
//       setState(() {
//         _image = File(imageGallery.path);
//         print("imageGallery:  $_image");
//       });
//     }
//   }
//
//   // Let Create a function for giving option to user to select between gallery and camera
//   void _showPicker(context) async {
//     showModalBottomSheet(context: context, builder: (BuildContext buildContext) {
//       return SafeArea(
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text('Gallery'),
//                 onTap: () {
//                   _imageFromGallery();
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.camera_alt),
//                 title: Text('Camera'),
//                 onTap: () {
//                   _imageFromCamera();
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           )
//       );
//     });
//   }
//
//   Widget _profileImageContainer() {
//     return Container(
//       alignment: Alignment.centerLeft,
//       child: GestureDetector(
//         onTap: (){
//           _showPicker(context);
//         },
//         child: _image == null ? CircleAvatar(backgroundColor: Color(0xffD9D9D9), radius: 48.0, child: new Icon(Icons.camera_alt_outlined))
//             : new CircleAvatar(backgroundImage: new FileImage(_image!), radius: 48.0,),
//       ),
//     );
//   }
// // Image.file(_image!, fit: BoxFit.cover)
//   void _submitForm() async {
//     if (!_formKey.currentState!.validate()) {
//       this._btnSubmitController.error();
//       Timer(Duration(seconds: 1), () {
//         this._btnSubmitController.reset();
//       });
//       return;
//     }
//
//     // get deviceId
//     final deviceId = await DeviceId.instance.getId();
//     print("device id: $deviceId");
//
//     final dataRegister = <String, dynamic>{
//       "email": this.inputEmailCtrler.text.trim(),
//       "password": this.inputPasswordCtrler.text,
//       "username": this.inputNameCtrler.text,
//       "prefix" : "${Config.defaultInstance().prefixConfig}"
//     };
//
//     print("prefixConfig: ${Config.defaultInstance().prefixConfig}");
//
//     setState(() {
//       _isLoading = true;
//       _errorMsg = null;
//     });
//
//     registerUser(dataRegister).then((value) {
//       print("register user success");
//       showSnackBarSuccess(context,'仮登録が完了しました。メールにご確認した上で、本登録を行ってください。メールが届いていない場合は、迷惑フォルダーをご確認してください。');
//       this._btnSubmitController.success();
//       Timer(Duration(seconds: 1), () {
//         this._btnSubmitController.reset();
//         Navigator.pop(context);
//       });
//     }).catchError((error, stackTrace) {
//       print("register failed $error $stackTrace");
//       this._btnSubmitController.error();
//       Timer(Duration(seconds: 1), () {
//         this._btnSubmitController.reset();
//       });
//       setState(() {
//         _errorMsg = error?.message;
//       });
//     }).whenComplete(() {
//       setState(() {
//         _isLoading = false;
//       });
//     });
//   }
// //Give me pick image form local Device In Flutter
//
//
//   Widget _inputNickName() {
//     return Container(
//         child: TextFormField(
//           controller: inputNameCtrler,
//           textAlign: TextAlign.left,
//           decoration: getInputDecoration(),
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               setState(() {
//                 _errorMsg = '';
//               });
//               return 'ニックネームを入力してください。';
//             }
//             if (value.length > 30) {
//               setState(() {
//                 _errorMsg = '';
//               });
//               return 'ニックネームは30文字以内で入力してください。';
//             }
//             return null;
//           },
//           style: TextStyle(color: Colors.black),
//         )
//     );
//   }
//
//   Widget _inputEmail() {
//     return Container(
//         child: TextFormField(
//           controller: inputEmailCtrler,
//           decoration: getInputDecoration(),
//           // decoration: getInputDecoration(),
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               setState(() {
//                 _errorMsg = '';
//               });
//               return "メールアドレス" + _i10n().msg_field_cannot_empty;
//             }
//             RegExp regExp = new RegExp(regexEmailPatten);
//             if (!regExp.hasMatch(value)) {
//               setState(() {
//                 _errorMsg = '';
//               });
//               return 'フォーマットが不正なメールアドレスです。';
//             }
//             return null;
//           },
//           style: TextStyle(color: Colors.black),
//         )
//     );
//   }
//
//   Widget _inputPassword() {
//     return Container(
//         child: TextFormField(
//           controller: inputPasswordCtrler,
//           obscureText: true,
//           decoration: getInputDecoration(),
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               setState(() {
//                 _errorMsg = '';
//               });
//               return '現在のパスワードを入力してください。';
//             }
//             RegExp regExp = new RegExp(regexPasswordPatten);
//             if (!regExp.hasMatch(value)) {
//               setState(() {
//                 _errorMsg = '';
//               });
//               return 'パスワードは６文字以上入力してください。';
//             }
//             return null;
//           },
//           style: TextStyle(color: Colors.black),
//         )
//     );
//   }
//
//   Widget _inputRePassword() {
//     return Container(
//         child: TextFormField(
//           controller: inputRePasswordCtrler,
//           obscureText: true,
//           decoration: getInputDecoration(),
//           validator: (value) {
//             if (value == null || value.toString().isEmpty) {
//               setState(() {
//                 _errorMsg = '';
//               });
//               return "パスワード（確認）を入力してください。";
//             }
//             if (value != inputPasswordCtrler.text) {
//               setState(() {
//                 _errorMsg = '';
//               });
//               return 'パスワードとパスワード(確認)が一致しません。';
//             }
//             return null;
//           },
//           style: TextStyle(color: Colors.black),
//         )
//     );
//   }
//
//   Widget _buildAgreement() {
//     Color getColor(Set<MaterialState> states) {
//       const Set<MaterialState> interactiveStates = <MaterialState>{
//         MaterialState.pressed,
//         MaterialState.hovered,
//         MaterialState.focused,
//       };
//       if (states.any(interactiveStates.contains)) {
//         return Color(0xffA5A5A5);
//       }
//       return Color(0xffA5A5A5);
//     }
//
//     const styleTextLink = TextStyle(
//       color: Color(0xff95C1E7)
//     );
//
//     return  Row(
//       children: [
//         CustomCheckbox(
//           onChange: (newValue) {
//             setState(() {
//               _isAgree = newValue!;
//             });
//           },
//           selectedColor: Color(0xff95C1E7),
//           colorTextTitle: Colors.black,
//           titleCheckBox: "利用規約に同意する",
//         ),
//       SizedBox(width: 10.h,),
//       RichText(
//         text: TextSpan(
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             children: [
//               TextSpan(
//                   text: "利用規約に同意する",
//                   style: styleTextLink,
//                   recognizer: TapGestureRecognizer()
//                     ..onTap = () => _openURL("https://heronavi.net/site/default/privacy-policy")),
//             ]),
//       )
//     ]);
//
//   }
//   void _openURL(String url) {
//     var encodedUrl = Uri.encodeFull(url);
//     _launchURL(encodedUrl);
//   }
//
//   void _launchURL(String url) async {
//     await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
//   }
//
//   Widget _buildForm() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           _inputSpace(),
//           _inputSpace(),
//           Text('ニックネーム', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xff51595C)),),
//           _inputSpace(),
//              _inputNickName(),
//           _inputSpace(),
//           Text('メールアドレス', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xff51595C)),),
//           _inputSpace(),
//              _inputEmail(),
//           _inputSpace(),
//           _inputSpace(),
//           // Text('プロフィール画像', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xff51595C)),),
//           // _inputSpace(),
//           // _profileImageContainer(),
//           // _inputSpace(),
//           Text('パスワード', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xff51595C)),),
//           _inputSpace(),
//              _inputPassword(),
//           _inputSpace(),
//           Text('確認パスワード', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xff51595C)),),
//           _inputSpace(),
//               _inputRePassword(),
//           _inputSpace(),
//           _inputSpace(),
//           ..._buildError(),
//              _buildAgreement(),
//           _inputSpace(),
//
//           Center(
//             child: Container(
//                 margin: EdgeInsets.only(top: 10.h),
//                 width: MediaQuery.of(context).size.width * .5,
//                 height: MediaQuery.of(context).size.height * .1 / 2 + 5,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                   color: _isAgree ? Color(0xff08BF5A) :Colors.grey,
//                 ),
//                 child: ElevatedButton(
//                     onPressed: _isAgree ? _submitForm : null,
//                     style: ElevatedButton.styleFrom(
//                       primary: _isAgree ? Color(0xff95C1E7) : Colors.grey,
//                     ),
//                     child: Text(
//                       '登録をする',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//                     )
//                 )
//             ),
//           ),
//           _inputSpace(),
//           // TextButton(
//           //   child: Text(_i10n().btnLogin, style: TextStyle(fontSize: 16, color: Color(0xff95C1E7), fontWeight: FontWeight.bold)),
//           //   onPressed: () {
//           //     Navigator.pop(context);
//           //   },
//           // ),
//         ],
//       ),
//     );
//   }
//
//   Widget _inputSpace() {
//     double inputSpaceHeight =  MediaQuery.of(context).size.width * .1 / 4;
//     return  SizedBox(
//       height: inputSpaceHeight,
//       // height: 8,
//     );
//   }
//
//   List<Widget> _buildError() {
//     if (_errorMsg?.isEmpty ?? true) {
//       return [];
//     }
//     return [
//       Text(_errorMsg ?? "", style: TextStyle(color: Colors.redAccent)),
//       _inputSpace(),
//     ];
//   }
//
//   Widget _buildMain() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .1 / 3,
//           vertical: MediaQuery.of(context).size.width * .1 / 2),
//       child: _buildForm(),
//     );
//   }
//
//
//   InputDecoration getInputDecoration(
//       {String hint = "", ImageIcon? prefixIcon}) {
//     return InputDecoration(
//         contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
//         prefixIcon: prefixIcon ?? null,
//         filled: true,
//         fillColor: Color(0xffFFFFFF),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Color(0xff000000), width: 1.0),
//         ),
//         border: OutlineInputBorder(
//           borderSide: const BorderSide(color: Color(0xff000000), width: 1.0),
//         ),
//
//         errorBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.red, width: 2.0),
//         ),
//         hintText: hint,
//         hintStyle: TextStyle(
//             color: Color(0xffC3C3C3), fontWeight: FontWeight.normal));
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     double sizeMediaHeight = MediaQuery.of(context).size.height;
//     final theme = Theme.of(context);
//     return GestureDetector(
//       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//       child: Scaffold(
//         appBar: AppBar(
//           systemOverlayStyle: SystemUiOverlayStyle(
//             statusBarColor: Color(0xff95C1E7), // <-- SEE HERE
//             statusBarIconBrightness: Brightness.light, //<-- For Android SEE HERE (dark icons)
//             statusBarBrightness: Brightness.dark, //<-- For iOS SEE HERE (dark icons)
//           ),
//           // toolbarHeight: 0,
//           // elevation: 0,
//           centerTitle: false,
//           titleSpacing: 0,
//           title: Text('アカウント登録' ?? '', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
//           leading: IconButton(
//               onPressed: (){
//                 Navigator.pop(context, true);
//               },
//               icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white)
//           ),
//         ),
//         body: SafeArea(
//             child: LoadingOverlay(
//               isLoading: _isLoading,
//               progressIndicator: LoadingAnimationWidget.staggeredDotsWave(color: theme.primaryColor, size: 40.0),
//               child: Container(
//                 color: Color(0xffFFFFFF),
//                 height: MediaQuery.of(context).size.height,
//                 padding: EdgeInsets.symmetric(
//                     horizontal: sizeMediaHeight * .1 / 10, vertical: 10),
//                 child: SingleChildScrollView(
//                     keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
//                         .onDrag,
//                     child: _buildMain()
//                 ),
//               ),
//             )),
//       ),
//     );
//   }
//
//   AppLocalizations _i10n() {
//     return AppLocalizations.of(context)!;
//   }
// }
