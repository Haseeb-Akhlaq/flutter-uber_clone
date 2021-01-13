import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber_clone/helpers/requestHelper.dart';

class HelperMethods {
  static Future<String> findCoordinatesAddress(Position position) async {
    String placeAddress = '';

    bool deviceConnected = await DataConnectionChecker().hasConnection;

    if (deviceConnected == false) {
      return placeAddress;
    }

    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyBlf1eCOqsB6dc3TACj4ZVN_noBsR_PExo';

    final response = await RequestHelper.getRequest(url);

    print(response);
    if (response != 'failed') {
      placeAddress = response['results'][0]['formatted_address'];
    }
    return placeAddress;
  }
}
