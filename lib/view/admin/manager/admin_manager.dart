import 'package:flutter/material.dart';
import 'package:medicinalplants_app/controller/admin/admin_manager/admin_controller.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/widgets/text_form_field/confirm_passwordTxtFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/fullname_txtFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/password_txtFormField.dart';
import 'package:medicinalplants_app/widgets/text_form_field/username_txtFormField.dart';

class AdminManager extends StatelessWidget {
  AdminController _adminController = Get.put(AdminController());
  Person person;

  AdminManager({this.person});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.grey,
      centerTitle: true,
      elevation: 0,
      title: Text('admin_manager'.tr,
          style: TextStyle(
              fontFamily: 'MainFont',
              fontSize: 24,
              color: INPUT_TEXTFORM_COLOR)),
    );
    return Scaffold(
      appBar: appBar,
      body: Scaffold(
        body: Form(
          key: _adminController.formKeyRegisterAdmin,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FullNameTextFormField(
                  controller: _adminController.fullNameController,
                ),
                UserNameTextFormField(
                  controller: _adminController.userController,
                ),
                PasswordTextFormField(
                  controller: _adminController.passwordController,
                  changeDisplayPassword: _adminController.changeDisplayPassword,
                ),
                addAdminItem(),
                SizedBox(
                  height: 12,
                ),
                AdminListText(),
                listViewItem(context)
              ],
            ),
          ),
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
        child: Text(
          'add_admin'.tr,
        ),
        onPressed: () {
          if (_adminController.formKeyRegisterAdmin.currentState.validate()) {
            _adminController.registerAdmin();
          }
        });
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
        fontFamily: 'MainFont',
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
      child: allAdminsView(),
    );
  }

  Widget allAdminsView() {
    return Obx(
      () => _adminController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemCount: _adminController.allAdmins.length,
              separatorBuilder: (context, index) {
                return dividerOfListView();
              },
              key: UniqueKey(),
              itemBuilder: (context, i) => containerOfListTile(i),
            ),
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
      trailing: _adminController.allAdmins[i].fullName.contains('ehsanfallahi')
          ? Icon(Icons.account_box_rounded,color: Colors.green,)
          : deleteIconButton(i),
    );
  }

  Widget deleteIconButton(int i) {
    return IconButton(
      icon: Icon(Icons.delete_forever_rounded, color: BUTTON_RED_COLOR),
      onPressed: () {
        _adminController.deleteAdmin(_adminController.allAdmins[i].id);
      },
    );
  }

  Widget adminUserName(int i) {
    return Text(
      _adminController.allAdmins[i].fullName,
      style: textStyleOfAdminUserName(),
    );
  }

  TextStyle textStyleOfAdminUserName() {
    return TextStyle(
      fontFamily: 'FontFa',
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
