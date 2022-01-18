import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_outcastbarber/models/product.dart';
import 'package:mobile_outcastbarber/models/service.dart';

class Offering {
  final CollectionReference _offeringCollectionReference =
      FirebaseFirestore.instance.collection('offering');
  
  //function to get all offering product
  Future<List<Product>> getProductsOffering() async {
    List<Product> products = [];
    try {
      QuerySnapshot<Map<String, dynamic>> data =
          await _offeringCollectionReference
              .doc('product')
              .collection('list_product')
              .get();
      data.docs.forEach((element) {
        products.add(Product.fromjson(element.data(),element.id));
      });
      return products;
    } on FirebaseException catch (e) {
      print(e);
      return products;
    }
  }

  //function to get all offering service
  Future<List<Service>> getServicesOffering() async {
    List<Service> services = [];
    try {
      QuerySnapshot<Map<String, dynamic>> data =
          await _offeringCollectionReference
              .doc('service')
              .collection('list_service')
              .get();    
      data.docs.forEach((element) {
        services.add(Service.fromjson(element.data(),element.id));
      });
      return services;
    } on FirebaseException catch (e){
      print(e);
      return services;
    }
  }

  //Function to create new product offering
  Future<bool> createProductOffering(Product product) async {
    try {
      await _offeringCollectionReference.doc('product').collection('list_product').doc().set(product.json());
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  //Function to create new service offering
  Future<bool> createServiceoffering(Service service) async{
    try {
      await _offeringCollectionReference.doc('service').collection('list_service').doc().set(service.json());
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  //Function to delete service
  Future<bool> deleteServiceOffering(String id) async{
    try {
      await _offeringCollectionReference.doc('service').collection('list_service').doc(id).delete();
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  //function to delete product
  Future<bool> deleteProductOffering(String id) async{
    try {
      await _offeringCollectionReference.doc('product').collection('list_product').doc(id).delete();
      return true;
    }on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  //function to edit service
  Future<bool> updateServiceOffering(String id, Service service) async{
    try {
      await _offeringCollectionReference.doc('service').collection('list_service')
        .doc(id).update(service.json()).then((value) => print('Service Updated'));
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  //function to edit product
  Future<bool> updateProductOffering(String id,Product product) async{
    try {
      await _offeringCollectionReference.doc('product').collection('list_product')
        .doc(id).update(product.json())
        .then((value) => print('Product Updated'));
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }
}
