part of 'cartblock_bloc.dart';

@immutable
abstract class CartblockState {}
abstract class CartActionState extends CartblockState{}

 class CartblockInitial extends CartblockState {}

class CartSuccessState extends CartblockState{
  final List<HomeProductModel> cartItems;
  CartSuccessState({required this.cartItems});
}

class CartRemoveState extends CartblockState{
  final HomeProductModel cartItems;
  CartRemoveState({required this.cartItems});
}