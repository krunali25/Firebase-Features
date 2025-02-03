Cake cakeFromJson(dynamic str) => Cake.fromJson(str);

class Cake {
  String? id;
  String? title;
  String? difficulty;
  String? image;
  String? description; // Added description field
  String? portion; // Added portion field
  String? time; // Added time field
  List<String>? ingredients; // Added ingredients field
  List<Map<String,dynamic>> method; // Added method field

  Cake({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.image,
    this.description, // Made description optional
    this.portion, // Made portion optional
    this.time, // Made time optional
    this.ingredients, // Made ingredients optional
    required this.method, // Made method optional
  });

  factory Cake.fromJson(Map<String, dynamic> json) => Cake(
    id: json["id"],
    title: json["title"],
    difficulty: json["difficulty"],
    image: json["image"],
    description: json["description"], // Added description to fromJson
    portion: json["portion"], // Added portion to fromJson
    time: json["time"], // Added time to fromJson
    ingredients: json["ingredients"] != null
        ? List<String>.from(json["ingredients"].map((x) => x))
        : [], // Handling null ingredients
    method:json["ingredients"] != null
        ?  List<Map<String,dynamic>>.from(json["method"]):[], // Handling null method
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "difficulty": difficulty,
    "image": image,
    "description": description, // Added description to toJson
    "portion": portion, // Added portion to toJson
    "time": time, // Added time to toJson
    "ingredients": ingredients != null ? List<dynamic>.from(ingredients!.map((x) => x)) : [],
    "method": method != null ?List<dynamic>.from(method.map((x) => x)):[],
  };
}
