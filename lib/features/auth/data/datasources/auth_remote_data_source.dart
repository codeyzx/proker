import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/core/error/exceptions.dart';
import 'package:proker/features/auth/data/models/user_model.dart';

@factoryMethod
abstract interface class AuthRemoteDataSource {
  User? get currentUser;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuthClient;
  AuthRemoteDataSourceImpl(this.firebaseAuthClient);

  @override
  User? get currentUser => firebaseAuthClient.currentUser;

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuthClient.signInWithEmailAndPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const ServerException('User is null!');
      }
      return UserModel.fromFirebaseUser(response.user!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? e.code);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuthClient.createUserWithEmailAndPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const ServerException('User is null!');
      }
      return UserModel.fromFirebaseUser(response.user!).copyWith(name: name);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? e.code);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUser != null) return UserModel.fromFirebaseUser(currentUser!);
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
