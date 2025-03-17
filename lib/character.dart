class Character {
  String name;
  int health;
  int attack;
  int defense;

  Character({required this.name, required this.health, required this.attack, required this.defense});

  void attackMonster(Monster monster) {}
  void defend() {}
  void showStatus() {}
}
