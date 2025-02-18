

///proposal create event
class ProposalCreatedEvent {
  final int clientId;
  ProposalCreatedEvent(this.clientId);
}

/// Event triggered when the proposal cart is cleared.
class ProposalCartClearedEvent {}



/// Event triggered when the invoice list is updated.
class ProposalListEvent {
  final int clientId;
  ProposalListEvent(this.clientId);
}