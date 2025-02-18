import 'package:hive/hive.dart';

part 'proposalOrderCart.g.dart';


@HiveType(typeId: 3)
class ProposalOrderCart{
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2, defaultValue: 1)
  final int? quantity;
  @HiveField(3)
  final int? netUnitCost;
  @HiveField(4)
  final int? received;
  @HiveField(5)
  final String? batchNo;
  @HiveField(6)
  final String? expireDate;
  @HiveField(7)
  final int? discount;
  @HiveField(8)
  final String? imeiNumber;

  ProposalOrderCart({this.id, this.name, this.received, this.netUnitCost, this.discount, this.quantity, this.batchNo, this.expireDate, this.imeiNumber});

  ProposalOrderCart copyWith({required int quantity}) {
    return ProposalOrderCart(id: id, name: name, quantity: quantity, netUnitCost: netUnitCost, batchNo: batchNo, expireDate: expireDate, imeiNumber: imeiNumber, received: received, discount: discount);
  }

  Map<String, dynamic> toCheckoutJson() {
    return {"product_id": id,  "qty": quantity,  "net_unit_cost": netUnitCost, "recieved": received, "batch_no": batchNo, "expired_date": expireDate, "discount": discount, "imei_number": imeiNumber};
  }
}