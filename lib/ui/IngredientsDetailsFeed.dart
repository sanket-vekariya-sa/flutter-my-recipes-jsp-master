class IngredientsDetailsFeed {
  final String id;
  final String ingredient;


  IngredientsDetailsFeed(this.id, this.ingredient) {
    if (id == null) {
      throw new ArgumentError("id of IngredientsDetailsFeed cannot be null. "
          "Received: '$id'");
    }
    if (ingredient == null) {
      throw new ArgumentError("ingredient of IngredientsDetailsFeed cannot be null. "
          "Received: '$ingredient'");
    }
   
  }
}
