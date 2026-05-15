import 'package:hive/hive.dart';

part 'favorite.g.dart';

@HiveType(typeId: 0)
class Favorite extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String imageUrl;
  @HiveField(3)
  String summary;
  @HiveField(4)
  List<String> genre;
  @HiveField(5)
  String rating;
  Favorite({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.summary,
    required this.genre,
    required this.rating,
  });
}