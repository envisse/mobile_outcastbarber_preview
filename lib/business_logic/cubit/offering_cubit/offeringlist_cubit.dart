import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_outcastbarber/models/product.dart';
import 'package:mobile_outcastbarber/models/service.dart';
import 'package:mobile_outcastbarber/services/repository/firebase/offering.dart';

part 'offeringlist_state.dart';

enum OfferingList { product, service }

class OfferinglistCubit extends Cubit<OfferinglistState> {
  OfferinglistCubit() : super(OfferinglistInitial());
  Offering _offering = Offering();

  Future offeringInitial() async {
    try {
      List<Service> dataservice = await _offering.getServicesOffering();
      List<Product> dataproduct = await _offering.getProductsOffering();
      emit(OfferingListLoaded(products: dataproduct, services: dataservice));
    } catch (e) {
      emit(OfferingError(e.toString()));
    }
  }

  Future createOffering({required OfferingList offeringList, Product? product, Service? service}) async{
    emit(OfferinglistLoading());
    if (offeringList == OfferingList.service) {
        (await _offering.createServiceoffering(service!))
            ? emit(OfferingCreate(message: 'New Service added'))
            : emit(OfferingError('Failed, Try again later'));
      } else {
        (await _offering.createProductOffering(product!))
            ? emit(OfferingCreate(message: 'New Product added'))
            : emit(OfferingError('Failed, Try again later'));
      }
      offeringInitial();
  }

  Future offeringDeleted(
      {required OfferingList offeringList, required String id}) async {
      if (offeringList == OfferingList.service) {
        (await _offering.deleteServiceOffering(id))
            ? emit(OfferingDelete(message: 'Service Deleted'))
            : emit(OfferingError('Failed, Try again later'));
      } else {
        (await _offering.deleteProductOffering(id))
            ? emit(OfferingDelete(message: 'Product Deleted'))
            : emit(OfferingError('Failed, Try again later'));
      }
      offeringInitial();
  }

  Future offeringUpdated(
      {required OfferingList offeringList,
      required String id,
      Product? product,
      Service? service}) async {
      if (offeringList == OfferingList.service) {
        (await _offering.updateServiceOffering(id, service!))
            ? emit(OfferingUpdate(message: 'Service Updated'))
            : emit(OfferingError('Failed, Try again later'));
      } else {
        (await _offering.updateProductOffering(id, product!))
            ? emit(OfferingUpdate(message: 'Product Updated'))
            : emit(OfferingError('Failed, Try again later'));
      }
      offeringInitial();
  }
}
