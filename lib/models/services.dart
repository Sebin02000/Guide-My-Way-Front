class ServicesResult {
  int? status;
  String? message;
  List<Data>? data;

  ServicesResult({this.status, this.message, this.data});

  ServicesResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  Loaction? loaction;
  String? iconUrl;
  String? name;
  double? rating;
  int? noOfRating;
  String? description;

  Data({this.loaction, this.iconUrl, this.name, this.rating, this.noOfRating});

  Data.fromJson(Map<String, dynamic> json) {
    print(json['rating']);
    loaction =
        json['loaction'] != null ? Loaction.fromJson(json['loaction']) : null;
    iconUrl = json['iconUrl'];
    name = json['name'];
    rating = json['rating'] + 0.00;

    noOfRating = json['noOfRating'];
    description = json['vicinity'] ?? " ";
  }
}

class Loaction {
  double? lat;
  double? lng;

  Loaction({this.lat, this.lng});

  Loaction.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}
