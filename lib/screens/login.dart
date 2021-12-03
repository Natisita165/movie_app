import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter/colors.dart';
import 'package:movie_flutter/screens/country_select.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user= TextEditingController();
  TextEditingController password= TextEditingController();
  Size size=const Size(1,1);
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.red,

      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg_image.jpg"),
                fit: BoxFit.cover
              )
            ),
          ),
          Container(color: Colors.black.withOpacity(0.7),height: size.height,width: size.width,),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      Text("Movie",style: TextStyle(color: colorWhite,fontWeight: FontWeight.w800,fontSize: 30),),

                      const SizedBox(
                        height: 100,
                      ),
                      input(Size(size.width*0.7,50), false,user,Icons.person,"Correo Electrónico"),
                      const SizedBox(
                        height: 25,
                      ),

                      input(Size(size.width*0.7,50), true,password,Icons.lock,"Contraseña"),
                      const SizedBox(
                        height: 25,
                      ),
                      MaterialButton(
                      color: color1,
                        elevation: 5,
                        child: Text("LOGIN",style: TextStyle(color: colorWhite,fontWeight: FontWeight.w600)),
                        height: 50,
                        minWidth: size.width*0.7,
                        onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountrySelect()));
                        },

                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text("¿No tienes una cuenta?",style: TextStyle(color: colorWhite,fontWeight: FontWeight.w800,fontSize: 16),),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Text("Registrate",style: TextStyle(color: colorWhite.withOpacity(0.7),fontWeight: FontWeight.w800,fontSize: 14),),
                      )
                    ],

                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget input(Size size, obscure,controller,icon,hint){
    return  Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5)
      ),
      child:TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
            counterText: "",
            prefixIcon: Icon(icon,color: colorWhite,),
            fillColor: color1,
            filled: false,
            focusColor: color1,
            contentPadding: const EdgeInsets.only(left: 10,right: 10),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: colorWhite,width: 1)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: colorWhite,width: 1)),
            hintText: hint,
            hintStyle: TextStyle(color: colorWhite.withOpacity(0.5)),
            border: OutlineInputBorder(borderSide: BorderSide(color: colorWhite,width: 1))),
            style: TextStyle(color: colorWhite,fontWeight: FontWeight.w600),
            cursorColor: colorWhite,
      ),
    );
  }
}
