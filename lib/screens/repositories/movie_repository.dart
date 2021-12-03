import 'dart:convert';
import 'dart:math';

import 'package:movie_flutter/screens/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_flutter/screens/models/rental.dart';
class MovieRepository{

  Future<List<Movie>> getMovies(String country)async {
    List<Movie> movies=[];
    var res = await http.get(
        Uri.http("192.168.1.9:8080","v1/api/film/getFilmAll",{"country":country}),
          headers: {
          "Content-Type": "application/json",
          },
        );
    print(res.body);
        if (res.statusCode != 200) {
      return [];
    }
    else {
    var body = json.decode(utf8.decode(res.bodyBytes));

    for (var mov in body) {
    movies.add(Movie.fromJson(mov));
    }
    }
    return movies;
  }
  Future<List<Movie>> getMostRented2(String country)async {
    List<Movie> movies=[];
    var res = await http.get(
      Uri.http("192.168.1.9:8080","v1/api/film/getFilmMostRented",{"country":country}),
      headers: {
        "Content-Type": "application/json",
      },
    );
    print(res.body);
    if (res.statusCode != 200) {
      return [];
    }
    else {
      var body = json.decode(utf8.decode(res.bodyBytes));

      for (var mov in body) {
        movies.add(Movie.fromJson(mov));
      }
    }
    return movies;
  }
  Future<List<Movie>> getMostRented(country)async {
    List<Movie> movies=[];
    var res = await http.get(
      Uri.http("192.168.1.9:8080","v1/api/film/getFilmMostRented",{"country":country,"last_week":"true"}),
      headers: {
        "Content-Type": "application/json",
      },
    );
    print(res.body);
    if (res.statusCode != 200) {
      return [];
    }
    else {
      var body = json.decode(utf8.decode(res.bodyBytes));

      for (var mov in body) {
        movies.add(Movie.fromJson(mov));
      }
    }
    return movies;
  }
  Future<List<Movie>> searchMovie(String query)async {
    List<Movie> movies=[];
    var res = await http.get(
      Uri.http("192.168.1.9:8080","/v1/api/film/title/$query"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    print(res.body);
    if (res.statusCode != 200) {
      return [];
    }
    else {
      var body = json.decode(utf8.decode(res.bodyBytes));

      for (var mov in body) {
        movies.add(Movie.fromJson(mov));
      }
    }
    return movies;
  }
   rental(int filmId) async {
    DateTime date=DateTime.now();
    Rental rental=Rental(filmId, "${date.year}-${date.month.toString().padLeft(2,"0")}-${date.day.toString().padLeft(2,"0")}", 2, "${date.year}-${date.month.toString().padLeft(2,"0")}-${date.day.toString().padLeft(2,"0")}", 1);
    var res = await http.post(
      Uri.http("192.168.1.9:8080","/v1/api/customer/postRental"),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(rental.toJson())
    );
    print(res.body);
    if (res.statusCode != 200) {
      return false;
    }
    else {
      return true;
    }
  }
}