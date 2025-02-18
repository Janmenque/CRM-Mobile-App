import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hrm_app/data/model/client_proposal/proposalOrderCart.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/event/proposal_events.dart';
import 'package:hrm_app/utils/event_bus.dart';


const String proposalOrderBoxName = "proposalOrderBox";

class ProposalOrderService with ChangeNotifier {

  final box = Hive.box<ProposalOrderCart>(proposalOrderBoxName);
  bool isLoading = false;

  ProposalOrderService() {
    subTotal = calculateTotal();
    eventBus.on<ProposalCartClearedEvent>().listen((event) {
      clearProductFromCart();
    });
  }

  int productQuantity = 1;
  double subTotal = 0.0;

  void addProductToProposalOrderCart(ProposalOrderCart proposalOrderCart) async {
    await box.add(proposalOrderCart);
    subTotal = calculateTotal();
    notifyListeners();
  }


  void updateProposalProductQuantity({required int quantity, required int productId}) async {
    final cHive = getAllProposalCartProduct().firstWhere((element) => element.id == productId);
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
    return getAllProposalCartProduct().indexWhere((element) => element.id == id);
  }

  int getIndexOfProductCart(ProposalOrderCart cart) {
    return getAllProposalCartProduct().indexWhere((element) => element.id == cart.id);
  }

  List<ProposalOrderCart> getAllProposalCartProduct() {
    return box.values.toList();
  }

  double calculateTotal() {
    double total = 0;
    getAllProposalCartProduct().forEach((element) {
      total += element.netUnitCost! * (element.quantity ?? 1);
    });
    return total;
  }


  ProposalOrderCart? getCartById({required int pid}) {
    if (isProductAlreadyInCart(pid)) {
      return getAllProposalCartProduct().firstWhere((element) => element.id == pid);
    }
    return null;
  }


  int cartCount() {
    return getAllProposalCartProduct().length;
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