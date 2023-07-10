class NewsCategoryModel {
  final String? name;
  final String? description;
  final String? url;
  final String? category;
  final String? country;

  NewsCategoryModel({
    this.name,
    this.description,
    this.url,
    this.category,
    this.country,
  });

  factory NewsCategoryModel.fromJson(Map<String, dynamic> json) {
    return NewsCategoryModel(
      url: json["url"],
      description: json["description"],
      name: json["name"],
      country: json["country"],
      category: json["category"],
    );
  }
}
