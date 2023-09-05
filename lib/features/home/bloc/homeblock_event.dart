part of 'homeblock_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeProductWishlistButtonClickEvent extends HomeEvent {
  final HomeProductModel products;
  HomeProductWishlistButtonClickEvent({required this.products});
}
class HomeProductCartButtonClickEvent extends HomeEvent {
    final HomeProductModel products;

  HomeProductCartButtonClickEvent({required this.products});
}
class HomeWishlistButtonNavigateEvent extends HomeEvent {}
class HomeCartButtonNavigateEvent extends HomeEvent {}
class HomeInitialEvent extends HomeEvent{
  
}

class HomeRemoveCartBtnEvent extends HomeEvent{
  final HomeProductModel product;
  HomeRemoveCartBtnEvent({required this.product});
}
class HomeRemoveWishlistBtnEvent extends HomeEvent{
    final HomeProductModel product;
    HomeRemoveWishlistBtnEvent({required this.product});
}


// class HomeCartBtnCartedEvent extends HomeProductCartButtonClickEvent{
  
// }
// class HomeCartBtnUnCartedEvent extends HomeProductCartButtonClickEvent{
  
// }