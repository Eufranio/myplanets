import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planets/core/api/crud.dart';
import 'package:planets/core/viewmodels/model.dart';
import 'package:provider/provider.dart';
import 'package:planets/ui/widgets/image_button.dart';


class ListEntitiesSpecificScreen<T extends CRUD> extends StatefulWidget {

  ListEntitiesSpecificScreen({
    @required this.editScreen,
    this.childInfoFunction,
    this.buttonSize = 80,
    this.buttonImage = 'assets/bg-list-entities-2.png'
  });

  final double buttonSize;
  final Widget editScreen;
  final Function childInfoFunction;
  final String buttonImage;

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
              builder: (_) => widget.editScreen
          )).then((val) {
            setState(() {
              if (val != null)
                this.items.clear();
            });
          });
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
            AppBar(backgroundColor: Colors.transparent, elevation: 0),
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
                  return Text('Loading');
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
          itemBuilder: (buildContext, index) =>
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: ImageButton(
                      image: AssetImage(widget.buttonImage),
                      child: widget.childInfoFunction?.call(showingItems[index]) ?? Text(showingItems[index].name, style: TextStyle(fontSize: 35)),
                      padding: EdgeInsets.only(right: 30),
                      align: Alignment.centerRight,
                      expandBox: widget.buttonSize,
                      onPressed: () =>
                          Navigator.push(context, MaterialPageRoute(
                              builder: (_) => showingItems[index].getInfo()))
                              .then((val) {setState(() {});}),
                      popupButton: PopupMenuButton(
                        itemBuilder: (_) => [
                          PopupMenuItem(value: 1, child: Text('Editar')),
                          //PopupMenuItem(value: 2, child: Text('Deletar')) // TODO: REMOVER
                        ],
                        onSelected: (val) async {
                          if (val == 1) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (_) => showingItems[index].getEdit()))
                                .then((val) {setState(() {});});
                          } else if (val == 2) {
                            await Provider.of<T>(context, listen: false).remove(showingItems.removeAt(index).id);
                            setState(() {});
                          }
                        },
                    ),
                  )
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
}
