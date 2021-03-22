class CategoryModel {
  int categoryId;
  String name;
  String description;
  String imagePath;

  CategoryModel(this.categoryId, this.name, this.description, this.imagePath);

  get getcategoryId => this.categoryId;
  set setcategoryId(categoryId) => this.categoryId = categoryId;
  get getName => this.name;
  set setName(name) => this.name = name;
  get getdescription => this.description;
  set setdescription(description) => this.description = description;
  get getImagePath => this.imagePath;
  set setImagePath(imagePath) => this.imagePath = imagePath;
}
