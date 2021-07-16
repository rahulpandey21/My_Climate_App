import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
import 'package:intl/intl.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  int sunrise;
  int sunset;
  int humidity;
  double maxTmp;
  double minTmp;
  double windSpeed;
  int pressure;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        sunset = 0;
        sunrise = 0;
        humidity = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        minTmp = 0;
        maxTmp = 0;
        pressure = 0;
        windSpeed = 0;

        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
      sunrise = weatherData['sys']['sunrise'];
      sunset = weatherData['sys']['sunset'];
      humidity = weatherData['main']['humidity'];
      maxTmp = weatherData['main']['temp_max'];
      minTmp = weatherData['main']['temp_min'];
      windSpeed = weatherData['wind']['speed'];
      pressure = weatherData['main']['pressure'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF9561a1), Color(0xFF122259)])),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    Text(
                      DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typedName != null) {
                          var weatherData =
                              await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    '$cityName',
                    textAlign: TextAlign.center,
                    style: kCityTextStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$temperature°',
                        textAlign: TextAlign.center,
                        style: kTempTextStyle,
                      ),
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 35.0),
                  child: Text(
                    '$weatherMessage in $cityName',
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
                FittedBox(
                  child: Padding(
                    padding: EdgeInsets.only(right: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            '  Max Temp: $maxTmp°C',
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(left: 30.0),
                          child: Text(
                            'Min Temp: $minTmp°C',
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FittedBox(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20.0),
                          color: Color(0xFFFFFFFF).withOpacity(0.1),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'images/sunrise.png',
                                height: 30.0,
                                width: 30.0,
                              ),
                              Text(
                                'Sunrise',
                                style: kWheatherTextStyle,
                              ),
                              Text(DateFormat('h:m a').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      sunrise * 1000))),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          color: Color(0xFFFFFFFF).withOpacity(0.1),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'images/sunset.png',
                                height: 30.0,
                                width: 30.0,
                              ),
                              Text(
                                'Sunset',
                                style: kWheatherTextStyle,
                              ),
                              Text(
                                DateFormat('h:m a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        sunset * 1000)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          color: Color(0xFFFFFFFF).withOpacity(0.1),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'images/humidity.png',
                                height: 30.0,
                                width: 30.0,
                              ),
                              Text(
                                'Humidity',
                                style: kWheatherTextStyle,
                              ),
                              Text('$humidity'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FittedBox(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20.0),
                          color: Color(0xFFFFFFFF).withOpacity(0.1),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'images/wind.png',
                                height: 30.0,
                                width: 30.0,
                              ),
                              Text(
                                'Wind Speed',
                                style: kWheatherTextStyle,
                              ),
                              Text('$windSpeed m/s'),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          color: Color(0xFFFFFFFF).withOpacity(0.1),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'images/pressure.png',
                                height: 30.0,
                                width: 30.0,
                              ),
                              Text(
                                'Pressure',
                                style: kWheatherTextStyle,
                              ),
                              Text('$pressure mbar'),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          color: Color(0xFFFFFFFF).withOpacity(0.1),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'images/info.png',
                                height: 30.0,
                                width: 30.0,
                              ),
                              Text(
                                'Language',
                                style: kWheatherTextStyle,
                              ),
                              Text('Flutter'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
