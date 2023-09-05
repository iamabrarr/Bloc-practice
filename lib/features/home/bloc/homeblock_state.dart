part of 'homeblock_bloc.dart';

@immutable
abstract class HomeblockState {}

abstract class HomeActionState extends HomeblockState {}

class HomeblockInitial extends HomeblockState {}

class HomeLoadState extends HomeblockState {}

class HomeLoadedSuccessState extends HomeblockState {
  final List<HomeProductModel> products;
  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeblockState {}

class HomeNavigateToWishlistPageACtionState extends HomeActionState {}

class HomeNavigateToCartPageACtionState extends HomeActionState {}

class HomeProductItemWishListActionState extends HomeActionState {}

class HomeProductItemCartActionState extends HomeActionState {}

class HomeProductRemoveWishlistState extends HomeActionState{}
class HomeProductRemoveCartState extends HomeActionState{}

class HomeCartBtnColorState extends HomeActionState{
  final Color color;
  HomeCartBtnColorState({required this.color});
}