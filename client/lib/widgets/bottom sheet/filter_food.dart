import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/filterModel.dart';
import '../../utils/constraints.dart';
import '../../view models/filter view/filter_provider.dart';
import '../../view models/food post view/food_post_list_view_model.dart';
import '../buttons.dart';
import '../checkbox.dart';
import '../divider.dart';

class FilterFood extends StatefulWidget {
  const FilterFood({Key? key}) : super(key: key);

  @override
  State<FilterFood> createState() => _FilterFoodState();
}

class _FilterFoodState extends State<FilterFood> {
  bool sortByCloset = false;
  int filterCount = 0;
  final List<String> _categories = [
    'Fruits',
    'Vegetables',
    'Cooked',
    'Short-Eats',
  ];
  final List<String> _hours = [
    '1 hour',
    '2 hour',
    '3 hour',
    '4 hour',
    '19 hour',
  ];
  String? _selectCategory;
  String? _selectedHour;
  late FoodPostListViewModel _foodPostListViewModel;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _populateFilter();
  }

  void _populateFilter() {
    _foodPostListViewModel =
        Provider.of<FoodPostListViewModel>(context, listen: false);
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    final filter = filterProvider.filter;
    setState(() {
      if (filter.sortByCloset != null) {
        sortByCloset = filter.sortByCloset!;
      }
      if (filter.category != null) {
        _selectCategory = filter.category;
      }
      if (filter.hours != null) {
        _selectedHour = filter.hours;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () async {
                    filterProvider.clearFilter();
                    await _foodPostListViewModel.getAllFoodPosts();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.delete_forever_outlined),
                ),
                Text(
                  "Food Filter",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            const DividerWidget(),
            Text(
              "Sort by",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Closet"),
                CustomCheckBox(
                  checkedFillColor: kBNavigationColorDark,
                  value: sortByCloset,
                  onChanged: (value) {
                    setState(() {
                      sortByCloset = value;
                    });
                  },
                ),
              ],
            ),
            const DividerWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select category",
                    style: TextStyle(color: Colors.black),
                  ),
                  _getCategoriesDropDown()
                ],
              ),
            ),
            const DividerWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "List for",
                    style: TextStyle(color: Colors.black),
                  ),
                  _getDaysDropDown(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Genaralbutton(
                pleft: 100,
                pright: 100,
                onpress: () async {
                  getFilterCounter();
                  final newFilter = FilterModel(
                      sortByCloset: sortByCloset,
                      filterCount: filterCount,
                      category: _selectCategory,
                      hours: _selectedHour);
                  filterProvider.setFilter(newFilter);
                  await _foodPostListViewModel.getAllFilterFoodPosts(newFilter);
                  Navigator.pop(context);
                },
                text: "Apply",
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getFilterCounter() {
    if (sortByCloset == true) {
      setState(() {
        filterCount++;
      });
    }
    if (_selectCategory != null) {
      setState(() {
        filterCount++;
      });
    }
    if (_selectedHour != null) {
      setState(() {
        filterCount++;
      });
    }
  }

  _getCategoriesDropDown() {
    return DropdownButton(
      hint: Text('Select'),
      value: _selectCategory,
      onChanged: (newValue) {
        setState(() {
          _selectCategory = newValue.toString();
        });
      },
      items: _categories.map((category) {
        return DropdownMenuItem(
          child: new Text(category),
          value: category,
        );
      }).toList(),
    );
  }

  _getDaysDropDown() {
    return DropdownButton(
      hint: Text('Select'),
      value: _selectedHour,
      onChanged: (newValue) {
        setState(() {
          _selectedHour = newValue.toString();
        });
      },
      items: _hours.map((day) {
        return DropdownMenuItem(
          child: new Text(day),
          value: day,
        );
      }).toList(),
    );
  }
}
