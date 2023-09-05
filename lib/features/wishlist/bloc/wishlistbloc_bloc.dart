import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'wishlistbloc_event.dart';
part 'wishlistbloc_state.dart';

class WishlistblocBloc extends Bloc<WishlistblocEvent, WishlistblocState> {
  WishlistblocBloc() : super(WishlistblocInitial()) {
    on<WishlistblocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
