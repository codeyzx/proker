import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:proker/src/features/auth/domain/entities/user_entity.dart';

@factoryMethod
sealed class AuthRemoteDataSource {
  Future<UserModel> login(LoginModel model);
  Future<void> logout();
  Future<UserModel> register(RegisterModel model);
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
        email: model.email ?? '',
        password: model.password ?? '',
      );
      final userResult = userCred.user;
      if (userResult == null) {
        logger.e('User not found.');
        throw CustomFirebaseAuthException('User not found.');
      }

      final user = await _getUserByEmail(model.email ?? '');
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw CustomFirebaseAuthException(
              'There is no user corresponding to this email address.');
        case 'wrong-password':
          throw CustomFirebaseAuthException(
              'The password is invalid for the provided email address.');
        case 'invalid-email':
          throw CustomFirebaseAuthException('The email address is not valid.');
        case 'user-disabled':
          throw CustomFirebaseAuthException(
              'The user account has been disabled by an administrator.');
        case 'too-many-requests':
          throw CustomFirebaseAuthException(
              'Too many requests. Try again later.');
        case 'operation-not-allowed':
          throw CustomFirebaseAuthException(
              'Operation not allowed. Please enable it in the Firebase console.');
        case 'invalid-credential':
          throw CustomFirebaseAuthException(
              'The provided credential is invlid or malformed.');
        case 'account-exists-with-different-credential':
          throw CustomFirebaseAuthException(
              'The account exists with a different sign-in method.');
        case 'credential-already-in-use':
          throw CustomFirebaseAuthException(
              'The credential is already associated with a different user account.');
        default:
          throw CustomFirebaseAuthException(
              e.message ?? 'An unknown error occurred.');
      }
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e("Error: $e");
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
  Future<UserModel> register(RegisterModel model) async {
    try {
      final userCred = await fbAuth.createUserWithEmailAndPassword(
        email: model.email ?? '',
        password: model.password ?? '',
      );

      final user = userCred.user;
      if (user == null) throw CustomFirebaseAuthException('User not found.');

      await _registerUserToFirestore(user, name: model.name);
      return UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: model.name ?? user.displayName ?? '',
        firstName: model.name ?? user.displayName ?? '',
        lastName: '',
        imageUrl: user.photoURL ?? 'https://i.pravatar.cc/300',
        role: 'user',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastSeen: DateTime.now(),
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw CustomFirebaseAuthException(
              'The email address is already in use by another account.');
        case 'invalid-email':
          throw CustomFirebaseAuthException('The email address is not valid.');
        case 'weak-password':
          throw CustomFirebaseAuthException('The password is too weak.');
        case 'operation-not-allowed':
          throw CustomFirebaseAuthException(
              'Operation not allowed. Please enable it in the Firebase console.');
        case 'invalid-credential':
          throw CustomFirebaseAuthException(
              'The provided credential is invalid or malformed.');
        case 'account-exists-with-different-credential':
          throw CustomFirebaseAuthException(
              'The account exists with a different sign-in method.');
        case 'credential-already-in-use':
          throw CustomFirebaseAuthException(
              'The credential is already associated with a different user account.');
        default:
          throw CustomFirebaseAuthException(
              e.message ?? 'An unknown error occurred.');
      }
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
      final user = UserModel.fromJson(doc.data().toJson(), doc.id);

      return user;
    } catch (e) {
      if (e.toString() == noElement) {
        throw EmptyException();
      }
      logger.e(e);
      throw ServerException();
    }
  }

  Future<void> _registerUserToFirestore(User user, {String? name}) async {
    await ApiUrl.users.doc(user.uid).set(
          UserEntity.fromJson(
            {
              "id": user.uid,
              "email": user.email,
              "name": name ?? user.displayName,
              "firstName": name ?? user.displayName,
              "lastName": "",
              "imageUrl": user.photoURL ?? 'https://i.pravatar.cc/300',
              "role": "user",
              "createdAt": FieldValue.serverTimestamp(),
              "updatedAt": FieldValue.serverTimestamp(),
              "lastSeen": FieldValue.serverTimestamp(),
            },
          ),
        );
  }
}
