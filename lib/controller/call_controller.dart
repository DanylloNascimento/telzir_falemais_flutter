import 'package:falemais_app_flutter/model/call_model.dart';

class CallController {
  Call call;

  double tariffValue(origin, destiny) {
    if (origin == "011" && destiny == "016") {
      return 1.90;
    } else if (origin == "016" && destiny == "011") {
      return 2.90;
    } else if (origin == "011" && destiny == "017") {
      return 1.70;
    } else if (origin == "017" && destiny == "011") {
      return 2.70;
    } else if (origin == "011" && destiny == "018") {
      return 0.90;
    } else if (origin == "018" && destiny == "011") {
      return 1.90;
    }
    return 0.0;
  }

  double callPlan(double tariff, int time, int plan) {
    var timeResid = time > plan ? time - plan : plan - time;
    var result = timeResid * tariff;
    var porcent = ((10 / 100) * result);
    result = porcent + result;
    if (plan == 0) {
      return result = tariff * time;
    } else if (plan == 30) {
      return time <= plan ? 0.0 : result;
    } else if (plan == 60) {
      return time <= plan ? 0.0 : result;
    } else if (plan == 120) {
      return time <= plan ? 0.0 : result;
    }
  }

  double callNoPlan(double tariff, int time) {
    return tariff * time;
  }
}
