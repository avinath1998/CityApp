import 'package:citycollection/exceptions/DataFetchException.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/prize.dart';
import 'package:citycollection/models/prize_redemption_status.dart';
import 'package:citycollection/networking/db.dart';

class DataRepository {
  final DB db;
  final List<Prize> cachedPrizes = List();
  double redeemPageScrollPosition = 0;
  DataRepository(this.db);

  Future<CurrentUser> fetchCurrentUser(String id) {
    try {
      return db.fetchCurrentUser(id);
    } catch (e) {
      throw DataFetchException(e.toString());
    }
  }

  Future<PrizeRedemptionStatus> redeemPrize(
      Prize prize, CurrentUser user) async {
    try {
      return await db.redeemPrize(prize, user);
    } catch (e) {
      throw DataFetchException(e.toString());
    }
  }

  Future<List<Prize>> fetchPrizes() async {
    try {
      List<Prize> prizes = await db.fetchPrizes();
      print(prizes.length);
      prizes.forEach((prize) {
        print(prize.id);
        if (!cachedPrizes.contains(prize)) {
          cachedPrizes.add(prize);
          print("ADDED");
        }
      });
      return prizes;
    } catch (e) {
      throw DataFetchException(e.toString());
    }
  }
}
