import 'package:flutter/cupertino.dart';
import 'package:lets_play/features/chat/chat_discussion_screen.dart';
import 'package:lets_play/features/create_match/create_match_screen.dart';
import 'package:lets_play/features/forgot_password_flow/forgot_password_screen.dart';
import 'package:lets_play/features/home_screen/home_screen.dart';
import 'package:lets_play/features/home_screen/public_matches_show_all/public_matches_show_all_screen.dart';
import 'package:lets_play/features/home_search/home_search_screen.dart';
import 'package:lets_play/features/payment/component/dibsy_credit_card_form.dart';
import 'package:lets_play/features/payment/component/success_screen.dart';
import 'package:lets_play/features/payment/webview/webview_payment_screen.dart';
import 'package:lets_play/features/playground_details/playground_detail_screen.dart';
import 'package:lets_play/features/profile_settings/change_password_screen.dart';
import 'package:lets_play/features/profile_settings/eb_chat_screen.dart';
import 'package:lets_play/routes/routes_list.dart';
import 'package:lets_play/features/match_details_screen/match_details_screen.dart';
import 'package:lets_play/features/sport_matches_screen/sport_fields_screen.dart';
import '../bottom_tabbar/bottom_tabbar.dart';
import '../features/landing/landing_screen.dart';
import '../features/landing/login_screen.dart';
import '../features/payment/match_payment_screen.dart';
import '../features/pick_teams/teams_picker_screen.dart';
import '../features/add_score/addScore_screen.dart';
import '../features/profile_settings/favorite_playgrounds_screen.dart';
import '../features/profile_settings/my_profile_screen.dart';
import '../features/profile_settings/payment_cards_screen.dart';
import '../features/profile_settings/profile_settings.dart';
import '../features/register/enable_location_screen.dart';
import '../features/register/register_screen.dart';
import '../features/register/select_sport_screen.dart';
import '../features/summary_screen/add_player_amount_screen.dart';
import '../features/summary_screen/summary_screen.dart';
import '../models/sport_category_model.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.landing: (context) => const LandingScreen(),
        RouteList.login: (context) => const LoginScreen(),
        RouteList.register: (context) => const RegisterScreen(),
        RouteList.selectFavSport: (context) => SelectSportScreen(
              isUpdate: setting.arguments != null
                  ? (setting.arguments as Map<String, dynamic>)['isUpdate']
                  : false,
            ),
        RouteList.enableLocation: (context) => const EnableLocationScreen(),
        RouteList.homeScreen: (context) => const HomeScreen(),
        RouteList.sportFieldsScreen: (context) => SportFieldsScreen(
              sportCat: setting.arguments as SportCategoryModel,
            ),
        RouteList.playgroundDetailScreen: (context) => PlaygroundDetailScreen(
              playgroundId: (setting.arguments as Map<String, dynamic>)['playgroundId'],
              publicOrPrivate: (setting.arguments as Map<String, dynamic>)['publicOrPrivate'],
            ),
        RouteList.matchDetailsScreen: (context) => MatchDetailsScreen(
              matchId: (setting.arguments as Map<String, dynamic>)['matchId'],
            ),
        RouteList.summaryScreen: (context) => SummaryScreen(
              creationParams: (setting.arguments as Map<String, dynamic>)['creationParams'],
              playground: (setting.arguments as Map<String, dynamic>)['playground'],
              publicPrivateType: (setting.arguments as Map<String, dynamic>)['publicPrivateType'],
              duration: (setting.arguments as Map<String, dynamic>)['duration'],
              playersPerTeam: (setting.arguments as Map<String, dynamic>)['playersPerTeam'],
              startDate: (setting.arguments as Map<String, dynamic>)['startDate'],
              teamAPlayer: (setting.arguments as Map<String, dynamic>)['teamAPlayer'],
              teamBPlayer: (setting.arguments as Map<String, dynamic>)['teamBPlayer'],
              players: (setting.arguments as Map<String, dynamic>)['players'],
            ),
        RouteList.addPlayerPlaymentAmountScreen: (context) => AddPLayerAmountScreen(
              totalPrice: (setting.arguments as Map<String, dynamic>)['totalPrice'],
              playersPerTeam: (setting.arguments as Map<String, dynamic>)['playersPerTeam'],
              players: (setting.arguments as Map<String, dynamic>)['players'],
              teamAPlayer: (setting.arguments as Map<String, dynamic>)['teamAPlayer'],
              teamBPlayer: (setting.arguments as Map<String, dynamic>)['teamBPlayer'],
              summaryCubit: (setting.arguments as Map<String, dynamic>)['summaryCubit'],
            ),
        RouteList.addScoreScreen: (context) => const AddScoreScreen(),
        RouteList.chatDetails: (context) => ChatDiscussionScreen(
              match: (setting.arguments as Map<String, dynamic>)['match'],
              friend: (setting.arguments as Map<String, dynamic>)['friend'],
            ),
        RouteList.homeBottomTabbar: (context) => const HomeBottomTabbar(),
        RouteList.teamsPickerScreen: (context) => TeamsPickerScreen(
              playground: (setting.arguments as Map<String, dynamic>)['playground'],
              publicOrPrivate: (setting.arguments as Map<String, dynamic>)['publicOrPrivate'],
              playerCount: (setting.arguments as Map<String, dynamic>)['players_count'],
              sportType: (setting.arguments as Map<String, dynamic>)['sport_type'],
              params: (setting.arguments as Map<String, dynamic>)['params'],
            ),
        RouteList.profileSettings: (context) => const ProfileSettings(),
        RouteList.profileScreen: (context) => const MyProfileScreen(),
        RouteList.matchPaymentScreen: (context) => MatchPaymentScreen(
              amount: (setting.arguments as Map<String, dynamic>)['amount'],
              matchId: (setting.arguments as Map<String, dynamic>)['matchId'],
            ),
        RouteList.changePasswordScreen: (context) => const ChangePasswordScreen(),
        RouteList.favPlaygroundsScreen: (context) => FavPlaygroundsScreen(),
        RouteList.createMatch: (context) => CreateMatchScreen(
              playground: (setting.arguments as Map<String, dynamic>)['playground'],
              publicOrPrivate: (setting.arguments as Map<String, dynamic>)['publicOrPrivate'],
            ),
        RouteList.creditCardForm: (context) => DibsyCreditCard(
              paymentCubit: (setting.arguments as Map<String, dynamic>)['paymentCubit'],
            ),
        RouteList.webviewPaymentScreen: (context) => WebviewPaymentScreen(
              checkoutUrl: (setting.arguments as Map<String, dynamic>)['checkoutUrl'],
            ),
        RouteList.successPaymentScreen: (context) => const SuccessPaymentScreen(),
        //RouteList.ebChatScreen: (context) => const EbChatScreen(),
        RouteList.userPaymentCardsScreen: (context) => PaymentCardsScreen(),
        RouteList.homeSearchScreen: (context) => HomeSearchScreen(
              homeSportCats: (setting.arguments as Map<String, dynamic>)['homeSportCats'],
            ),
        RouteList.availablePublicMatchesShowAll: (context) => const PublicMatchesShowAllScreen(),
        RouteList.forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
      };
}
