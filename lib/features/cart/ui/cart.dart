import 'package:bloc_practice/data/cart.dart';
import 'package:bloc_practice/features/cart/bloc/cartblock_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartBloc=CartblockBloc();
  @override
  void initState() {
     cartBloc.add(CartInitialEvent());
     print('CART LIST IS ${cartlist.length}');
    super.initState();
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: BlocConsumer<CartblockBloc, CartblockState>(
        bloc: cartBloc,
        listenWhen: (previous,currect)=>currect is CartActionState,
        buildWhen:(previous,currect)=>currect is !CartActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
         switch (state.runtimeType) {
           case CartSuccessState:
             final successState = state as CartSuccessState;
              return   ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  itemCount: successState.cartItems.length,
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
                                    successState.cartItems[i].imageUrl,
                                    fit: BoxFit.cover)),
                            SizedBox(height: 5),
                            Text(
                              successState.cartItems[i].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                            SizedBox(height: 5),
                            Text(
                              successState.cartItems[i].description,
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
                                      successState.cartItems[i].price.toString(),
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      // cartBloc.add(HomeProductWishlistButtonClickEvent(products: successState.products[i]));
                                    },
                                    icon: Icon(Icons.favorite)),
                                IconButton(
                                    onPressed: () {
                                     cartBloc.add(CartRemoveFromEvent(product: successState.cartItems[i]));
                                    },
                                    icon: Icon(Icons.shopping_bag)),
                                    IconButton(
                                    onPressed: () {
                                      // homeBloc.add(HomeRemoveWishlistBtnEvent(product: successState.products[i])); 
                                    },
                                    icon: Icon(Icons.delete)),
                                      IconButton(
                                    onPressed: () {
                                      // homeBloc.add(HomeRemoveCartBtnEvent(product: successState.products[i])); 
                                    },
                                    icon: Icon(Icons.delete_forever)),
                              ],
                            )
                          ],
                        ),
                      ));
           default:
           
         }
         return SizedBox();
        },
      ),
    );
  }
}
