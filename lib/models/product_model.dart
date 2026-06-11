class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
  });

  // تحويل من JSON إلى Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch,
      name: json['title'] ?? json['name'] ?? 'No Name',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl:
          json['image'] ??
          json['imageUrl'] ??
          'https://via.placeholder.com/150',
      description: json['description'] ?? 'No description available',
      category: json['category'] ?? 'General',
    );
  }

  // تحويل Product إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
    };
  }

  // نسخة جديدة مع تعديلات
  Product copyWith({
    int? id,
    String? name,
    double? price,
    String? imageUrl,
    String? description,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
