import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_products.dart';
import 'products_event.dart';
import 'products_state.dart';
import '../../domain/usecases/create_product.dart';

// Um Bloc que gere a lista de produtos, através dos eventos
// LoadProducts e RefreshProducts.
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(this.getProducts, {required this.createProduct})
      : super(ProductsInitial()) {
    on<LoadProducts>(_onLoad);
    on<RefreshProducts>(_onLoad);
    on<ProductCreateRequested>(_onCreate);
  }

  final GetProducts getProducts;
  final CreateProduct createProduct;

  Future<void> _onLoad(ProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products = await getProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  // Cria o produto e volta a pedir a lista, para o ecrã mostrar
  // exatamente o que está na base de dados.
  Future<void> _onCreate(
    ProductCreateRequested event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      await createProduct(name: event.name, price: event.price);
      final products = await getProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
