import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_products.dart';
import 'products_event.dart';
import 'products_state.dart';

// Um Bloc que gere a lista de produtos, através dos eventos
// LoadProducts e RefreshProducts.
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(this.getProducts) : super(ProductsInitial()) {
    on<LoadProducts>(_onLoad);
    on<RefreshProducts>(_onLoad);
  }

  final GetProducts getProducts;

  Future<void> _onLoad(ProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products = await getProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
