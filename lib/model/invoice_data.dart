class InvoiceData {
  InvoiceData({required this.name, required this.pdfUrl});

  late String name;
  late String pdfUrl;

  factory InvoiceData.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final pdfUrl = data['pdf_url'] as String;

    return InvoiceData(
      name: name,
      pdfUrl: pdfUrl,
    );
  }
}
