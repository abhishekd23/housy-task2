class Items {
  final List<Map<String, dynamic>> items = [
    {'label': 'App Developer', 'value': 'App Developer'},
    {'label': 'Web Developer', 'value': 'Web Developer'},
    {
      'label': 'Data Analyst',
      'value': 'Data Analyst',
    },
  ];

  List<Map<String, dynamic>> getList() {
    return items;
  }
}
