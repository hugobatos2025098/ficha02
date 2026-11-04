sealed class ProductsEvent {}

// Pede para carregar a lista de produtos pela primeira vez.
class LoadProducts extends ProductsEvent {}
// Pede para criar um produto novo.
class ProductCreateRequested extends ProductsEvent {
  final String name;
  final double price;
  ProductCreateRequested({required this.name, required this.price});
}

// Pede para voltar a carregar a lista de produtos (ex.: pull to refresh).
class RefreshProducts extends ProductsEvent {}
