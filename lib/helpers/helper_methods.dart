import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/api_keys.dart';
import 'package:uber_clone/datamodels/address.dart';
import 'package:uber_clone/dataproviders/app_data.dart';
import 'package:uber_clone/helpers/request_helper.dart';

class HelperMethods {
  static Future<String> findCordinateAddress(Position position, context) async {
    String placeAddress = '';

    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${ApiKeys.googleMapApiKey}';

    var response = await RequestHelper.getRequest(url);

    if (response != 'failed') {
      placeAddress = response['results'][0]['formatted_address'];

      Address pickUpAddress = Address(
        placeName: placeAddress,
        latitude: position.latitude,
        longitude: position.longitude,
        placeId: '',
        placeFormattedAddress: '',
      );

      Provider.of<AppData>(context, listen: false).updatePickupAddress(pickUpAddress);
    }

    return placeAddress;
  }
}
