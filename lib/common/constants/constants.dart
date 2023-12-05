import 'package:lets_play/common/constants/assets_images.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';

import '../../models/local/coaching_model.dart';

const interFont = 'Inter';
const montserratFont = 'Montserrat';
const sfDisplayFont = 'SF-Pro-Display';

const GOOGLE_MAP_KEY = "AIzaSyD_7lhd9N1eU6tsDZEs0XsCIQtR6nFobxw";

///calendar
final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

const REGISTRATION = "registration";
const PASSWORD = "password";


List<String> mockTags = [
  "Special access",
  "Equipment rental",
  "Free parking",
  "Store",
  "Restaurant",
  "Cafeteria",
  "Snack bar",
  "Changing rooms",
  "Lockers"
];


final List<PlayerModel?> emptyPlayersSpotsArray = [
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null
];

final List<CoachingModel> mockedCoaching = [
  CoachingModel(
      id: 1,
      name: 'Hamza Saeed',
      date: "SUN. 11 SEP. 09:00 PM",
      price: 60,
      address: "Doha Sports Park , 5 KM - DOHA",
      photo: Assets.footMock),
  CoachingModel(
      id: 2,
      name: 'Hamza Saeed',
      date: "SUN. 11 SEP. 09:00 PM",
      price: 60,
      address: "Doha Sports Park , 5 KM - DOHA",
      photo: Assets.footMock),
];
