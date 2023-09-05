import 'package:bloc_practice/data/wishlist.dart';
import 'package:bloc_practice/features/cart/ui/cart.dart';
import 'package:bloc_practice/features/home/bloc/homeblock_bloc.dart';
import 'package:bloc_practice/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomeblockBloc homeBloc = HomeblockBloc();
  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeblockBloc, HomeblockState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageACtionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CartPage()));
        }
        if (state is HomeNavigateToWishlistPageACtionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => WishlistPage()));
        }
        if (state is HomeProductItemCartActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Item is added in cart')));
        }
        if (state is HomeProductItemWishListActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Item is added in wishlist')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadState:
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: Text('Grocery App'),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: Icon(Icons.favorite)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: Icon(Icons.shopping_bag)),
                ],
              ),
              body: ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  itemCount: successState.products.length,
                  itemBuilder: (_, i) => Container(
                        height: 325,
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: Image.network(
                                    successState.products[i].imageUrl,
                                    fit: BoxFit.cover)),
                            SizedBox(height: 5),
                            Text(
                              successState.products[i].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                            SizedBox(height: 5),
                            Text(
                              successState.products[i].description,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '\$' +
                                      successState.products[i].price.toString(),
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      homeBloc.add(
                                          HomeProductWishlistButtonClickEvent(
                                              products:
                                                  successState.products[i]));
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                     
                                    )),
                                IconButton(
                                    onPressed: () {
                                      homeBloc.add(
                                          HomeProductCartButtonClickEvent(
                                              products:
                                                  successState.products[i]));
                                    },
                                    icon: Icon(Icons.shopping_bag,color: cartList.contains(
                                              successState.products[i])
                                          ? Colors.black
                                          : Colors.grey,)),
                                IconButton(
                                    onPressed: () {
                                      homeBloc.add(HomeRemoveWishlistBtnEvent(
                                          product: successState.products[i]));
                                    },
                                    icon: Icon(Icons.delete)),
                                IconButton(
                                    onPressed: () {
                                      homeBloc.add(HomeRemoveCartBtnEvent(
                                          product: successState.products[i]));
                                    },
                                    icon: Icon(Icons.delete_forever)),
                              ],
                            )
                          ],
                        ),
                      )),
            );
          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text('ERROR!'),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
