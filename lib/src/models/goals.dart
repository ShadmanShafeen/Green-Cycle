class Goals {
  final String description;
  final int total;
  final int quantity;
  final bool isCompleted;

  Goals(this.description, this.total, this.quantity, this.isCompleted);
}

List goals = [
  Goals('Soda Cans', 500, 500, true),
  Goals('Plastic Bottle 250m.L.', 500, 100, false),
  Goals('Plastic Bottle 1L', 500, 300, false),
  Goals('Polythene Bag', 500, 200, false),
  Goals('plastic Bottle', 50, 30, false),
];
