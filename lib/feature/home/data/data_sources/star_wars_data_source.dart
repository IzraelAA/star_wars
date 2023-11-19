import 'package:injectable/injectable.dart';
import 'package:star_wars/core/network/api_url.dart';
import 'package:star_wars/core/network/network_module.dart';
import 'package:star_wars/core/network/parser_json.dart';
import 'package:star_wars/feature/home/domain/entities/people_model.dart';
import 'package:star_wars/feature/home/domain/entities/planet_model.dart';
import 'package:star_wars/feature/home/domain/entities/transportation_model.dart';
import 'package:star_wars/feature/home/domain/use_cases/get_people.dart';

abstract class StarWarsDataSource {
  Future<ParserJson<List<PeopleModel>>> getPeopleData(
      ParamsPeople paramsPeople);

  Future<TransportationModel> getTransportation(String endpoint);

  Future<PlanetModel> getHomeWorld(String endpoint);
}

@Injectable(as: StarWarsDataSource)
class StarWarsDatSourceImpl extends NetworkModule
    implements StarWarsDataSource {
  @override
  Future<ParserJson<List<PeopleModel>>> getPeopleData(
      ParamsPeople paramsPeople) async {
    final response = await getMethod(
      "${Endpoint.people}?search=${paramsPeople.name}&page=${paramsPeople.next}",
      headers: {"Content-Type": "application/json"},
    );
    final responseBody = responseHandler(response);
    final data = ParserJson.fromJson(responseBody, (data) {
      List<PeopleModel> result =
          List.from(data.map((v) => PeopleModel.fromJson(v)).toList());

      return result;
    });
    return data;
  }

  @override
  Future<TransportationModel> getTransportation(String endpoint) async {
    final response = await getMethod(
      endpoint,
      headers: {"Content-Type": "application/json"},
    );
    final responseBody = responseHandler(response);
    return TransportationModel.fromJson(responseBody);
  }

  @override
  Future<PlanetModel> getHomeWorld(String endpoint) async {
    final response = await getMethod(
      endpoint,
      headers: {"Content-Type": "application/json"},
    );
    final responseBody = responseHandler(response);
    return PlanetModel.fromJson(responseBody);
  }
}
