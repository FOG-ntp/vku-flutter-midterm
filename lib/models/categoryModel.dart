class Category {
  String? title;
  String? image;

  Category({required this.title, this.image});
}

List<Category> categories = [
  Category(title: "SOFAS", image: 'assets/c_images/sofa.png'),
  Category(title: "TABLES", image: 'assets/c_images/side-table.png'),
  Category(title: "CHAIRS", image: 'assets/c_images/chair.png'),
  Category(title: "LAMPS", image: 'assets/c_images/table-lamp.png'),
  Category(title: "BEDS", image: 'assets/c_images/bed.png'),
];
