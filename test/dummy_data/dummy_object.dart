import 'package:flutter_store_fic7/data/models/api_response_model.dart';
import 'package:flutter_store_fic7/data/models/auth_model.dart';
import 'package:flutter_store_fic7/data/models/category_model.dart';
import 'package:flutter_store_fic7/data/models/collection_model.dart';
import 'package:flutter_store_fic7/data/models/product_model.dart';
import 'package:flutter_store_fic7/data/models/user_model.dart';
import 'package:flutter_store_fic7/domain/entities/auth.dart';
import 'package:flutter_store_fic7/domain/entities/category.dart';
import 'package:flutter_store_fic7/domain/entities/collection.dart';
import 'package:flutter_store_fic7/domain/entities/product.dart';
import 'package:flutter_store_fic7/domain/entities/user.dart';

const testUserModel = UserModel(
  id: 14,
  name: 'Mr. Manuela Zboncak III',
  email: 'marlee.ledner@example.net',
  role: 'user',
  phone: '(254) 980-1633',
  bio:
      'Non excepturi animi qui velit. Rerum repellendus iste eveniet consequuntur aut sapiente a. Repudiandae sed ullam aut.',
);

const testUser = User(
  id: 14,
  name: 'Mr. Manuela Zboncak III',
  email: 'marlee.ledner@example.net',
  role: 'user',
  phone: '(254) 980-1633',
  bio:
      'Non excepturi animi qui velit. Rerum repellendus iste eveniet consequuntur aut sapiente a. Repudiandae sed ullam aut.',
);

const testUserModelShort = UserModel(
  id: 14,
  name: 'Mr. Manuela Zboncak III',
);

const testUserShort = User(
  id: 14,
  name: 'Mr. Manuela Zboncak III',
);

const testAuthModel = AuthModel(
  token: '10|u6sQ2kPzzuLxrXaDYlVwxJ5ZCTmA6ysWNYUV7HS41351e4df',
  user: testUserModelShort,
);

const testAuth = Auth(
  token: '10|u6sQ2kPzzuLxrXaDYlVwxJ5ZCTmA6ysWNYUV7HS41351e4df',
  user: testUserShort,
);

const testApiResponse = ApiResponseModel(
  status: 200,
  message: 'Login successfully',
  data: {
    "auth_token": "10|u6sQ2kPzzuLxrXaDYlVwxJ5ZCTmA6ysWNYUV7HS41351e4df",
    "user": {"id": 14, "name": "Mr. Manuela Zboncak III"},
  },
);

const testAuthRegisterData = {
  'name': 'Mr. Manuela Zboncak III',
  'email': 'marlee.ledner@example.net',
  'password': 'password',
  'password_confirmation': 'password',
};

const testAuthLoginData = {
  'email': 'marlee.ledner@example.net',
  'password': 'password',
};

const testProductModelShort = ProductModel(
  id: 7,
  name: 'Quos ad.',
  description:
      'Et omnis voluptas et perspiciatis inventore quis ut. Alias corporis maxime nostrum nulla sit. Consequatur sit ea ab dolorem non aut porro. Alias amet deleniti eaque voluptas omnis fugiat.',
  price: '155998',
  imageUrl: 'https://via.placeholder.com/200x200.png/00dd66?text=inventore',
);

const testProductShort = Product(
  id: 7,
  name: 'Quos ad.',
  description:
      'Et omnis voluptas et perspiciatis inventore quis ut. Alias corporis maxime nostrum nulla sit. Consequatur sit ea ab dolorem non aut porro. Alias amet deleniti eaque voluptas omnis fugiat.',
  price: '155998',
  imageUrl: 'https://via.placeholder.com/200x200.png/00dd66?text=inventore',
);

final testCategoryModelDetail = CategoryModel(
  id: 1,
  name: 'minus',
  description: 'Aut voluptatibus numquam.',
  products: const [testProductModelShort],
  createdAt: DateTime.parse('2023-09-05T04:48:37.000000Z'),
  updatedAt: DateTime.parse('2023-09-05T04:48:37.000000Z'),
);

final testCategoryDetail = Category(
  id: 1,
  name: 'minus',
  description: 'Aut voluptatibus numquam.',
  products: const [testProductShort],
  createdAt: DateTime.parse('2023-09-05T04:48:37.000000Z'),
  updatedAt: DateTime.parse('2023-09-05T04:48:37.000000Z'),
);

const testUserModel2 = UserModel(id: 19, name: 'Pattie McCullough');

const testUser2 = User(id: 19, name: 'Pattie McCullough');

const testCategoryModelShort = CategoryModel(
  id: 1,
  name: 'minus',
  description: 'Aut voluptatibus numquam.',
);

const testCategoryShort = Category(
  id: 1,
  name: 'minus',
  description: 'Aut voluptatibus numquam.',
);

final testProductModelDetail = ProductModel(
  id: 7,
  name: 'Quos ad.',
  description:
      'Et omnis voluptas et perspiciatis inventore quis ut. Alias corporis maxime nostrum nulla sit. Consequatur sit ea ab dolorem non aut porro. Alias amet deleniti eaque voluptas omnis fugiat.',
  price: '155998',
  imageUrl: 'https://via.placeholder.com/200x200.png/00dd66?text=inventore',
  seller: testUserModel2,
  category: testCategoryModelShort,
  createdAt: DateTime.parse('2023-09-05T04:48:38.000000Z'),
  updatedAt: DateTime.parse('2023-09-05T04:48:38.000000Z'),
);

final testProductDetail = Product(
  id: 7,
  name: 'Quos ad.',
  description:
      'Et omnis voluptas et perspiciatis inventore quis ut. Alias corporis maxime nostrum nulla sit. Consequatur sit ea ab dolorem non aut porro. Alias amet deleniti eaque voluptas omnis fugiat.',
  price: '155998',
  imageUrl: 'https://via.placeholder.com/200x200.png/00dd66?text=inventore',
  seller: testUser2,
  category: testCategoryShort,
  createdAt: DateTime.parse('2023-09-05T04:48:38.000000Z'),
  updatedAt: DateTime.parse('2023-09-05T04:48:38.000000Z'),
);

const testCategoryCollectionModel = CollectionModel(
  collectionNumber: 1,
  collections: [testCategoryModelShort],
  totalCollections: 1,
);

const testCategoryCollection = Collection(
  collectionNumber: 1,
  collections: [testCategoryShort],
  totalCollections: 1,
);

const testProductCollectionModel = CollectionModel(
  collectionNumber: 1,
  collections: [testProductModelShort],
  totalCollections: 10,
);

const testProductCollection = Collection(
  collectionNumber: 1,
  collections: [testProductShort],
  totalCollections: 10,
);
