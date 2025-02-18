import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hrm_app/data/model/client_estimate/estimateOrderCart.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/event/estimate_events.dart';
import 'package:hrm_app/utils/event_bus.dart';


const String estimateOrderBoxName = "estimateOrderBox";

class EstimateOrderService with ChangeNotifier {

  final box = Hive.box<EstimateOrderCart>(estimateOrderBoxName);
  bool isLoading = false;

  EstimateOrderService() {
    subTotal = calculateTotal();
    eventBus.on<EstimateCartClearedEvent>().listen((event) {
      clearProductFromCart();
    });
  }

  int productQuantity = 1;
  double subTotal = 0.0;

  void addProductToEstimateOrderCart(EstimateOrderCart estimateOrderCart) async {
    await box.add(estimateOrderCart);
    subTotal = calculateTotal();
    notifyListeners();
  }


  void updateEstimateProductQuantity({required int quantity, required int productId}) async {
    final cHive = getAllEstimateCartProduct().firstWhere((element) => element.id == productId);
    final cart = cHive.copyWith(quantity: quantity);
    box.putAt(getIndexOfProductCart(cHive), cart);
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
    return getAllEstimateCartProduct().indexWhere((element) => element.id == id);
  }

  int getIndexOfProductCart(EstimateOrderCart cart) {
    return getAllEstimateCartProduct().indexWhere((element) => element.id == cart.id);
  }

  List<EstimateOrderCart> getAllEstimateCartProduct() {
    return box.values.toList();
  }

  double calculateTotal() {
    double total = 0;
    getAllEstimateCartProduct().forEach((element) {
      total += element.netUnitCost! * (element.quantity ?? 1);
    });
    return total;
  }


  EstimateOrderCart? getCartById({required int pid}) {
    if (isProductAlreadyInCart(pid)) {
      return getAllEstimateCartProduct().firstWhere((element) => element.id == pid);
    }
    return null;
  }


  int cartCount() {
    return getAllEstimateCartProduct().length;
  }


  void clearProductFromCart() async {
    await box.clear();
    notifyListeners();
  }

  bool isProductAlreadyInCart(int pid) {
    final checkCart = box.values.where((element) => element.id == pid).toList();
    if (checkCart.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }


}