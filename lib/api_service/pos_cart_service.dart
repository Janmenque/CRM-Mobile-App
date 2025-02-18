import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hrm_app/data/model/crm_sales/cart.dart';

const String cartBoxName = "cartBox";

class CartService with ChangeNotifier {

  final box = Hive.box<Cart>(cartBoxName);
  bool isLoading = false;

  CartService() {
    subTotal = calculateTotal();
  }

  int productQuantity = 1;
  double subTotal = 0.0;

  void addProductToCart(Cart cart) async {
    await box.add(cart);
    subTotal = calculateTotal();
    notifyListeners();
  }


  void updateProductQuantity({required int quantity, required int productId}) async {
    final cHive = getAllCartProduct().firstWhere((element) => element.id == productId);
    final cart = cHive.copyWith(quantity: quantity);
    box.putAt(getIndexOfCart(cHive), cart);
    subTotal = calculateTotal();
    notifyListeners();
  }


  void decrementQuantity() async {
    if (productQuantity > 1) {
      productQuantity--;
      notifyListeners();
    }
    notifyListeners();
  }


  void removeProductFromCart({required int id}) async {
    await box.deleteAt(getIndexOfCartList(id: id));
    subTotal = calculateTotal();
    notifyListeners();
  }


  int getIndexOfCartList({required int id}) {
    return getAllCartProduct().indexWhere((element) => element.id == id);
  }

  int getIndexOfCart(Cart cart) {
    return getAllCartProduct().indexWhere((element) => element.id == cart.id);
  }

  List<Cart> getAllCartProduct() {
    return box.values.toList();
  }

  double calculateTotal() {
    double total = 0;
    getAllCartProduct().forEach((element) {
      total += element.price! * (element.quantity ?? 1);
    });
    return total;
  }


  Cart? getCartById({required int pid}) {
    if (isProductAlreadyInCart(pid)) {
      return getAllCartProduct().firstWhere((element) => element.id == pid);
    }
    return null;
  }


  int cartCount() {
    return getAllCartProduct().length;
  }


  bool isProductAlreadyInCart(int pid) {
    final checkCart = box.values.where((element) => element.id == pid).toList();
    if (checkCart.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }


  void clearProductFromCart() async {
    await box.clear();
    notifyListeners();
  }

  Map<String, dynamic> checkoutData() {
    return {"products": getAllCartProduct().map((e) => e.toCheckoutJson()).toList()};
  }

}