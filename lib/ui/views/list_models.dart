import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planets/core/api/crud.dart';
import 'package:planets/core/viewmodels/model.dart';
import 'package:planets/ui/widgets/image_button.dart';
import 'package:provider/provider.dart';

class ListModelsScreen<T extends CRUD, U> extends StatefulWidget {

  final bool Function(U) predicate;

  ListModelsScreen(this.predicate);

  @override
  _ListModelsScreenState createState() => _ListModelsScreenState<T, U>();
}

class _ListModelsScreenState<T extends CRUD, U> extends State<ListModelsScreen<T, U>> {

  var items = List<Model>();

  @override
  Widget build(BuildContext context) {
      var provider = Provider.of<T>(context);
      return Scaffold(
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
              Expanded(
                  child: items.isNotEmpty ? buildGrid() : StreamBuilder(
                    stream: provider.fetchAsStream(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        items = snapshot.data.documents
                            .map((doc) => provider.api.build(doc.documentID, doc.data))
                            .where((e) => widget.predicate.call(e as U))
                            .toList();
                        return buildGrid();
                      }
                      return Text('Loading');
                    },
                  )
              )
            ],
          ),
        ),
      );
  }

  Widget buildGrid() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: GridView.count(
        crossAxisCount: 3,
        children: this.items.map((e) =>
            Padding(
              padding: EdgeInsets.all(10),
                child: ImageButton(
                    image: AssetImage('assets/list-button-bg.png'),
                    child: e.getDisplayButton(context) ?? Text(e.name),
                    align: Alignment.center,
                    padding: EdgeInsets.all(8),
                    onPressed: () =>
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => e.getInfo()))
                ))).toList(),
      ),
    );
  }

}