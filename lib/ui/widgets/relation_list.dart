import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planets/core/viewmodels/model.dart';

class RelationListButton extends StatelessWidget {

  String title;
  bool isEmpty;
  bool Function(Model) filter;
  Function(List<Model>) consumer;
  Widget Function(Model) trailing;
  Future<List<Model>> future;

  RelationListButton({
    @required this.future,
    @required this.isEmpty,
    @required this.title,
    this.filter,
    this.consumer,
    this.trailing
  });

  @override
  Widget build(BuildContext context) {
    var list = FutureList<Model>(
      future: this.future,
      nameFunction: (model) => model.name,
      consumer: this.consumer,
      filter: this.filter,
      onTap: (model) async {
        await Navigator.push(context, MaterialPageRoute(builder: (_) => model.getInfo()));
      },
      trailing: this.trailing,
    );
    return RaisedButton.icon(
      color: Colors.deepPurple[800],
      icon: Icon(Icons.public, size: 20, color: Colors.white,),
      label: Text(this.title, style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12
      )),
      onPressed: () {
        showDialog(context: context, builder: (context) => buildDialog(this.title, context, list));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  static Widget buildDialog(String title, context, Widget child) {
    /*if (isEmpty.call())
      return AlertDialog(
        title: Text('Erro'),
        content: Text('Não há nada para listar!'),
        actions: <Widget>[
          FlatButton(onPressed: () => Navigator.of(context).pop(),
              child: Text('Fechar'))
        ],
      );*/
    return AlertDialog(
      title: Text(title),
      content: Container(
        width: double.maxFinite,
        child: child
      ),
      actions: <Widget>[
        FlatButton(onPressed: () => Navigator.of(context).pop(),
            child: Text('Fechar'))
      ],
    );
  }

}

class FutureList<T> extends StatelessWidget {

  Future<List<Object>> future;
  Function(List<T>) consumer;
  bool Function(T) filter;
  String Function(T) nameFunction;
  Function(T) onTap;
  Widget Function(T) trailing;

  FutureList({
    @required this.future,
    @required this.nameFunction,
    this.consumer,
    this.filter,
    this.onTap,
    this.trailing
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: this.future,
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasData) {
            var items = snapshot.data.cast<T>();
            this.consumer?.call(items);
            if (this.filter != null)
              items = items.where(this.filter).toList();
            if (items.isEmpty)
              return Text('Nada para exibir!');
            return ListView.builder(
              shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) =>
                    ListTile(
                      title: Text(this.nameFunction.call(items[index])),
                      onTap: () => this.onTap?.call(items[index]),
                      trailing: this.trailing?.call(items[index]),
                    )
            );
          }
          return SizedBox.fromSize(size: Size.square(10), child: CircularProgressIndicator());
        });
  }
}