class PlacesSearch {
  // name,id
  String name;
  String id;
  PlacesSearch({required this.name, required this.id});
}

List<PlacesSearch> placeSearchFromJson(Map<String, dynamic> json) {
  // name = json['name'];
  // id = json['id'];
  List<PlacesSearch> result = [];
  json["predictions"].forEach((v) {
    result.add(PlacesSearch(name: v["description"], id: v["place_id"]));
  });
  result.toList();
  return result;
}
