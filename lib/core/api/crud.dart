import 'package:flutter/foundation.dart';
import 'package:planets/locator.dart';
import 'package:planets/core/api/object_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planets/core/viewmodels/model.dart';

abstract class CRUD<T extends ObjectManager<Model>> with ChangeNotifier {

  T api = locator<T>();
  List<Model> items;

  Future<List<Model>> fetch() async {
    var result = await api.getDataCollection();
    items = result.documents
        .map((doc) => api.build(doc.documentID, doc.data))
        .toList();
    return items;
  }

  Stream<QuerySnapshot> fetchAsStream() {
    return api.streamDataCollection();
  }

  Future<Model> getById(String id) async {
    if (id == null) return null;
    var doc = await api.getDocumentById(id);
    return api.build(doc.documentID, doc.data);
  }

  Future remove(String id) async {
    await api.removeDocument(id);
    return;
  }

  Future update(Model data, String id) async {
    await api.updateDocument(api.toJson(data), id);
    return;
  }

  Future<Model> addModel(Model data) async {
    var result = await api.addDocument(api.toJson(data));
    data.id = result.documentID;
    return data;
  }
}