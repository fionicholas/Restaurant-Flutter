class MenuItem {
  MenuItem({
    required this.name,
  });

  String name;

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

