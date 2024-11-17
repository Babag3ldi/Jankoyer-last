class LigaModel {
  String title;
  String image;

  LigaModel({
    required this.title,
    required this.image,
  });
}

List<LigaModel> ligaList =[
  LigaModel(title: 'Turkmenistanyn Futbol Super Ligasy', image: 'assets/images/liga1.png'),
  LigaModel(title: 'Turkmenistanyn Futzal Super Ligasy', image: 'assets/images/liga2.png')
];