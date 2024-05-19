
class Ingredient {
  final String name;
  final String original;

  Ingredient({required this.name, required this.original});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      original: json['original'],
    );
  }
}