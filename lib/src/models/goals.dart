class Goals {
  final String description;
  final int total_weight;
  final int current_weight;
  final bool isCompleted;

  Goals(this.description, this.total_weight, this.current_weight, this.isCompleted);
}

List goals = [
  Goals('Newspaper', 15, 15, true),
  Goals('Plastic Bottle\n250m.L.', 5, 3, false),
  Goals('Plastic Bottle\n1L', 5, 3, false),
  Goals('Soda glass bottle\n250m.l.', 15, 2, false),
  Goals('Soda can\n300m.L.', 5, 3, false),
];
