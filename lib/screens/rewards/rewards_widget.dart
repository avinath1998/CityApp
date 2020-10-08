import 'package:cached_network_image/cached_network_image.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/redeem/redeem_bloc.dart';
import 'package:citycollection/blocs/redeem_prize/redeem_prize_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/dialogs/redeem_dialog.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/prize.dart';
import 'package:citycollection/networking/repositories/data_repository.dart';
import 'package:citycollection/widgets/button_error_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';

import '../me/redemptions_screen.dart';

class RedeemTab extends StatefulWidget {
  final ScrollController scrollController;

  const RedeemTab({Key key, this.scrollController}) : super(key: key);
  @override
  _RedeemTabState createState() => _RedeemTabState();
}

class _RedeemTabState extends State<RedeemTab> {
  final RedeemBloc _redeemBloc = RedeemBloc();
  final RedeemPrizeBloc _prizeRedeemBloc = RedeemPrizeBloc();
  ScrollController _scrollController;
  CurrentUser _currentUser;
  bool _isLoading = false;
  String _loadingUserError;
  final Logger logger = Logger("RedeemTabState");

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _redeemBloc.add(FetchPrizesEvent());
      BlocProvider.of<AuthBloc>(context).add(
          LoadUserEvent(BlocProvider.of<AuthBloc>(context).currentUser, false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthUpdatedState) {
                setState(() {
                  _currentUser = state.user;
                });
              } else if (state is AuthUpdateFailedState) {
                setState(() {
                  _loadingUserError = "An error has occured, try again";
                });
              }
            },
            child: LayoutBuilder(builder: (context, constraints) {
              if (_loadingUserError != null) {
                ButtonErrorRefresh(
                  errorMsg: "An error has occured, try again",
                  onRefreshTapped: () {
                    logger.info("Refresh tapped");
                  },
                );
              } else if (_currentUser == null) {
                return Center(child: CircularProgressIndicator());
              }
              return BlocProvider(
                  create: (context) => _redeemBloc,
                  child: BlocBuilder<RedeemBloc, RedeemState>(
                    builder: (context, state) {
                      if (state is RedeemPrizesFetchedState) {
                        return _buildList(state.prizes);
                      } else if (state is RedeemPrizesWaitingState) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: CityColors.primary_green,
                          ),
                        );
                      } else if (state is RedeemLoadingFailedState) {
                        return Center(
                          child: Text(
                              "Oops, an error has occured, try again later."),
                        );
                      } else if (state is RedeemInitial) {
                        if (state.prizes.length == 0) {
                          return Center(
                              child: CircularProgressIndicator(
                            backgroundColor: CityColors.primary_green,
                          ));
                        } else
                          return _buildList(state.prizes);
                      }
                    },
                  ));
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<Prize> prizes) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.card_giftcard,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    color: CityColors.primary_teal,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverAppBar(
          backgroundColor: Colors.white,
          snap: false,
          automaticallyImplyLeading: false,
          pinned: true,
          floating: false,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Your Ekva Points: " +
                    "${BlocProvider.of<AuthBloc>(context).currentUser.points}",
                style: Theme.of(context).textTheme.headline5,
              )
            ],
          ),
        ),
        SliverStickyHeader(
          header: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 0.3,
                  color: Colors.black12,
                  offset: Offset(0.0, 0.0)),
            ]),
            padding: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Prizes",
                  style: Theme.of(context).textTheme.headline5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(RedemptionsScreen.routeName);
                  },
                  child: Text(
                    "See Your Redemptions",
                    style: Theme.of(context).accentTextTheme.button,
                  ),
                ),
              ],
            ),
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildPrizeCard(
                    prizes.where((i) => i.type == "code").toList()[index]),
              );
            },
                childCount:
                    prizes.where((i) => i.type == "code").toList().length),
          ),
        )
      ],
    );
  }

  Widget buildPrizeCard(Prize prize) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: prize.image,
              placeholder: (context, url) => CircularProgressIndicator(
                backgroundColor: CityColors.primary_green,
              ),
              imageBuilder: (context, provider) {
                return Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image:
                          DecorationImage(fit: BoxFit.cover, image: provider)),
                );
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    prize.name,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.start,
                  ),
                  Divider(),
                  Text(
                    prize.desc,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      "${prize.cost} Ekva Points",
                    ),
                  ),
                  BlocProvider.of<AuthBloc>(context).currentUser.points >=
                          prize.cost
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: RaisedButton(
                                onPressed: () {
                                  _showRedemptionConfirmation(
                                      prize,
                                      BlocProvider.of<AuthBloc>(context)
                                          .currentUser);
                                },
                                child: Text(
                                  "Redeem",
                                ),
                              )),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Not Enough Ekva Points",
                            ),
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showRedemptionConfirmation(
    Prize prize,
    CurrentUser user,
  ) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return RedeemDialog(
            prize: prize,
            user: user,
            onRedeemed: () {
              BlocProvider.of<AuthBloc>(context).add(LoadUserEvent(
                  BlocProvider.of<AuthBloc>(context).currentUser, true));
            },
          );
        });
  }
}
