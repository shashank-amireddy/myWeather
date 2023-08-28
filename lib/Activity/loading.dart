import 'package:flutter/material.dart';
import 'package:my_weather/Worker/worker.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
 late String temp;
 late String hum;
 late String speed;
 late String des;
 late String main;
 late String icon;
 late String place;
 late String S1 ;
  void start() async {
    final worker = Worker(S1);
    await worker.loadWeatherData();
    temp = worker.temp;
    hum = worker.humidity;
    speed = worker.airSpeed;
    des = worker.description;
    main =  worker.main;
    icon = worker.icon;
    place = worker.locat;
    Future.delayed(Duration(seconds: 2),() {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value" : temp,
        "hum_value" : hum,
        "speed_value" : speed,
        "des_value" : des,
        "main_value" : main,
        "icon_value": icon,
        'place_value': place
    });


    });
  }

  @override
  void initState() {
    super.initState();

  }
  Widget build(BuildContext context) {
    //Map<dynamic, dynamic>? search = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    var arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is Map<dynamic, dynamic>) {
      Map<dynamic, dynamic> search = arguments;
      S1 = search['searchText'];
      start();
    } else {
     S1 = "Hyderabad";
     start();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Image.asset('images/weather-app.png',height: 180,width: 180),
              Text("ClearSky",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),),


              SizedBox(height: 15),
              Image.asset('images/loading.gif'),
              Text("Made with ❤️ by Shashank",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                ),),

            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue[300],
    );
  }
}
