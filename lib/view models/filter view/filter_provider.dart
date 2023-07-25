import 'package:flutter/foundation.dart';

import '../../models/filterModel.dart';

class FilterProvider extends ChangeNotifier {
  FilterModel _filter = FilterModel(sortByCloset: false,filterCount: 0);

  FilterModel get filter => _filter;

  void setFilter(FilterModel newFilter) {
    _filter = newFilter;
    notifyListeners();
  }
}
