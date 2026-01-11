import 'repositories/user_repository.dart';
import 'repositories/event_repository.dart';
import 'repositories/store_repository.dart';
import 'repositories/room_repository.dart';
import 'repositories/venue_repository.dart';
import 'repositories/ticket_repository.dart';
import 'repositories/user_in_venue_repository.dart';
import 'repositories/promotion_repository.dart';
import 'repositories/venue_layout_repository.dart';
import 'repositories/room_live_chat_repository.dart';
import 'repositories/group_invite_repository.dart';

/// Simple Service Locator registry.
/// Usage: Locator.userRepo.getUserProfile(...)
class Locator {
  static final Locator _instance = Locator._internal();
  factory Locator() => _instance;
  Locator._internal();

  // Lazy singletons
  static final UserRepository userRepo = UserRepository();
  static final EventRepository eventRepo = EventRepository();
  static final StoreRepository storeRepo = StoreRepository();
  static final RoomRepository roomRepo = RoomRepository();
  static final VenueRepository venueRepo = VenueRepository();
  static final TicketRepository ticketRepo = TicketRepository();
  static final UserInVenueRepository userInVenueRepo = UserInVenueRepository();
  static final PromotionRepository promotionRepo = PromotionRepository();
  static final VenueLayoutRepository venueLayoutRepo = VenueLayoutRepository();
  static final RoomLiveChatRepository roomLiveChatRepo = RoomLiveChatRepository();
  static final GroupInviteRepository groupInviteRepo = GroupInviteRepository();
}
