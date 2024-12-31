import 'package:bloc/bloc.dart';
import 'package:flutter_nata_pos_app/data/datasources/product_local_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/response/product_response_model.dart';

part 'local_product_event.dart';
part 'local_product_state.dart';
part 'local_product_bloc.freezed.dart';

class LocalProductBloc extends Bloc<LocalProductEvent, LocalProductState> {
  final ProductLocalDatasource productLocalDatasource;
  LocalProductBloc(
    this.productLocalDatasource,
  ) : super(_Initial()) {
    on<_GetLocalProduct>((event, emit) async {
      emit(const _Loading());
      final result = await productLocalDatasource.getProducts();

      emit(_Loaded(result));
    });
  }
}
