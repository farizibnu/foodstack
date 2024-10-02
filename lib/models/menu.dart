class Menu {
  String name;
  String description;
  String time;
  String rating;
  String calorie;
  String status;
  String imageAsset;
  double price;

  Menu({
    required this.name,
    required this.description,
    required this.time,
    required this.rating,
    required this.calorie,
    required this.status,
    required this.imageAsset,
    required this.price
  });
}

var menuData = [
  Menu(
    name: "Grilled Chicken Salad",
    description: "Fresh salad with grilled chicken, avocado, and vinaigrette dressing.",
    time: "15 min",
    rating: "4.5",
    calorie: "350 kcal",
    status: "Available",
    imageAsset: "assets/images/grilled_chicken_salad.jpg",
    price: 12.99,
  ),
  Menu(
    name: "Spaghetti Carbonara",
    description: "Classic Italian pasta dish with creamy sauce and pancetta.",
    time: "20 min",
    rating: "4.7",
    calorie: "550 kcal",
    status: "Available",
    imageAsset: "assets/images/spaghetti_carbonara.jpg",
    price: 14.99,
  ),
  Menu(
    name: "Vegetarian Pizza",
    description: "Thin crust pizza loaded with vegetables and mozzarella cheese.",
    time: "25 min",
    rating: "4.2",
    calorie: "600 kcal",
    status: "Available",
    imageAsset: "assets/images/vegetarian_pizza.jpg",
    price: 13.99,
  ),
  Menu(
    name: "Beef Burger",
    description: "Juicy beef patty with lettuce, tomato, and cheddar cheese in a sesame bun.",
    time: "10 min",
    rating: "4.8",
    calorie: "700 kcal",
    status: "Unavailable",
    imageAsset: "assets/images/beef_burger.jpg",
    price: 10.99,
  ),
  Menu(
    name: "Chicken Caesar Wrap",
    description: "Tortilla wrap with grilled chicken, romaine lettuce, and Caesar dressing.",
    time: "10 min",
    rating: "4.4",
    calorie: "400 kcal",
    status: "Available",
    imageAsset: "assets/images/chicken_caesar_wrap.jpg",
    price: 9.99,
  ),
  Menu(
    name: "Vegan Buddha Bowl",
    description: "Nourishing bowl with quinoa, chickpeas, avocado, and tahini dressing.",
    time: "12 min",
    rating: "4.6",
    calorie: "450 kcal",
    status: "Available",
    imageAsset: "assets/images/vegan_buddha_bowl.jpg",
    price: 11.99,
  ),
  Menu(
    name: "Sushi Platter",
    description: "Assorted sushi rolls with fresh fish, avocado, and pickled ginger.",
    time: "30 min",
    rating: "4.9",
    calorie: "300 kcal",
    status: "Available",
    imageAsset: "assets/images/sushi_platter.jpg",
    price: 19.99,
  ),
  Menu(
    name: "Pancakes with Maple Syrup",
    description: "Fluffy pancakes served with butter and maple syrup.",
    time: "15 min",
    rating: "4.3",
    calorie: "520 kcal",
    status: "Unavailable",
    imageAsset: "assets/images/pancakes_maple_syrup.jpg",
    price: 8.99,
  ),
  Menu(
    name: "Tacos al Pastor",
    description: "Corn tortillas filled with marinated pork, pineapple, and cilantro.",
    time: "10 min",
    rating: "4.8",
    calorie: "400 kcal",
    status: "Available",
    imageAsset: "assets/images/tacos_al_pastor.jpg",
    price: 10.99,
  ),
  Menu(
    name: "Chocolate Lava Cake",
    description: "Rich chocolate cake with a molten center, served with vanilla ice cream.",
    time: "20 min",
    rating: "4.9",
    calorie: "650 kcal",
    status: "Available",
    imageAsset: "assets/images/chocolate_lava_cake.jpg",
    price: 7.99,
  ),
];