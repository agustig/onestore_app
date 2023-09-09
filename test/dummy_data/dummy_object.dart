import 'package:flutter_store_fic7/data/models/api_response_model.dart';
import 'package:flutter_store_fic7/data/models/auth_model.dart';
import 'package:flutter_store_fic7/data/models/user_model.dart';
import 'package:flutter_store_fic7/domain/entities/auth.dart';
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
