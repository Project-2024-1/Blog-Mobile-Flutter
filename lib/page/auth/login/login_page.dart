// import 'dart:async';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:loading_overlay/loading_overlay.dart';
// import 'package:provider/provider.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import '../../../provider/home_tab/HomeTabNotifier.dart';
// import '../../../service/login_manager/LoginMangager.dart';
// import '../../../service/networking/apis/auth_api.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
//
// class _LoginPageState extends State<LoginPage> {
//
//   bool _isLoading = false;
//   final _formKey = GlobalKey<FormState>();
//   String? _errorMsg;
//   String? textCheckEmailError;
//
//   final inputUsernameCtrler = TextEditingController();
//   final inputPasswordCtrler = TextEditingController();
//
//   final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
//   @override
//   void initState() {
//     super.initState();
//     clearAllDataOld();
//   }
//
//   @override
//   void dispose() {
//     inputUsernameCtrler.dispose();
//     inputPasswordCtrler.dispose();
//     super.dispose();
//   }
//
//   Future<void> clearAllDataOld() async {
//     final preferences = await SharedPreferences.getInstance();
//     await preferences.clear();
//   }
//
//   void _submitForm() {
//     // Navigator.pushReplacementNamed(context, '/home');
//     if (!_formKey.currentState!.validate()) {
//       setState(() {
//         _errorMsg = null;
//         _btnController.reset();
//
//       });
//       return;
//     }
//     setState(() {
//       _isLoading = true;
//       _errorMsg = null;
//     });
//     print("call signIn api");
//     signIn(inputUsernameCtrler.text, inputPasswordCtrler.text)
//         .then((dataRet) async {
//       _btnController.success();
//       print("login success");
//
//       Timer(Duration(seconds: 1), () async {
//         setState(() {
//           this._isLoading = true;
//         });
//         await LoginManager.instance.handleFinishLogin(
//             role : dataRet['role'], userId: dataRet['user_id'],accessToken: dataRet['access_token'], userEmail: '${inputUsernameCtrler.text}').then((value) {
//           setState(() {
//             _isLoading = false;
//           });
//
//           final homeTabNotifier = context.read<HomeTabNotifier>();
//           homeTabNotifier.setTabIndex(0);
//           Navigator.pushReplacementNamed(context, '/home');
//         });
//       });
//       setState(() {
//         _isLoading = false;
//       });
//     }).catchError((error, stackTrace) async {
//       print("login failed $error, $stackTrace");
//       setState(() {
//         _isLoading = false;
//         _btnController.reset();
//       });
//       String msg = "";
//       try {
//         msg = (error as dynamic).message;
//       } on NoSuchMethodError {
//         msg = error.toString();
//       }
//       setState(() {
//         _errorMsg = msg;
//       });
//
//       // not active email address
//       if ((error as dynamic).errorCode != null && (error as dynamic).errorCode == 'not_active') {
//         String email = (error as dynamic).data['email'];
//
//         Navigator.pushReplacementNamed(context, '/auth/resend-verify-email', arguments: {'email': email});
//       }
//     });
//   }
//
//   Widget _buildMain() {
//     String text = 'メールが登録されていません。';
//     if(text == _errorMsg) {
//       textCheckEmailError = text;
//     }
//     else {
//       textCheckEmailError = '';
//     }
//
//     if(_errorMsg == 'メールが登録されていません。') {
//       _errorMsg = '';
//     }
//
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .1 / 2, vertical: MediaQuery.of(context).size.width * .4),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               color: Colors.white,
//               child: Center(
//                 child: Image.asset("assets/img/logo_app.png",
//                     height: MediaQuery.of(context).size.height * .1,
//                     width: MediaQuery.of(context).size.width * .6),
//               ),
//             ),
//             SizedBox(height: 20.h,),
//             Text(
//               'メールアドレス', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xff51595C)),
//             ),
//             SizedBox(height: 8.h,),
//             //Text FormField UserName
//             Container(
//               child: TextFormField(
//                 controller: inputUsernameCtrler,
//                 textAlign: TextAlign.start,
//                 decoration: getInputDecoration(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return _i10n().username + _i10n().msg_field_cannot_empty;
//                   }
//                 },
//                 style: TextStyle(color: Color(0xff51595C)),
//               ),
//             ),
//             SizedBox(height: 2.h,),
//             Text(
//               textCheckEmailError ?? "", style: TextStyle(color: Colors.redAccent), textAlign: TextAlign.center,
//             ),
//
//             SizedBox(
//               height: 10.h,
//             ),
//             //Text FormField Password
//             Text(
//               'パスワード',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                   color: Color(0xff51595C)),
//             ),
//             SizedBox(
//               height: 8.h,
//             ),
//             Container(
//               child: TextFormField(
//                 controller: inputPasswordCtrler,
//                 textAlign: TextAlign.start,
//                 obscureText: true,
//                 decoration: getInputDecoration(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return _i10n().msg_requiredPassword;
//                   }
//                   return null;
//                 },
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//             SizedBox(height: 2.h,),
//             Text(
//               _errorMsg ?? "", style: TextStyle(color: Colors.redAccent), textAlign: TextAlign.center,
//             ),
//
//             // Button Login
//             Center(
//               child: RoundedLoadingButton(
//                 color: Theme.of(context).primaryColor,
//                 successColor: Colors.greenAccent,
//                 controller: _btnController,
//                 onPressed: () => _submitForm(),
//                 valueColor: Colors.white,
//                 borderRadius: 10,
//                 child: Text('ログインする', style: TextStyle(color: Colors.white)),
//               ),
//             ),
//             SizedBox(height: 12.h,),
//             // register
//             /*
//             Center(
//               child: TextButton(
//                 onPressed:() {
//                   Navigator.pushNamed(context, '/auth/register');
//                 },
//                 child: Text(
//                   'アカウント登録', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xff95C1E7)),
//                 ),
//               ),
//             ),
//           */
//             Center(
//               child: InkWell(
//                 onTap: (){
//                   Navigator.pushNamed(context, '/auth/send-mail-forgot-password');
//                 },
//                 child: Container(
//                   child: Text(
//                     'パスワード忘れた場合', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xff95C1E7)),
//                   ),
//                 ),
//               ),
//
//
//             )
//           ],
//         ),
//       ),
//     );
//   }
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
//       // Thu Ban` Phim
//       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//       child: LoadingOverlay(
//         progressIndicator: LoadingAnimationWidget.staggeredDotsWave(color: theme.primaryColor, size: 40.0),
//         isLoading: _isLoading,
//         child: Scaffold(
//           appBar: AppBar(
//             systemOverlayStyle: SystemUiOverlayStyle(
//               statusBarColor: theme.primaryColor, // <-- SEE HERE
//               statusBarIconBrightness: Brightness.light, //<-- For Android SEE HERE (dark icons)
//               statusBarBrightness: Brightness.dark, //<-- For iOS SEE HERE (dark icons)
//             ),
//             toolbarHeight: 0,
//             elevation: 0,
//           ),
//           body: SafeArea(
//             child: Stack(
//               children: [
//                 Container(
//                   color: Color(0xffFFFFFF),
//                   height: MediaQuery.of(context).size.height,
//                   padding: EdgeInsets.symmetric(
//                       horizontal: sizeMediaHeight * .1 / 10, vertical: 10),
//                   child: SingleChildScrollView(
//                       keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
//                           .onDrag,
//                       child: _buildMain()
//                   ),
//                 ),
//
//               ],
//             )),
//         ),
//     ));
//   }
//
//   AppLocalizations _i10n() {
//     return AppLocalizations.of(context)!;
//   }
// }
//
