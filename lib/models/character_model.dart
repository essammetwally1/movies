class Character {
  final String imagePath;
  final String characterName;
  final String characterDescription;
  Character({
    required this.imagePath,
    required this.characterName,
    this.characterDescription = 'Audio Player',
  });
}
