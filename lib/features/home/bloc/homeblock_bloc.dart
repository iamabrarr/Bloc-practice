import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_practice/data/grocery_data.dart';
import 'package:bloc_practice/data/wishlist.dart';
import 'package:bloc_practice/features/home/models/product.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'homeblock_event.dart';
part 'homeblock_state.dart';

class HomeblockBloc extends Bloc<HomeEvent, HomeblockState> {
  HomeblockBloc() : super(HomeblockInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickEvent>(homeWishListBtnClickEvent);
    on<HomeProductCartButtonClickEvent>(homeCartBtnClickEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishListBtnNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartBtnNavigateEvent);
    on<HomeRemoveCartBtnEvent>(homeRemoveCartItem);
    on<HomeRemoveWishlistBtnEvent>(homeRemoveWishlistItem);
   
  }
  //INITIAL EVENT
  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeblockState> emit) async {
    emit(HomeLoadState());
    await Future.delayed(Duration(seconds: 2));
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts.map((e) => HomeProductModel(
            description: e['description'],
            id: e['id'],
            imageUrl: e['imageUrl'],
            name: e['name'],
            price: e['price'])).toList()));
  }

  //CLICK EVENTS
  FutureOr<void> homeWishListBtnClickEvent(
      HomeProductWishlistButtonClickEvent event, Emitter<HomeblockState> emit) {
    print('WISHLIST CLICKED');
    wishlist.add(event.products);
    emit(HomeProductItemCartActionState());
  }

  FutureOr<void> homeCartBtnClickEvent(
      HomeProductCartButtonClickEvent event, Emitter<HomeblockState> emit) {
    print('CART CLICKED');
    print(event.products.id);
    cartList.add(event.products);
    
    emit(HomeProductItemWishListActionState());

  }

  //NAVIGATE EVENTS
  FutureOr<void> homeWishListBtnNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeblockState> emit) {
    print('WISHLIST NAVIGATE CLICKED');
    emit(HomeNavigateToWishlistPageACtionState());
  }

  FutureOr<void> homeCartBtnNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeblockState> emit) {
    print('CART NAVIGATE CLICKED');
    emit(HomeNavigateToCartPageACtionState());
  }
  //REMOVE
  FutureOr<void> homeRemoveCartItem(HomeRemoveCartBtnEvent event,Emitter<HomeblockState> emit){
    print('Removed CART ITEM');
    cartList.remove(event.product);

  }
  FutureOr<void> homeRemoveWishlistItem(HomeRemoveWishlistBtnEvent event,Emitter<HomeblockState> emit){
    print('Remove wishlist item');
    wishlist.remove(event.product);
  }
 
}
