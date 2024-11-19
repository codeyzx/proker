import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/api/api_url.dart';
import 'package:proker/src/core/constants/app_constants.dart';
import 'package:proker/src/core/errors/exceptions.dart';
import 'package:proker/src/core/utils/logger.dart';
import 'package:proker/src/features/auth/data/models/login_model.dart';
import 'package:proker/src/features/auth/data/models/register_model.dart';
import 'package:proker/src/features/auth/data/models/user_model.dart';

@factoryMethod
sealed class AuthRemoteDataSource {
  Future<UserModel> login(LoginModel model);
  Future<void> logout();
  Future<void> register(RegisterModel model);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this.fbAuth, this.googleSignIn, this.fbChatCore);
  final FirebaseAuth fbAuth;
  final GoogleSignIn googleSignIn;
  final FirebaseChatCore fbChatCore;

  @override
  Future<UserModel> login(LoginModel model) async {
    try {
      final userCred = await fbAuth.signInWithEmailAndPassword(
        email: model.email ?? "",
        password: model.password ?? "",
      );

      final userResult = userCred.user;
      if (userResult == null) throw AuthException();

      final user = await _getUserByEmail(model.email ?? "");
      return user;
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e(e);
      if (e.toString() == noElement) {
        throw AuthException();
      }
      throw ServerException();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> register(RegisterModel model) async {
    try {
      final user = await _getUserByEmail(model.email ?? "");
      if (user.email == model.email) {
        throw DuplicateEmailException();
      }

      return;
    } on EmptyException {
      await ApiUrl.users.add(model.toMap());
    } on DuplicateEmailException {
      rethrow;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  Future<UserModel> _getUserByEmail(String email) async {
    try {
      final result = await ApiUrl.users.where("email", isEqualTo: email).get();
      final doc = result.docs.first;
      final user = UserModel.fromJson(doc.data(), doc.id);

      return user;
    } catch (e) {
      if (e.toString() == noElement) {
        throw EmptyException();
      }
      logger.e(e);
      throw ServerException();
    }
  }
}
