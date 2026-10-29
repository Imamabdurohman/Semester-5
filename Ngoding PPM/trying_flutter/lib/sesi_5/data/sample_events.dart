import '../models/event_item.dart';

final List<EventItem> sampleEvents = [
  EventItem(
    id: 'e1',
    title: 'Masa Depan Generative AI & Deep Learning',
    speaker: 'Dr. Raden Wijaya, M.Sc.',
    category: 'AI',
    date: '15 November 2026',
    time: '09:00 - 12:00 WIB',
    location: 'Auditorium Utama Lantai 3',
    price: 50000,
    posterUrl: 'https://picsum.photos/id/1018/600/400',
    quota: 120,
    description:
        'Seminar mendalam mengenai perkembangan Large Language Models dan Generative AI.',
  ),
  EventItem(
    id: 'e2',
    title: 'Cross-Platform App Dev dengan Flutter 3.x',
    speaker: 'Imam Abdurohman, S.Kom.',
    category: 'Mobile',
    date: '18 November 2026',
    time: '13:00 - 16:00 WIB',
    location: 'Lab Komputer Lanjut 2',
    price: 45000,
    posterUrl: 'https://picsum.photos/id/1060/600/400',
    quota: 80,
    description:
        'Workshop praktis membangun UI interaktif dan arsitektur aplikasi mobile terkini.',
  ),
  EventItem(
    id: 'e3',
    title: 'Smart City & Arsitektur IoT Industri 5.0',
    speaker: 'Prof. Bambang Prasetyo',
    category: 'IoT',
    date: '22 November 2026',
    time: '09:30 - 12:30 WIB',
    location: 'Aula Gedung B',
    price: 60000,
    posterUrl: 'https://picsum.photos/id/1074/600/400',
    quota: 100,
    description:
        'Eksplorasi sensor cerdas dan cloud analytics untuk infrastruktur kota pintar.',
  ),
  EventItem(
    id: 'e4',
    title: 'Ethical Hacking & Defense Strategy 2026',
    speaker: 'Siti Nurhaliza, CEH',
    category: 'Cybersecurity',
    date: '25 November 2026',
    time: '10:00 - 15:00 WIB',
    location: 'Ruang Seminar 101',
    price: 75000,
    posterUrl: 'https://picsum.photos/id/1015/600/400',
    quota: 60,
    description:
        'Pelajari teknik uji penetrasi sistem dan perlindungan privasi data tingkat tinggi.',
  ),
];