import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodie/model.dart';
import 'package:foodie/recipeview.dart';
import 'package:foodie/search.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();
  List recipeCatList = [
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1447078806655-40579c2520d6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3870&q=80",
      "heading": "Breakfast Recipes"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1447078806655-40579c2520d6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3870&q=80",
      "heading": "Lunch Recipes"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1447078806655-40579c2520d6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3870&q=80",
      "heading": "Dinner Recipes"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1447078806655-40579c2520d6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3870&q=80",
      "heading": "Salad Recipes"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1447078806655-40579c2520d6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3870&q=80",
      "heading": "Side-dish Recipes"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1447078806655-40579c2520d6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3870&q=80",
      "heading": "Dessert Recipes"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1447078806655-40579c2520d6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3870&q=80",
      "heading": "Snack Recipes"
    },
    {
      "imgUrl":
          "https://images.unsplash.com/photo-1447078806655-40579c2520d6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3870&q=80",
      "heading": "Soup Recipes"
    },
  ];

  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=9fb667c2&app_key=3a2b5dda472b8ddf71227bc3b9375c44";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    setState(() {
      data["hits"].forEach((elememt) {
        RecipeModel recipeModel = new RecipeModel(
            applabel: '', appcalories: 0.01, appImgurl: '', appurl: '');
        recipeModel = RecipeModel.fromMap(elememt["recipe"]);
        recipeList.add(recipeModel);
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipe("Food");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff126952),
            Color(0xff0e5441),
          ])),
        ),
        SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                margin: EdgeInsets.only(top: 160),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Trending Today",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Text("Delicious New Recipes",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 5),
                //    padding: EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: recipeCatList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Search(
                                        recipeCatList[index]["heading"])));
                          },
                          child: Card(
                            margin: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Image.network(
                                    recipeCatList[index]["imgUrl"],
                                    fit: BoxFit.cover,
                                    height: 250.0,
                                    width: 200,
                                  ),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black45
                                                    .withOpacity(0.25),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    0), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        child: Center(
                                            child: Text(
                                          recipeCatList[index]["heading"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )))),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: isLoading
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: recipeList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RecipeView(
                                            recipeList[index].appurl)));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0.0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        recipeList[index].appImgurl,
                                        fit: BoxFit.cover,
                                        height: 250.0,
                                        width: double.infinity,
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black45
                                                      .withOpacity(0.3),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      0), // changes position of shadow
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                              decoration: BoxDecoration(
                                                  color: Color(0xff199372)),
                                              child: Text(
                                                recipeList[index].applabel,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black45
                                                        .withOpacity(0.3),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        0), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 3, horizontal: 8),
                                                decoration: BoxDecoration(
                                                    color: Color(0xffdfc611)),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons
                                                        .local_fire_department),
                                                    Text(
                                                      recipeList[index]
                                                          .appcalories
                                                          .toStringAsFixed(0),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff126952),
              Color(0xff0e5441),
            ]),
            boxShadow: [
              BoxShadow(
                color: Colors.black45.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Container(
            // SearchBar Container
            padding: EdgeInsets.only(left: 25, right: 0, top: 3, bottom: 3),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white.withOpacity(0.7),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value){
                      if (((value).replaceAll(" ", ""))
                          .isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Search(value)));
                      }
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Let's Cook Something",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (((searchController.text).replaceAll(" ", ""))
                        .isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Search(searchController.text)));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff167e62),
                        borderRadius: BorderRadius.circular(30)),
                    margin: EdgeInsets.fromLTRB(10, 0, 6, 0),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
