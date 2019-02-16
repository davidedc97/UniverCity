import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/elements/bottom_sheet_upload.dart';

//############################################################################## Fab home STATELESS
class MainFab extends StatelessWidget {
  final BuildContext _contextSc;
  MainFab(this._contextSc);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        //backgroundColor: Colors.grey[900],
        icon: Icon(Icons.add),
        label: Text('UPLOAD'),
        onPressed: () {
          debugPrint('FAB home pressed');
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => BottomSheetUpload(_contextSc));
        });
  }
}
