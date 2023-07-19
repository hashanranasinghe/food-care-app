import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/filterModel.dart';
import '../utils/constraints.dart';
import '../view models/filter view/filter_provider.dart';
import '../view models/food post view/food_post_list_view_model.dart';
import 'buttons.dart';
import 'checkbox.dart';

class FilterFood extends StatefulWidget {
  const FilterFood({Key? key}) : super(key: key);

  @override
  State<FilterFood> createState() => _FilterFoodState();
}

class _FilterFoodState extends State<FilterFood> {
  bool sortByCloset = false;
  late FoodPostListViewModel _foodPostListViewModel;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _populateFilter();
  }

  void _populateFilter() {
    _foodPostListViewModel =
        Provider.of<FoodPostListViewModel>(context, listen: false);
    final filterProvider = Provider.of<FilterProvider>(context,listen: false);
    final filter = filterProvider.filter;
    setState(() {
      if (filter.sortByCloset != null) {
        sortByCloset = filter.sortByCloset!;
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
                Container(),
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
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            Text(
              "Maximum Distance",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ColorChangeButton(
                    onpress: () {},
                    text: "All",
                    ptop: 5,
                    pbottom: 5,
                    pleft: 25,
                    pright: 25,
                  ),
                  ColorChangeButton(
                    onpress: () {},
                    text: "Available only",
                    ptop: 5,
                    pbottom: 5,
                    pleft: 25,
                    pright: 25,
                  ),
                  ColorChangeButton(
                    onpress: () {},
                    text: "Just Gone",
                    ptop: 5,
                    pbottom: 5,
                    pleft: 25,
                    pright: 25,
                  ),
                ],
              ),
            ),
            Text(
              "Item Availability",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ColorChangeButton(
                    onpress: () {},
                    text: "All",
                    ptop: 5,
                    pbottom: 5,
                    pleft: 25,
                    pright: 25,
                  ),
                  ColorChangeButton(
                    onpress: () {},
                    text: "1 km",
                    ptop: 5,
                    pbottom: 5,
                    pleft: 25,
                    pright: 25,
                  ),
                  ColorChangeButton(
                    onpress: () {},
                    text: "2 km",
                    ptop: 5,
                    pbottom: 5,
                    pleft: 25,
                    pright: 25,
                  ),
                  ColorChangeButton(
                    onpress: () {},
                    text: "5 km",
                    ptop: 5,
                    pbottom: 5,
                    pleft: 25,
                    pright: 25,
                  ),
                  ColorChangeButton(
                    onpress: () {},
                    text: "10 km",
                    ptop: 5,
                    pbottom: 5,
                    pleft: 25,
                    pright: 25,
                  ),
                ],
              ),
            ),
            Text(
              "Sort by",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Closet"),
                CustomCheckBox(
                  checkedFillColor: kBNavigationColordark,
                  value: sortByCloset,
                  onChanged: (value) {
                    setState(() {
                      sortByCloset = value;
                    });
                  },
                ),
              ],
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            Align(
              alignment: Alignment.center,
              child: Genaralbutton(
                pleft: 100,
                pright: 100,
                onpress: () async {
                  final newFilter = FilterModel(sortByCloset: sortByCloset);
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
}
