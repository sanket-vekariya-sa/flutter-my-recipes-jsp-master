class ItemDetailsFeed {
  final String name;
  final String photo;
  final String preparationTime;
  final String serves;
  final String complexity;

  ItemDetailsFeed(this.name, this.photo,this.preparationTime,this.serves,this.complexity) {
    if (name == null) {
      throw new ArgumentError("name of ItemDetailsFeed cannot be null. "
          "Received: '$name'");
    }
    if (photo == null) {
      throw new ArgumentError("photo of ItemDetailsFeed cannot be null. "
          "Received: '$photo'");
    }
    if (preparationTime == null) {
      throw new ArgumentError("preparationTime of ItemDetailsFeed cannot be null. "
          "Received: '$preparationTime'");
    }
    if (serves == null) {
      throw new ArgumentError("serves of ItemDetailsFeed cannot be null. "
          "Received: '$serves'");
    }
    if (complexity == null) {
      throw new ArgumentError("complexity of ItemDetailsFeed cannot be null. "
          "Received: '$complexity'");
    }
  }
}
