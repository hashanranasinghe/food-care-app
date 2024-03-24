class FilterModel {
  bool? sortByCloset;
  String? category;
  String? hours;
  int? filterCount;
  FilterModel(
      {required this.sortByCloset,
      required this.filterCount,
      this.category,
      this.hours});
}
