class ScanData {
  ScanData(
      {required this.id,
      required this.name,
      required this.price,
      required this.detail,
      required this.barcode,
      required this.amount,
      required this.category,
      required this.brandName,
      required this.sku,
      required this.other,
      required this.color,
      required this.material,
      required this.size,
      required this.imgUrl,
      required this.imgUrls});

  late int id;
  late String name;
  late int price;
  late String detail;
  late String barcode;
  late int amount;
  late String category;
  late String imgUrl;
  late String brandName;
  late String sku;
  late String color;
  late String size;
  late String material;
  late String other;
  late List imgUrls;

  factory ScanData.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final id = data['id'] as int;
    final price = data['price'] as int;
    final detail = data['detail'] as String;
    final barcode = data['barcode'] as String;
    final amount = data['amount'] as int;
    final category = data['category'] as String;
    final sku = data['sku'] as String;
    final material = data['material'] as String;
    final imgUrl = data['img_url'] as String;
    final color = data['color'] as String;
    final size = data['size'] as String;
    final other = data['other'] as String;
    final brandName = data['brandName'] as String;
    final imgUrls = data['img_urls'] as List;

    return ScanData(
      id: id,
      name: name,
      price: price,
      detail: detail,
      barcode: barcode,
      amount: amount,
      category: category,
      imgUrl: imgUrl,
      sku: sku,
      imgUrls: imgUrls,
      brandName: brandName,
      color: color,
      material: material,
      size: size,
      other: other,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['detail'] = detail;
    data['barcode'] = barcode;
    data['amount'] = amount;
    data['category'] = category;
    data['imgUrl'] = imgUrl;
    data['brandName'] = brandName;
    data['imgUrls'] = imgUrls;
    data['sku'] = sku;
    data['color'] = color;
    data['size'] = size;
    data['material'] = material;
    data['other'] = other;
    return data;
  }
}
