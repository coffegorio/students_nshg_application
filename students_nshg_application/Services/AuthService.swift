//
//  AuthService.swift
//  students_nshg_application
//
//  Created by Егорио on 14.12.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    
    /// Регистрация пользователя
    public func registerUser(with userRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        let email = userRequest.email
        let password = userRequest.password
        let name = userRequest.name
        let surname = userRequest.surname
        let stageID = userRequest.stageID
        let currentLessonID = userRequest.currentLessonID
        let instrument = userRequest.instrument
        let createdAt = userRequest.createdAt
        let role = userRequest.role
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "email": email,
                    "password": password,
                    "name": name,
                    "surname": surname,
                    "stageID": stageID,
                    "currentLessonID": currentLessonID,
                    "instrument": instrument,
                    "createdAt": Timestamp(date: userRequest.createdAt),
                    "role": role
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
        }
    }
    
    /// Вход пользователя в аккаунт
    public func signInUser(with userRequest: LoginUserRequest, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    /// Выход пользователя из аккаунта
    public func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    /// Смена пароля у пользователя
    public func forgotPassword (with email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }

    /// Проверка на авторизованного пользователя
    public func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    /// Получение данных текущего пользователя
    public func fetchUserData(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Пользователь не авторизован"])))
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = document?.data() else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Данные пользователя не найдены"])))
                return
            }
            
            completion(.success(data))
        }
    }
    
}
