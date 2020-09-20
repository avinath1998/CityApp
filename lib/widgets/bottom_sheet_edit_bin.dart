import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/tagged_bins/tagged_bins_bloc.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

class BottomSheetEditBin extends StatefulWidget {
  final TaggedBin bin;
  final ScrollController scrollController;
  const BottomSheetEditBin({Key key, this.bin, this.scrollController})
      : super(key: key);
  @override
  _BottomSheetEditBinState createState() => _BottomSheetEditBinState();
}

class _BottomSheetEditBinState extends State<BottomSheetEditBin> {
  final Logger logger = Logger("BottomSheetEditBinState");
  TaggedBinsBloc _taggedBinsBloc;
  TaggedBin _currentBin;

  @override
  void initState() {
    super.initState();
    _currentBin = widget.bin.copyWith();
    _taggedBinsBloc = TaggedBinsBloc(GetIt.instance<DataRepository>());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      margin: const EdgeInsets.only(top: 70.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30.0)),
      ),
      child: Form(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30.0)),
          child: Container(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<TaggedBinsBloc, TaggedBinsState>(
                cubit: _taggedBinsBloc,
                builder: (context, state) {
                  logger.info(state);
                  if (state is UploadFailedTaggedBinState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("An error has occured, try again"),
                      ],
                    );
                  } else if (state is UploadSucessTaggedBinState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Bin successfully updated.",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          "Your bin's name has been changed to ${_currentBin.binName}",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RaisedButton(
                              child: Text("Ok"),
                              onPressed: () {
                                Navigator.of(context).pop(_currentBin);
                              },
                            )
                          ],
                        )
                      ],
                    );
                  } else if (state is UploadingTaggedBinState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Edit Your Bin",
                            style: Theme.of(context).textTheme.headline5),
                        Text(
                          "Bin: ${_currentBin.binName}",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodyText1,
                          initialValue: widget.bin.binName,
                          decoration: InputDecoration(labelText: "Name"),
                          validator: (val) {
                            if (val == "") {
                              return "Enter a valid email.";
                            }
                          },
                          onSaved: (val) {
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FlatButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop(widget.bin);
                              },
                            ),
                            RaisedButton(
                              child: Text("Ok"),
                              onPressed: () {
                                _taggedBinsBloc.add(EditTaggedBinEvent(
                                    BlocProvider.of<AuthBloc>(context)
                                        .currentUser,
                                    _currentBin));
                              },
                            )
                          ],
                        )
                      ],
                    );
                  }
                },
              )),
        ),
      ),
    ));
  }
}
