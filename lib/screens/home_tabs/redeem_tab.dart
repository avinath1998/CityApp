import 'package:cached_network_image/cached_network_image.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/redeem/redeem_bloc.dart';
import 'package:citycollection/blocs/redeem_prize/redeem_prize_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/prize.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class RedeemTab extends StatefulWidget {
  @override
  _RedeemTabState createState() => _RedeemTabState();
}

class _RedeemTabState extends State<RedeemTab> {
  final RedeemBloc _redeemBloc = RedeemBloc();
  final RedeemPrizeBloc _prizeRedeemBloc = RedeemPrizeBloc();
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
        initialScrollOffset:
            GetIt.instance<DataRepository>().redeemPageScrollPosition);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _redeemBloc.add(FetchPrizesEvent());
    });
    _scrollController.addListener(() {
      GetIt.instance<DataRepository>().redeemPageScrollPosition =
          _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocProvider(
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
                  child: Text("Oops, an error has occured, try again later."),
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
          )),
    );
  }

  Widget _buildList(List<Prize> prizes) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
            backgroundColor: Colors.white,
            snap: true,
            floating: true,
            title: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Your", style: Theme.of(context).textTheme.display2),
                TextSpan(
                    text: "City", style: Theme.of(context).textTheme.display1),
                TextSpan(
                    text: "Points: ",
                    style: Theme.of(context).textTheme.display2),
                TextSpan(
                    text:
                        "${BlocProvider.of<AuthBloc>(context).currentUser.points}",
                    style: Theme.of(context).textTheme.display1)
              ]),
            )),
        SliverStickyHeader(
          header: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 0.3,
                  color: Colors.black12,
                  offset: Offset(0.0, 0.0)),
            ]),
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            child: Text(
              "Cash",
              style: Theme.of(context).textTheme.display3,
            ),
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildPrizeCard(prizes
                        .where((i) => i.type == "cash")
                        .toList()[
                    index]), //change this to be more performant, it should'nt filter the entire list, cannot scale well
              );
            },
                childCount:
                    prizes.where((i) => i.type == "cash").toList().length),
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
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            child: Text(
              "Prizes",
              style: Theme.of(context).textTheme.display3,
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
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(1.0, 1.0),
                blurRadius: 1.0,
                spreadRadius: 1.0)
          ],
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
                    image: DecorationImage(fit: BoxFit.cover, image: provider)),
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
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                Divider(),
                Text(
                  prize.desc,
                  style: GoogleFonts.poppins(
                      fontSize: 13.0, fontWeight: FontWeight.normal),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "${prize.cost} CityPoints",
                    style: GoogleFonts.poppins(
                        fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                BlocProvider.of<AuthBloc>(context).currentUser.points >=
                        prize.cost
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              color: CityColors.primary_green,
                              onPressed: () {
                                _showRedemptionConfirmation(
                                    prize,
                                    BlocProvider.of<AuthBloc>(context)
                                        .currentUser);
                              },
                              child: Text(" Redeem",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white)),
                            )),
                      )
                    : Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Not Enough CityPoints",
                            style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showRedemptionConfirmation(
    Prize prize,
    CurrentUser user,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            key: Key(prize.id),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: prize.image,
                    imageBuilder: (context, provider) {
                      return Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover, image: provider)),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      prize.name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      prize.desc,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 13.0),
                    ),
                  ),
                  BlocBuilder(
                      bloc: _prizeRedeemBloc,
                      builder: (context, state) {
                        if (state is RedeemPrizeInitial) {
                          return MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            color: CityColors.primary_green,
                            onPressed: () {
                              _prizeRedeemBloc
                                  .add(RedeemCityPrizeEvent(prize, user));
                            },
                            child: Text("Confirm Redemption",
                                style:
                                    GoogleFonts.poppins(color: Colors.white)),
                          );
                        } else if (state is PrizeRedeemedWaitingState) {
                          return CircularProgressIndicator(
                            backgroundColor: CityColors.primary_green,
                          );
                        } else if (state is PrizeRedeemedFailedState) {
                          return Text(state.errorMsg,
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 15.0));
                        } else if (state is PrizeRedeemedSuccessState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                padding: const EdgeInsets.all(20.0),
                                margin: const EdgeInsets.only(
                                    bottom: 20.0, top: 10.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CityColors.primary_green,
                                ),
                              ),
                              Text(
                                  "Redeem request sent, check back again to get the code.",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 15.0)),
                            ],
                          );
                        }
                      })
                ])),
          );
        });
  }
}
