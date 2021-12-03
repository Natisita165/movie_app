import 'package:flutter/material.dart';
import 'package:movie_flutter/colors.dart';
import 'package:movie_flutter/screens/models/country.dart';
import 'package:movie_flutter/screens/movies.dart';
import 'package:movie_flutter/screens/repositories/country_repository.dart';

class CountrySelect extends StatefulWidget {
  const CountrySelect({Key? key}) : super(key: key);

  @override
  _CountrySelectState createState() => _CountrySelectState();
}

class _CountrySelectState extends State<CountrySelect> {
  Size size=const Size(1,1);
  List<Country> countries=[];
  @override
  void initState() {
    getCountries();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color3,
      body: Stack(
        children: [

          Positioned(
            top: MediaQuery.of(context).padding.top+10,
            left: 20,
              child:
          Text("Movie",style: TextStyle(color: colorWhite,fontSize: 30,fontWeight: FontWeight.w600),)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listCountries()
          )
        ],
      )
    );
  }
  getCountries()async{
    CountryRepository countryRepository=CountryRepository();
    var list=await countryRepository.getCountries();
    setState(() {
      countries=list;
    });
  }
  List<Widget> listCountries(){
    List<Widget> widgets=[];
    widgets.add(
      Padding(padding: EdgeInsets.symmetric(horizontal: size.width*0.1),
        child:
        Text("Por favor seleccione el pais en el que desea comprar: ",
          style: TextStyle(color: colorWhite.withOpacity(0.8),fontSize: 20,fontWeight: FontWeight.w600),),
      ),);
    widgets.add(
      const SizedBox(height: 50,)
    );
    for(var country in countries){
      widgets.add(
        MaterialButton(
            onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>Movies(country:country.country,)));
            },
            padding: const EdgeInsets.all(0),

            color: colorWhite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network("http://www.geognos.com/api/en/countries/flag/${country.country.toUpperCase().substring(0,2)}.png",width: size.width*0.3),

                Text(country.country,
                  style: TextStyle(color: color3.withOpacity(0.8),fontSize: 20,fontWeight: FontWeight.w600),),
                const SizedBox(height: 10,),
              ],
            )
        ),
      );
      widgets.add(
          const SizedBox(height: 50,)
      );
    }
    return widgets;
  }
}
