import 'dart:math';

class Movie{

  int filmId;
  String title;
  String description;
  int releaseYear;
  String image;

  Movie(this.filmId, this.title, this.description, this.releaseYear,this.image);

  Movie.fromJson(json):
        filmId=json["filmId"],
        title=json["title"],
        description=json["description"],
        releaseYear=json["releaseYear"],
        image="http://picsum.photos/200/${300+Random().nextInt(400-300)}";
}