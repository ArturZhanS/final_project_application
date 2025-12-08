abstract class PaymentStrategy {
  String get name;
  String cardValidate(String umber, String cvv, double amount);
}

class VisaPaymentStrategy implements PaymentStrategy {
  @override
  String get name => "Visa";

  @override
  String cardValidate(String number, String cvv, double amount) {
    if (!number.startsWith('4')) {
      return "Visa payment declined: Card number must start with '4'.";
    }
    if (cvv.length != 3) {
      return "Visa payment declined: CVV must be 3 digits.";
    }
    if (number.length != 16) {
      return "Visa payment declined: Card number must be 16 digits.";
    }
    return "Successfully";
  }
}

class MasterCardPaymentStrategy implements PaymentStrategy {
  @override
  String get name => "MasterCard";

  @override
  String cardValidate(String number, String cvv, double amount) {
    if (!number.startsWith('5')) {
      return "MasterCard payment declined: Card number must start with '5'.";
    }
    if (cvv.length != 3) {
      return "MasterCard payment declined: CVV must be 3 digits.";
    }
    if (number.length != 16) {
      return "MasterCard payment declined: Card number must be 16 digits.";
    }
    return "Successfully";
  }
}

class KaspiGoldPaymentStrategy implements PaymentStrategy {
  @override
  String get name => "Kaspi Gold";

  @override
  String cardValidate(String number, String cvv, double amount) {
    if (!number.startsWith('4400')) {
      return "Kaspi Gold payment declined: Card number must start with '4400'.";
    }
    if (cvv.length != 3) {
      return "Kaspi Gold payment declined: CVV must be 3 digits.";
    }
    if (number.length != 16) {
      return "Kaspi Gold payment declined: Card number must be 16 digits.";
    }
    return "Successfully";
  }
}

class CheckOutFacade {
  Future<bool> processPayment(
    PaymentStrategy strategy,
    String num,
    String cvv,
    double amount,
  ) async {
    await Future.delayed(Duration(seconds: 1));

    String result = strategy.cardValidate(num, cvv, amount);

    if (result == "Successfully") {
      return true;
    } else {
      throw Exception(result);
    }
  }
}
