part of 'cartblock_bloc.dart';

@immutable
abstract class CartblockEvent {}


class CartInitialEvent extends CartblockEvent{}

class CartRemoveFromEvent extends CartblockEvent{
  final HomeProductModel product;
  CartRemoveFromEvent({required this.product});
}
