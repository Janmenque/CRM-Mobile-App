
///Estimate create event
class EstimateCreatedEvent {
  final int clientId;
  EstimateCreatedEvent(this.clientId);
}

/// Event triggered when the proposal cart is cleared.
class EstimateCartClearedEvent {}



/// Event triggered when the invoice list is updated.
class EstimateListEvent {
  final int clientId;
  EstimateListEvent(this.clientId);
}