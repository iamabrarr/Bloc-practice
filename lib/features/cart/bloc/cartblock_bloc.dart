import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_practice/data/cart.dart';
import 'package:bloc_practice/data/wishlist.dart';
import 'package:bloc_practice/features/home/models/product.dart';
import 'package:meta/meta.dart';

part 'cartblock_event.dart';
part 'cartblock_state.dart';

class CartblockBloc extends Bloc<CartblockEvent, CartblockState> {
  CartblockBloc() : super(CartblockInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromEvent>(cartRemoveEvent);
  }
  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartblockState> emit) {
        print('EMMITTING CART');
    emit(CartSuccessState(cartItems: cartList));
  }
  FutureOr<void> cartRemoveEvent(CartRemoveFromEvent event,Emitter<CartblockState> emit){
   if(cartList.contains(event.product)){
    cartList.remove(event.product);
    print('REMOVED');
   }else{
    cartList.add(event.product);
    print('ADDED');
   }
   emit(CartRemoveState(cartItems: event.product));
  }
}
