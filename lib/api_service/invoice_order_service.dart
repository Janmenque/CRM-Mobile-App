import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hrm_app/data/model/client_invoice/invoiceOrderCart.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/event/invoice_events.dart';
import 'package:hrm_app/utils/event_bus.dart';

const String invoiceOrderBoxName = "invoiceOrderBox";

class InvoiceOrderService with ChangeNotifier {

  final box = Hive.box<InvoiceOrderCart>(invoiceOrderBoxName);
  bool isLoading = false;

  InvoiceOrderService() {
    subTotal = calculateTotal();
    eventBus.on<InvoiceCartClearedEvent>().listen((event) {
      clearProductFromCart();
    });
  }

  int productQuantity = 1;
  double subTotal = 0.0;

  void addProductToInvoiceOrderCart(InvoiceOrderCart invoiceOrderCart) async {
    await box.add(invoiceOrderCart);
    subTotal = calculateTotal();
    notifyListeners();
  }


  void updateInvoiceProductQuantity({required int quantity, required int productId}) async {
    final cHive = getAllInvoiceCartProduct().firstWhere((element) => element.id == productId);
    final cart = cHive.copyWith(quantity: quantity);
    box.putAt(getIndexOfInvoiceCart(cHive), cart);
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
    return getAllInvoiceCartProduct().indexWhere((element) => element.id == id);
  }

  int getIndexOfInvoiceCart(InvoiceOrderCart cart) {
    return getAllInvoiceCartProduct().indexWhere((element) => element.id == cart.id);
  }

  List<InvoiceOrderCart> getAllInvoiceCartProduct() {
    return box.values.toList();
  }

  double calculateTotal() {
    double total = 0;
    getAllInvoiceCartProduct().forEach((element) {
      total += element.netUnitCost! * (element.quantity ?? 1);
    });
    return total;
  }


  InvoiceOrderCart? getCartById({required int pid}) {
    if (isProductAlreadyInCart(pid)) {
      return getAllInvoiceCartProduct().firstWhere((element) => element.id == pid);
    }
    return null;
  }


  int cartCount() {
    return getAllInvoiceCartProduct().length;
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