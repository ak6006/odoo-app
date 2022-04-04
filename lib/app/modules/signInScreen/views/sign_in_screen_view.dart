// import 'package:elessam_services/app/modules/signInScreen/views/components/body.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:elessam_services/app/data/const.dart';
import 'package:elessam_services/app/modules/home/views/home_view.dart';
import 'package:elessam_services/app/modules/signInScreen/views/components/bezierContainer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../controllers/sign_in_screen_controller.dart';
import '../user_model.dart';

class SignInScreenView extends GetView<SignInScreenController> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  // final controller = SignInScreenController();

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    // prefs = await SharedPreferences.getInstance();

    Get.put(controller);
//  controller.prefs.asStream();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('SignIn'),
      //   // centerTitle: true,
      // ),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(height: 50),
                    _emailPasswordWidget(),
                    SizedBox(height: 20),
                    _submitButton(),
                    // Container(
                    //   padding: EdgeInsets.symmetric(vertical: 10),
                    //   alignment: Alignment.centerRight,
                    //   child: Text('Forgot Password ?',
                    //       style: TextStyle(
                    //           fontSize: 14, fontWeight: FontWeight.w500)),
                    // ),
                    // _divider(),
                    // _facebookButton(),
                    SizedBox(height: height * .055),
                    // _createAccountLabel(),
                  ],
                ),
              ),
            ),
            // Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController control,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              controller: control,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Obx(() => controller.isLoading.value
        ? const CircularProgressIndicator(
            color: Color.fromARGB(255, 247, 137, 43),
          )
        : InkWell(
            onTap: () async {
              controller.isLoading.value=true;
              // Get.put(controller);
              // var jj =userFromJson(jsonEncode(orpc.sessionId));
              // print(user.userId);

              //'a.alabyad@elessam.com', "ak654321\$"
              userpassword = passController.text;

              final log =
                  await login(emailController.text, passController.text);
              if (log) {
                //  prev_session = OdooSession.fromJson((prefs.read('sessionId')));
                user = (userFromJson)(jsonEncode(session));
                prefs.write('userid', emailController.text);
                prefs.write('userpassword', passController.text);
                print('logggggggggggggggggg');
                print(prev_session);
                final res = await getEmployeeData(user.userId);
                controller.isLoading.value=false;
                Get.offAll(() => HomeView());
              } else {
                controller.isLoading.value=false;
                Get.defaultDialog(
                    title: "خطاء في الوصول",
                    middleText: "بيانات الوصول غير صحيحة ",
                    backgroundColor: Color.fromARGB(255, 206, 160, 33),
                    titleStyle: TextStyle(color: Colors.white),
                    middleTextStyle: TextStyle(color: Colors.white),
                    radius: 30);
              }
              // try {
              //   session = await orpc.authenticate(
              //       'elessam-15',
              //       'a.alabyad@elessam.com',
              //       "ak654321\$"); // emailController.text, passController.text);
              //   uid = session.userId;
              //   await prefs.write('userid', emailController.text);
              //   await prefs.write('password', passController.text);
              //   Get.offAll(() => HomeView());
              // } catch (e) {
              //   Get.defaultDialog(
              //       title: "خطاء في الوصول",
              //       middleText: "بيانات الوصول غير صحيحة ",
              //       backgroundColor: Color.fromARGB(255, 206, 160, 33),
              //       titleStyle: TextStyle(color: Colors.white),
              //       middleTextStyle: TextStyle(color: Colors.white),
              //       radius: 30);

              //   print('bbbbbbbbbbbbbbb');
              //   print(e);
              //   print('Authenticated');
              // }
            },
            child: Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.shade200,
                        offset: Offset(2, 4),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xfffbb448), Color(0xfff7892b)])),
              child: Text(
                'دخول',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ));
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'مجموعة ',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
          children: [
            TextSpan(
              text: 'العصام ',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: '\n موارد بشرية',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("اسم المستخدم", emailController),
        _entryField("كلمة المرور", passController, isPassword: true),
      ],
    );
  }
}
