
///Invoice create event
class InvoiceCreatedEvent {
  final int clientId;
    InvoiceCreatedEvent(this.clientId);
}

/// Event triggered when the proposal cart is cleared.
class InvoiceCartClearedEvent {}



/// Event triggered when the invoice list is updated.
class InvoiceListEvent {
  final int clientId;
  InvoiceListEvent(this.clientId);
}