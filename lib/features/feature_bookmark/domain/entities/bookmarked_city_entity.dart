class BookmarkedCity {
  final String name;

  BookmarkedCity( this.name);

  Map<String, dynamic> toJson() => {'name': name};
  factory BookmarkedCity.fromJson(Map<String, dynamic> json) => BookmarkedCity( json['name']);
}