import 'package:flutter/material.dart';
import 'package:planets/core/api/crud.dart';
import 'package:provider/provider.dart';
import 'package:planets/core/api/crud.dart';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planets/core/viewmodels/model.dart';
import 'package:planets/ui/views/info/planet/new_planet.dart';

class ListEntitiesSpecificScreen<T extends CRUD> extends StatefulWidget {

  @override
  _ListEntitiesSpecificState createState() => _ListEntitiesSpecificState<T>();
}

class _ListEntitiesSpecificState<T extends CRUD> extends State<ListEntitiesSpecificScreen<T>> {

  TextEditingController editingController = TextEditingController();
  var items = List<Model>();
  var showingItems = List<Model>();

  @override
  Widget build(BuildContext context) {
    T provider = Provider.of<T>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (_) => EditPlanetScreen(planet: null)
          ));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg-list-entities-2.png'),
              fit: BoxFit.cover
          ),
        ),
        child: Column(
          children: <Widget>[
            AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0
            ),
            /*Text('Entidades', style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white
            )),*/
            buildSearchBar((s) {
              filterSearchResults(s.toLowerCase());
            }),
            Expanded(
              child: items.isNotEmpty ? buildList() : StreamBuilder(
                stream: provider.fetchAsStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    items = snapshot.data.documents
                        .map((doc) => provider.api.build(doc.documentID, doc.data))
                        .toList();
                    showingItems.clear();
                    showingItems.addAll(items);
                    return buildList();
                  }
                  return Text('fetching');
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar(Function(String) onChanged) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Material(
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: TextField(
            style: TextStyle(fontSize: 15),
            controller: editingController,
            onChanged: onChanged,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: 'Pesquisar',
                labelText: 'Pesquisar',
                prefixIcon: Icon(Icons.search, color: Colors.deepPurple,),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none
                )),
          )),
    );
  }

  Widget buildList() {
    if (showingItems.isNotEmpty) {
      return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 50),
          itemCount: showingItems.length,
          itemBuilder: (buildContext, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: buildButton(context, showingItems[index])
          )
      );
    } else {
      return Text('Empty');
    }
  }

  void filterSearchResults(String query) {
    if(query.isNotEmpty) {
      var dummyListData = List<Model>();
      items.forEach((item) {
        if (item.name.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        showingItems.clear();
        showingItems.addAll(dummyListData);
      });
    } else {
      setState(() {
        showingItems.clear();
        showingItems.addAll(items);
      });
    }
  }

  Widget buildButton(context, Model model) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        textColor: Colors.white,
        child: Container(
          constraints: BoxConstraints.expand(height: 80),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/button-search-planet.png'),
                fit: BoxFit.cover
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(right: 30),
            child: Align(
              child: Text(model.name, style: TextStyle(fontSize: 35)),
              alignment: Alignment.centerRight,
              heightFactor: 3.5,
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => model.getInfo()
          ));
        },
      ),
    );
  }
}
