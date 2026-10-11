class Leela {
  final String title;
  final String hindi;
  final String subtitle;
  final String place;
  final String readTime;
  final List<String> paragraphs;
  final String meaning;
  final String source;

  const Leela({
    required this.title,
    required this.hindi,
    required this.subtitle,
    required this.place,
    required this.readTime,
    required this.paragraphs,
    required this.meaning,
    required this.source,
  });
}

const leelas = [
  Leela(
    title: "Makhan Chor",
    hindi: "माखन चोर",
    subtitle: "The butter thief",
    place: "Gokul",
    readTime: "3 min",
    paragraphs: [
      "In Gokul, little Krishna could not resist the fresh butter that Yashoda and the village gopis churned each morning.",
      "He and his friends would sneak into homes, stack up stools to reach the hanging pots, and share the butter, even feeding some to the monkeys.",
      "When caught, he only smiled so sweetly that the gopis forgot their complaints, and Yashoda's scolding melted into love.",
    ],
    meaning: "Devotion is about love, not perfection. The Lord is won by a pure and playful heart.",
    source: "Bhagavata Purana, Canto 10",
  ),
  Leela(
    title: "Kaliya Mardan",
    hindi: "कालिया मर्दन",
    subtitle: "Dancing on the serpent",
    place: "Vrindavan",
    readTime: "4 min",
    paragraphs: [
      "The great serpent Kaliya lived in the Yamuna near Vrindavan, and his poison made the water deadly for the cows and the cowherd boys.",
      "Krishna climbed a tree, leapt into the river, and danced on the serpent's many hoods until Kaliya was worn out and surrendered.",
      "Kaliya's wives prayed for mercy. Krishna spared him and told him to leave the Yamuna, making the river safe again.",
    ],
    meaning: "Pride and poison cannot stand before humility and truth. Even the proud can be forgiven when they surrender.",
    source: "Bhagavata Purana, Canto 10",
  ),
  Leela(
    title: "Govardhan Leela",
    hindi: "गोवर्धन लीला",
    subtitle: "The hill held high",
    place: "Vrindavan",
    readTime: "4 min",
    paragraphs: [
      "The people of Vrindavan used to worship Indra for rain. Krishna suggested they honour Govardhan hill instead, which fed their cattle and gave them shelter.",
      "Angry, Indra sent a fierce storm. Krishna lifted the whole hill on the little finger of his hand, and everyone took shelter beneath it for seven days.",
      "At last Indra's pride was broken, and he bowed to Krishna in apology.",
    ],
    meaning: "Gratitude to nature and trust in the divine protect us when we take refuge in them.",
    source: "Bhagavata Purana, Canto 10",
  ),
  Leela(
    title: "Rasa Lila",
    hindi: "रास लीला",
    subtitle: "The dance of devotion",
    place: "Vrindavan",
    readTime: "5 min",
    paragraphs: [
      "On a bright autumn full-moon night, the sound of Krishna's flute called the gopis out to the forest by the Yamuna.",
      "Krishna danced with them, appearing beside each one, so that every gopi felt he was dancing with her alone.",
      "The dance is remembered as the highest picture of devotion: the soul's longing for the divine, with ego set aside.",
    ],
    meaning: "True devotion is a loving union with God, beyond pride and ownership.",
    source: "Bhagavata Purana, Canto 10",
  ),
  Leela(
    title: "Kansa Vadh",
    hindi: "कंस वध",
    subtitle: "The tyrant's end",
    place: "Mathura",
    readTime: "4 min",
    paragraphs: [
      "Krishna and Balarama came to Mathura, where the cruel king Kansa, Krishna's uncle, had long imprisoned Devaki and Vasudeva.",
      "In the wrestling arena, Kansa's champions were defeated one after another, and Krishna then put an end to Kansa himself.",
      "Krishna freed his parents and restored Ugrasena, Kansa's father, to the throne.",
    ],
    meaning: "Injustice cannot last forever. Dharma is restored when courage meets righteousness.",
    source: "Bhagavata Purana, Canto 10",
  ),
  Leela(
    title: "Sudama's Friendship",
    hindi: "सुदामा मित्रता",
    subtitle: "A humble gift of rice",
    place: "Dwarka",
    readTime: "3 min",
    paragraphs: [
      "Sudama was a poor Brahmin and Krishna's childhood friend from their school days with the sage Sandipani.",
      "Pushed by his wife, he visited Dwarka carrying only a small bundle of flattened rice, too shy to offer it.",
      "Krishna welcomed him with great love and happily ate the rice. When Sudama returned home, he found his poverty gone.",
    ],
    meaning: "The Lord values love and sincerity, not the worth of the gift.",
    source: "Bhagavata Purana, Canto 10",
  ),
  Leela(
    title: "Draupadi's Protection",
    hindi: "द्रौपदी की रक्षा",
    subtitle: "Faith answered",
    place: "Hastinapur",
    readTime: "4 min",
    paragraphs: [
      "In the royal court of Hastinapur, Draupadi was shamefully insulted before the elders, and no one stepped in to help her.",
      "Helpless, she called on Krishna with complete faith.",
      "The Mahabharata tells that her sari became endless, and she was protected from the humiliation.",
    ],
    meaning: "Sincere faith is never left unanswered, and dharma protects those who trust in it.",
    source: "Mahabharata, Sabha Parva",
  ),
];
extension LeelaTime on Leela {
  String get duration {
    final text = '${paragraphs.join(' ')} $meaning';
    final words = text.trim().split(RegExp(r'\s+')).length;
    final minutes = (words / 150).ceil();
    return '${minutes < 1 ? 1 : minutes} min';
  }
}
