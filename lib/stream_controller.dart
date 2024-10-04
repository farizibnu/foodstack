import 'dart:async';

import 'package:foodstack/models/menu.dart';

final StreamController<int> cartStreamController =
    StreamController<int>.broadcast();

void addToCart(Menu menu) {
  if (carts.containsKey(menu)) {
    carts[menu] =
        carts[menu]! + 1; 
  } else {
    carts[menu] = 1; 
  }
  cartStreamController.sink.add(carts.length); 
}

void removeFromCart(Menu menu) {
  if (carts.containsKey(menu)) {
    if (carts[menu]! > 1) {
      carts[menu] = carts[menu]! - 1; 
    } else {
      carts.remove(menu); 
    }
  }
  cartStreamController.sink.add(carts.length); 
}

void removeAllFromCart(Menu menu) {
  if (carts.containsKey(menu)) {
    carts.remove(menu);
    cartStreamController.add(carts.length);
  }
}

void dispose() {
  cartStreamController.close();
}
