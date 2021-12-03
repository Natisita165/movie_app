import 'dart:math';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_flutter/colors.dart';
import 'package:movie_flutter/screens/models/movie.dart';
import 'package:movie_flutter/screens/repositories/movie_repository.dart';

class Movies extends StatefulWidget {
  const Movies({Key? key, required this.country}) : super(key: key);
  final String country;
  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  Size size=const Size(1,1);
  TextEditingController search=TextEditingController();
  bool isSearch=false;
  List<Movie> list1=[];
  List<Movie> list2=[];
  List<Movie> list3=[];
  List<Movie> listSearch=[];
  @override
  void initState() {
    super.initState();
    getMovies();
  }
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color3,
      appBar: AppBar(
        backgroundColor: color3,
        elevation: 5,
        title: isSearch?input(search):const Text("Movie"),

        actions: [
          IconButton(icon:isSearch?const Icon(Icons.cancel):const Icon(Icons.search),color: isSearch?color1:colorWhite, onPressed: () {
            search.text="";
            setState(() {
              listSearch=[];
              isSearch=!isSearch;
            });
          },)
        ],

      ),
      body: !isSearch?ContainedTabBarView(


          tabs: const [
            Text('Estrenos'),
            Text('Semanal'),
            Text('De Todos los tiempos'),
          ],

          tabBarProperties: TabBarProperties(


            width: size.width,
            height: 50,
            background: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0),
                    spreadRadius: 0.5,
                    blurRadius: 2,
                    offset: Offset(1, -1),
                  ),
                ],
              ),
            ),
            indicatorColor: color1,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[400],
          ),
          views: [
            Container(
              child: list(list1),
            ),
            Container(
              child: list(list2),
            ),
            Container(
              child: list(list3),
            ),
          ],
          onChange: (index) => print(index),
        ):
      Container(
        child: list(listSearch),
      ),
    );
  }
  getMovies()async {
    MovieRepository movieRepository=MovieRepository();
    var listAux1=await movieRepository.getMovies(widget.country);
    var listAux2=await movieRepository.getMostRented(widget.country);
    var listAux3=await movieRepository.getMostRented2(widget.country);
    setState((){
      list1=listAux1;
      list2=listAux2;
      list3=listAux3;
    });
  }
  searchMovie(String query)async{
    MovieRepository movieRepository=MovieRepository();
    var listAux1=await movieRepository.searchMovie(query);

    setState((){
      listSearch=listAux1;
    });
  }
  Widget list(List<Movie> movies){
    return GridView.count(
      crossAxisCount: 3,
        childAspectRatio: ((size.width/3) / 170),
      children: movies.map((Movie m) {
        return
          GestureDetector(
            onTap:(){
              showDialog(context: context, builder: (context){
                return AlertDialog(

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  contentPadding: EdgeInsets.all(0),
                  content: Container(
                    height: size.height*0.5,
                    decoration: BoxDecoration(image:
                    DecorationImage(
                        image: NetworkImage(m.image),
                        fit: BoxFit.cover
                    ),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          color: color3.withOpacity(0.7),
                          width: size.width,
                          padding: EdgeInsets.all(5),
                          child: Column(
                            children: [

                              Row(
                                children: [
                                  Text(m.title,style: TextStyle(color: colorWhite),),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(m.releaseYear.toString(),style: TextStyle(color: colorWhite),),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(m.description,style: TextStyle(color: colorWhite),textAlign: TextAlign.justify,),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MaterialButton(
                                    onPressed: ()async {
                                      MovieRepository mr=MovieRepository();
                                      var res=await mr.rental(m.filmId);
                                      if(res){
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(
                                            msg: "Se Rentó la película",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black.withOpacity(0.7),
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }
                                      else{

                                        Fluttertoast.showToast(
                                            msg: "No se pudo rentar.",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black.withOpacity(0.7),
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }
                                    },
                                    color: color1,
                                    height: 40,
                                    minWidth: 30,
                                    child: Row(
                                      children: [
                                        Text("Rentar  ",style:TextStyle(color:colorWhite)),
                                        Icon(Icons.shopping_cart,color:colorWhite)
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
          },
            child: Container(
              decoration: BoxDecoration(image:
              DecorationImage(
                  image: NetworkImage(m.image),
                  fit: BoxFit.cover
              )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: color3.withOpacity(0.7),
                    width: size.width,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: [

                        Text(m.title,style: TextStyle(color: colorWhite),),
                        Text(m.releaseYear.toString(),style: TextStyle(color: colorWhite),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
      }).toList()
    );
  }
  Widget input(controller){
    return  Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5)
      ),
      child:TextField(
        onSubmitted: (String query){
          searchMovie(query);
        },
        controller: controller,
        decoration: InputDecoration(
            counterText: "",
            fillColor: color1,
            filled: false,
            focusColor: color1,
            contentPadding: const EdgeInsets.only(left: 10,right: 10),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent,width: 1)),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent,width: 1)),
            hintText: "Busqueda de películas",
            hintStyle: TextStyle(color: colorWhite.withOpacity(0.5)),
            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent,width: 1))),
        style: TextStyle(color: colorWhite,fontWeight: FontWeight.w600),
        cursorColor: colorWhite,
      ),
    );
  }
}
