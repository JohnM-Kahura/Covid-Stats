import 'package:covid_stats/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/my_search_delegate.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List covidStats = [];
  List normalizeData(List data) {
    List response = [];
    for (int i = 0; i < 223; i++) {
      if (i != 222) {
        String covidStat = data[i] + '}';

        if (i == 0) {
          continue;
        }
        String finalStat = covidStat.substring(1);
        response.add(finalStat);
      }
      // print(response);
    }

    return response;
  }

  List decodeString(List data) {
    List response = [];
    for (int i = 0; i < data.length; i++) {
      Map responseMap = jsonDecode(data[i]);
      response.add(responseMap);
    }
    return response;
  }

  Future<List> loadData() async {
    String url =
        "https://vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com/api/npm-covid-data/";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Key': '3ff9cbf69emsh10c6c630b5afca9p18d8ddjsnde2553908383',
        'X-RapidAPI-Host':
            'vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com'
      },
    );
// we need to clean up the response so we can work with it
    String rmChar1 = response.body.substring(1);
// print(rm_char_1.length);
    String rmLastChar = rmChar1.substring(0, rmChar1.length - 1);
// print(rm_last_char);
// for
    List finalResponse = rmLastChar.split('}');
    // print(finalResponse[1]);
    List covidStatsList = normalizeData(finalResponse);
    print(covidStatsList[0]);
    List listWithDataMap = decodeString(covidStatsList);
    print(listWithDataMap[0].runtimeType);
    return listWithDataMap;
  }

  Future setData() async {
    List response = await loadData();
    setState(() {
      covidStats = response;
    });
  }

  @override
  void initState() {
    setData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 Stats'),
        elevation: 0,
        backgroundColor: Colors.purple,
        actions: [IconButton(onPressed: (){
          showSearch(context: context, delegate: MySearchDelegate());
        },icon: Icon(Icons.search),)],
      ),
      backgroundColor: Colors.grey,
      body: ListView.builder(
          itemCount: covidStats.length,
          itemBuilder: (BuildContext context, int index) {

            if (index == 0) {
              return Container(
                // color: Colors.white,
                // height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: const AssetImage('assets/world_image.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.6),
                        BlendMode.modulate,
                      )),
                ),
                child: Column(children: [
                  Text(
                    "Global Stats",
                    style: titleStyle,
                  ),
                  Row(
                    children: [
                      Text(
                        "Total Cases:",
                        style: bodyStyle,
                      ),
                      Text(covidStats[index]['TotalCases'].toString(), style: bodyStyle)
                    ],
                  ),
                  Row(
                    children: [
                      Text("New Cases:", style: bodyStyle),
                      Text(covidStats[index]['NewCases'].toString(), style: bodyStyle)
                    ],
                  ),
                  Row(
                    children: [
                      Text("New Deaths:", style: bodyStyle),
                      Text(covidStats[index]['NewDeaths'].toString(), style: bodyStyle)
                    ],
                  ),
                  Row(
                    children: [
                      Text("Total Deaths:", style: bodyStyle),
                      Text(covidStats[index]['TotalDeaths'].toString(), style: bodyStyle)
                    ],
                  ),
                  Row(
                    children: [
                      Text("Total Recovered :", style: bodyStyle),
                      Text(covidStats[index]['TotalRecovered'].toString(), style: bodyStyle)
                    ],
                  ),
                  Row(
                    children: [
                      Text("New Recovered :", style: bodyStyle),
                      Text(covidStats[index]['NewRecovered'].toString(), style: bodyStyle)
                    ],
                  ),
                ]),
              );
            }
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text('Confirmed',style: bodyStyle2,), Text(covidStats[index]['TotalCases'].toString())]),
                        ),
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text('Recovered',style: bodyStyle2,), Text(covidStats[index]['TotalRecovered'].toString())]),
                        ),
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text('Deaths',style: bodyStyle2,), Text(covidStats[index]['TotalDeaths'].toString())]),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0,right: 15),
                                  child: Text(covidStats[index]['Country'].toString(),style: TextStyle(color:Colors.white),),
                                ),
                                Icon(
                                  Icons.analytics_outlined,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
  
}

