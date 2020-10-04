class HttpMethods {
  static const GET = 'GET';
  static const POST = 'POST';
  static const DELET = 'DELETE';
}

class GetStatus {

  Map<String, String> orderStatus = {
  "CREATED": "Created",
  "PARTIALLY_CONFIRMED": "Partially Confirmed",
  "CONFIRMED": "Confirmed",
  "DISPATCH_INITIATED": "Dispatch Initiated",
  "DISPATCHED": "Dispatched",
  "PARTIALLY_DELIVERED": "Partially Delivered",
  "DELIVERED": "Delivered",
  };

}