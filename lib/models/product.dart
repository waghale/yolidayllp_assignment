class Product {
  final int id;
  final String title;
  final String image;
  final String description;
  final double price;

  Product({required this.id, required this.title, required this.image, required this.description, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      description: json['description'],
      price: json['price'].toDouble(),
    );
  }
}
