import 'dart:math';

import 'package:movie_flutter/screens/models/country.dart';
import 'package:movie_flutter/screens/models/movie.dart';

class CountryRepository{

  Future<List<Country>> getCountries()async {
    List<Country> countries=[];

    countries.add(Country(1,"Canada"));
    countries.add(Country(2,"Australia"));
    return countries;
  }
}