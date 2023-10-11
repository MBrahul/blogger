// ignore_for_file: non_constant_identifier_names

class BlogModel {
  final String title;
  final String image_url;
  // final String id;

  BlogModel(this.title, this.image_url);

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "image_url": image_url,
    };
  }
}
