import 'package:flutter/material.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/widgets/text_form_field/confirm_passwordTxtFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/password_txtFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/username_txtFormField.dart';
class AdminManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.grey,
      centerTitle: true,
      elevation: 0,
      title: Text('add_product'.tr,
          style: TextStyle(
              fontFamily: 'MainFont',
              fontSize: 24,
              color: INPUT_TEXTFORM_COLOR)),
      // leading: buttonCancelAppBar(),
      // actions: [saveButtonAppBar()],
    );
    return Scaffold(
      appBar: appBar,
      body: Scaffold(
        body:Column(
          children: [
            UserNameTextFormField(),
            PasswordTextFormField(),
            ConfirmPasswordTextFormField(),
            addAdminItem(),
            SizedBox(
              height: 12,
            ),
            AdminListText(),
            listViewItem(context)
          ],
        ),
      ),
    );
  }
  Widget addAdminItem() {
    return SizedBox(
      height: 40,
      width: 140,
      child: AddAdminButton(),
    );
  }

  Widget AddAdminButton() {
    return ElevatedButton(
      child: Text('add_admin'.tr,),

        // bg_color: SECONDARY_COLOR,
        // txt_color: WHITE_COLOR,
        // btn_icon: Icons.group_add_rounded,
        onPressed: () {
          // if (_loginController.formKeyRegisterAdmin.currentState.validate()) {
          //   _loginController.registerAdmin();
          }
        );
  }
  Widget AdminListText() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        'admin_list'.tr,
        style: textStyleOfAdminListText(),
      ),
    );
  }

  TextStyle textStyleOfAdminListText() {
    return TextStyle(
        fontSize: 21,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        letterSpacing: 2);
  }
  Widget listViewItem(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: containerOfAdminListView(context),
    );
  }

  Widget containerOfAdminListView(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: adminListView(),
    );
  }

  Widget adminListView() {
    return
      // Obx(
      //     () => _loginController.isLoading.value
      //     ? Center(
      //   child: CircularProgressIndicator(),
      // )
      //     :
          ListView.separated(
        itemCount: 2,
        separatorBuilder: (context, index) {
          return dividerOfListView();
        },
        key: UniqueKey(),
        itemBuilder: (context, i) => containerOfListTile(i),
      // ),
    );
  }

  Widget containerOfListTile(int i) {
    return Container(
      child: listTile(i),
    );
  }

  Widget listTile(int i) {
    return ListTile(
      title: adminUserName(i),
      trailing:
      // _loginController.adminList[i].userName.contains('ehsanfallahi')
          // ?
      Icon(Icons.account_box_rounded)
          // : deleteIconButton(i),
    );
  }

  Widget deleteIconButton(int i) {
    return IconButton(
      icon: Icon(Icons.delete_forever_rounded, color: Colors.green),
      onPressed: () {
        // _loginController.deleteAdmin(_loginController.adminList[i].id);
      },
    );
  }

  Widget adminUserName(int i) {
    return Text('admin',
      // _loginController.adminList[i].userName,
      style: textStyleOfAdminUserName(),
    );
  }

  TextStyle textStyleOfAdminUserName() {
    return TextStyle(
      fontSize: 16,
      color: Colors.green,
      fontWeight: FontWeight.w500,
      letterSpacing: 1,
    );
  }

  Widget dividerOfListView() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Divider(
        color: Colors.black,
      ),
    );
  }
}
