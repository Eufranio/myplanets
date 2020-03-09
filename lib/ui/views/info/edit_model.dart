import 'package:flutter/material.dart';
import 'package:planets/core/api/crud.dart';
import 'package:planets/core/viewmodels/model.dart';
import 'package:provider/provider.dart';

class EditModelScreen<T extends Model> extends StatefulWidget {

  T model;
  Function modelInstance;
  Function stateFunction;

  EditModelScreen(this.model, this.modelInstance, this.stateFunction);

  @override
  EditModelScreenState createState() => this.stateFunction.call();

}

abstract class EditModelScreenState<T extends Model, U extends CRUD> extends State<EditModelScreen<T>> {

  T editingModel;
  final formKey = GlobalKey<FormState>();

  TextStyle style = TextStyle(
      fontSize: 15,
      color: Colors.white,
      fontWeight: FontWeight.normal
  );

  TextStyle style2 = TextStyle(
      fontSize: 15,
      color: Colors.white,
      fontWeight: FontWeight.bold
  );

  @override
  void initState() {
    if (widget.model != null) { // editing an element
      editingModel = widget.model;
    } else {
      editingModel = widget.modelInstance.call();
    }
  }

  String getTitle();

  Iterable<Widget> getFields();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backg.png'), fit: BoxFit.cover),
        ),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Center(
              child: Form(
                  key: formKey,
                  child: Column(
                      children: <Widget>[
                        AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0
                        ),
                        Text(this.getTitle(), style: TextStyle(fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                        SizedBox(
                          height: 70,
                          width: 100,
                        ),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(
                                'assets/planet.png'), fit: BoxFit.cover),),
                        ),
                        SizedBox(
                          height: 70,
                          width: 100,
                        ),
                      ] + this.getFields()
                        + [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(90, 20, 80, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //widget.model != null ? SizedBox.shrink() :
                              Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 80,
                                  child: RaisedButton(
                                    color: Colors.deepPurple[900],
                                    child: Text('Salvar', style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal)),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    onPressed: () async {
                                      formKey.currentState.save();
                                      Navigator.of(context).pop(editingModel);
                                      if (widget.model != null) {
                                        await Provider.of<U>(context, listen: false).update(editingModel, editingModel.id);
                                      } else {
                                        await Provider.of<U>(context, listen: false).addModel(editingModel);
                                      }
                                    }
                                  )
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: 100,
                                child: RaisedButton(
                                  color: Colors.deepPurple[600],
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  onPressed: () async {
                                    await Provider.of<U>(context, listen: false).remove(editingModel.id);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                )
                              ),
                            ],
                          ),
                        ),
                      ]
                  )
              )
          ),
        ),
      ),
    );
  }
}