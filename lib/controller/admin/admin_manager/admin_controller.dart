import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';
import 'package:medicinalplants_app/data/repository/person/person_repository.dart';
import 'package:medicinalplants_app/util/constant.dart';

class AdminController extends GetxController {
  PersonRepository _personRepository = PersonRepository();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKeyRegisterAdmin = GlobalKey();
  RxBool isLoading = false.obs;
  Person person = Person();
  RxBool changeDisplayPassword = false.obs;
  List<Person> allPerson = [];
  List<Person> allAdmins = [];

  @override
  void onInit() {
    getAllAdmins();
    super.onInit();
  }

  void getAllAdmins() {
    allAdmins = [];
    isLoading(true);
    getAllPersonsAdmin();
  }

  Future<dynamic> getAllPersonsAdmin() {
    return _personRepository.getALlPerson().then((value) {
      if (validateStatusCode(value.statusCode)) {
        List<dynamic> response = value.data as List<dynamic>;
        response.forEach((element) {
          allAdmins.addIf(Person.fromJson(element).roll == Roll.Admin,
              Person.fromJson(element));
        });
      }
      isLoading(false);
    });
  }

  void registerAdmin() {
    isLoading(true);
    _personRepository
        .getDesiredPerson(userController.text.trim())
        .then((value) {
      if (validateStatusCode(value.statusCode)) {
        List<dynamic> response = value.data as List<dynamic>;
        if (response.isEmpty) {
          initialAdmin();
          addAdmin();
        } else {
          isLoading(false);
          showSnackBar(
              'user_existe', 'please_enter_another_userName', Colors.redAccent);
        }
      } else {
        print('network error!');
      }
      isLoading(false);
    });
  }

  Person initialAdmin() {
    return person = Person(
      fullName: fullNameController.text.trim(),
      password: passwordController.text.trim(),
      userName: userController.text.trim(),
      roll: Roll.Admin,
    );
  }

  Future<dynamic> addAdmin() {
    return _personRepository.addPerson(person).then((value) {
      if (validateStatusCode(value.statusCode)) {
        clearController();
        getAllAdmins();
      } else {
        print('netWork error');
      }
    });
  }

  void deleteAdmin(int id) {
    isLoading(true);
    _personRepository.deletePerson(id).then((value) {
      if (value.statusCode < 300 && value.statusCode > 199) {
        getAllAdmins();
      }
    });
  }

  void clearController() {
    fullNameController.text = '';
    userController.text = '';
    passwordController.text = '';
  }
}
