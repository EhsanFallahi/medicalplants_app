import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/data/repository/person/person_repository.dart';
import 'package:medicinalplants_app/util/constant.dart';
import 'package:medicinalplants_app/view/user/dashboard/main_dashboard.dart';

class LoginController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> registerFormKey = GlobalKey();
  GlobalKey<FormState> loginFormKey = GlobalKey();

  PersonRepository _personRepository = PersonRepository();
  Person person = Person();
  RxBool isLoading = false.obs;
  RxBool isDisplayPassword = false.obs;

  void registerPerson() {
    isLoading(true);
    _personRepository.getDesiredPerson(userNameController.text).then((value) {
      if (validateStatusCode(value.statusCode)) {
        List<dynamic> response = value.data as List<dynamic>;
        response.isEmpty == true
            ? addPerson()
            : showSnackBar('user_existe', 'please_enter_another_userName',
                Colors.redAccent);
      } else {
        showSnackBar('network', 'network_error', Colors.redAccent);
      }
    });
    isLoading(false);
  }

  void loginPerson() {
    isLoading(true);
    _personRepository.getDesiredPerson(userNameController.text).then((value) {
      if (validateStatusCode(value.statusCode)) {
        List<dynamic> response = value.data as List<dynamic>;
        response.isNotEmpty == true
            ? determinToBeAdminOrUser(response)
            : showSnackBar('', 'user_not_found', Colors.redAccent);
      } else {
        showSnackBar('network', 'network_error', Colors.redAccent);
      }
    });
    isLoading(false);
  }

  bool isEqualPasswordAndConfirmPassword() =>
      passwordController.text.toLowerCase().trim() ==
              confirmPasswordController.text.toLowerCase().trim()
          ? true
          : false;

  void clearController() {
    fullNameController.text = '';
    userNameController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }

  void addPerson() {
    person = Person(
        fullName: fullNameController.text.trim(),
        userName: userNameController.text.trim(),
        password: passwordController.text.trim(),
        roll: Roll.User);
    _personRepository.addPerson(person).then((value) {
      if (validateStatusCode(value.statusCode)) {
        person = Person.fromJson(value.data);
        clearController();
        showSnackBar('register', 'you_are_registered', Colors.green);
        Get.off(()=>MainDashboard(person: person,),arguments: person);
      } else {
        showSnackBar('network', 'network_error', Colors.redAccent);
      }
    });
  }

  void determinToBeAdminOrUser(List<dynamic> response) {
    person = Person.fromJson(response[0]);
    isUser() == true
        ? loginUserAction()
        : isAdmin() == true
            ? loginAdminAction()
            : showSnackBar('', 'user_not_found', Colors.redAccent);
  }

  bool isUser() =>
      person.roll == Roll.User &&
      person.password == passwordController.text.trim();

  bool isAdmin() =>
      person.roll == Roll.Admin &&
      person.password == passwordController.text.trim();

  void loginUserAction() {
    clearController();
    Get.off(()=>MainDashboard(person: person,),arguments: person);
  }

  void loginAdminAction() {
    clearController();
    print('welcome admin');
  }
}
