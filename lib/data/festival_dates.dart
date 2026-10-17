/// Festival dates follow the North Indian (Delhi) calendar.
/// Temples and regions may observe a festival a day earlier or later.
/// Dates are complete through 2029.
class Festival {
  final String name;
  final String subtitle;
  final List<String> dates; // 'YYYY-MM-DD', oldest first
  final String frequencyNote;

  const Festival(
    this.name,
    this.subtitle,
    this.dates, {
    this.frequencyNote = '',
  });

  /// The first date that is today or later, or null if none is left.
  DateTime? nextDate([DateTime? from]) {
    final now = from ?? DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    for (final s in dates) {
      final d = DateTime.parse(s);
      if (!d.isBefore(today)) return d;
    }
    return null;
  }
}

const festivals = [
  Festival(
    'Janmashtami',
    'Celebrating the midnight birth of Shri Krishna',
    ['2027-08-25', '2028-08-13', '2029-09-01'],
  ),
  Festival(
    'Radhashtami',
    'Birth of Radha, about two weeks after Janmashtami',
    ['2027-09-08', '2028-08-27', '2029-09-15'],
  ),
  Festival(
    'Govardhan Puja',
    'The day after Diwali, honouring the Govardhan lila',
    ['2026-11-10', '2027-10-30', '2028-10-18', '2029-11-06'],
  ),
  Festival(
    'Holi',
    'Spring full moon, colours and the story of Radha and Krishna',
    ['2027-03-22', '2028-03-11', '2029-03-01'],
  ),
  Festival(
    'Gita Jayanti',
    'Marks the day the Gita was spoken at Kurukshetra',
    ['2026-12-20', '2027-12-09', '2028-11-27', '2029-12-16'],
  ),
  Festival(
    'Ekadashi',
    'The 11th lunar day, observed with fasting and prayer',
    [],
    frequencyNote: 'Falls twice a month',
  ),
];

String formatDate(DateTime d) {
  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return '${days[d.weekday - 1]}, ${d.day} ${months[d.month - 1]} ${d.year}';
}
