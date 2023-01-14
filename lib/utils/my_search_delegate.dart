import 'package:covid_stats/constants/colors.dart';
import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate{
@override
Widget buildLeading(BuildContext context) => IconButton(onPressed: ()=>close(context, null),icon: const Icon(Icons.arrow_back ),);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        if(query.isEmpty){
          close(context,null);

        }else{
          query='';
        }
      }, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
return  Container(
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
                              children: [Text('Confirmed',style: bodyStyle2,), Text('339788')]),
                        ),
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text('Recovered',style: bodyStyle2,), Text('329652')]),
                        ),
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text('Deaths',style: bodyStyle2,), Text('5678')]),
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
                                  child: Text('Kenya',style: TextStyle(color:Colors.white),),
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
            );;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String > suggestions=[
      "Kenya",
      "China",
      "USA",
      "Japan"
    ];
  return ListView.builder(
    itemCount: suggestions.length,
    itemBuilder: (context, index) {
      final suggestion=suggestions[index];
      return ListTile(
        title: Text(suggestion),
        onTap: (){
          query=suggestion;
          showResults(context);
        },
      );
    },
  );
  }

}