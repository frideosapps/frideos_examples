class Product {
  const Product({this.name, this.price});

  final String name;
  final double price;
}

const products = {
  112: Product(name: 'Phone', price: 230.59),
  19: Product(name: 'Shirt', price: 30.49),
  812: Product(name: 'Guitar', price: 800.69),
  139: Product(name: 'Headphones', price: 200.99),
  12: Product(name: 'Shoes', price: 90.89),
  136: Product(name: 'PC', price: 786.99),
  101: Product(name: 'Apple', price: 0.99)
};
