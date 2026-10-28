sealed class ProductsEvent {}

// Pede para carregar a lista de produtos pela primeira vez.
class LoadProducts extends ProductsEvent {}

// Pede para voltar a carregar a lista de produtos (ex.: pull to refresh).
class RefreshProducts extends ProductsEvent {}
