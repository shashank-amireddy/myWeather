
import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var cityName = [
      "Hyderabad",
      "Bengaluru",
      "Mumbai",
      "Pune",
      "Delhi",
      "Kolkata"
    ];
    final _random = new Random();
    var city = cityName[_random.nextInt(cityName.length)];
    Map<dynamic, dynamic> info =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    String icon = info['icon_value'];
    String location = info['place_value'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue,Colors.blue.shade200]
              )
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Container(
          //main
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue.shade700, Colors.blue.shade300])),
          child: Column(
            children: [
              Container(
                // search bar
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                //color: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if((searchController.text).replaceAll(" ", "")==""){
                          print("blank search");
                        }else {
                          Navigator.pushReplacementNamed(context, "/loading", arguments: {
                            "searchText": searchController.text,
                          });
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.fromLTRB(2, 0, 7, 0),
                          child: Icon(Icons.search, color: Colors.blueAccent)),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Try searching $city",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Image.network("https://openweathermap.org/img/wn/$icon@2x.png"),
                          SizedBox(width: 50),
                          Column(
                            children: [
                              Text(info['main_value'], style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                              ),),
                              Text("in $location",style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 195,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      padding: EdgeInsets.all(26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(WeatherIcons.thermometer),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(info['temp_value'],style: GoogleFonts.lato(
                                fontSize: 90,
                              ),),
                              Text("°C",style: TextStyle(
                                  fontSize: 40
                              ),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin: EdgeInsets.fromLTRB(25, 0, 10, 0),
                      padding: EdgeInsets.all(26),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.day_windy,size:30),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(info['speed_value'],style: TextStyle(
                              fontSize: 40,
                            fontWeight: FontWeight.bold
                          ),),
                          Text("Km/hr")
                        ],
                      ),
                      height: 200,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin: EdgeInsets.fromLTRB(10, 0, 25, 0),
                      padding: EdgeInsets.all(26),
                      height: 200,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.humidity, size:30),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(info['hum_value'],style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold
                          ),),
                          Text("Percent")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 138),
              Container(
                padding: EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Made by Shashank")
                      ],
                  ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
