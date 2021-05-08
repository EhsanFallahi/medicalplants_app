import 'package:dio/dio.dart';
import 'package:medicinalplants_app/data/model/person/person.dart';

abstract class AbstractPersonRepository {
  Future<Response> addPerson(Person person);

  Future<Response> deletePerson(int id);

  Future<Response> getDesiredPerson(String  userName);

  Future<Response> getALlPerson();

  Future<Response> updatePerson(Person person);
}

class PersonRepository implements AbstractPersonRepository {
  Dio _dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:3000/', contentType: 'application/json'));

  @override
  Future<Response> addPerson(Person person) {
    return _dio.post('/person', data: person);
  }

  @override
  Future<Response> deletePerson(int id) {
    return _dio.delete('/person/$id');
  }

  @override
  Future<Response> updatePerson(Person person) {
    return _dio.put('/person/${person.id}', data: person);
  }

  @override
  Future<Response> getALlPerson() {
    return _dio.get('/person');
  }

  @override
  Future<Response> getDesiredPerson(String userName) {
    return _dio.get('/person/?user_name=$userName');
  }
}
