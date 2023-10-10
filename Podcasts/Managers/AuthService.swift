//
//  AuthService.swift
//  Podcasts
//
//  Created by Ольга Шовгенева on 4.10.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import RealmSwift

class AuthService {
    
    public static let shared = AuthService()
    let realm = try! Realm()
    
    private init() {}
    
    
    /// A method to register the user
    /// - Parameters:
    ///   - userRequest: The users information (email, password, firstName, lastName)
    ///   - completion: A completion with two values...
    ///   - Bool: wasRegistered - Determines if the user was registered and saved in the database correctly
    ///   - Error?: An optional error if firebase provides once
    public func registerUser(with userRequest: RegiserUserRequest, completion: @escaping (Bool, Error?) -> Void) {
//        let firstName = userRequest.firstName
//        let lastName = userRequest.lastName
//        let email = userRequest.email
//        let password = userRequest.password
        let account = Account()
        account.firstName = userRequest.firstName
        account.lastName = userRequest.lastName
        account.email = userRequest.email
        account.password = userRequest.password
        
        Auth.auth().createUser(withEmail: account.email, password: account.password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            do {
                try self.realm.write {
                    self.realm.add(account)
                }
            } catch {
                
            }
            
//            let db = Firestore.firestore()
//            db.collection("users")
//                .document(resultUser.uid)
//                .setData([
//                    "firstName": firstName,
//                    "lastName": lastName,
//                    "email": email
//                ]) { error in
//                    if let error = error {
//                        completion(false, error)
//                        return
//                    }
//                    
//                    completion(true, nil)
//                }
        }
    }
    
    public func signIn(with userRequest: LoginUserRequest, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: userRequest.email,
                           password: userRequest.password) { _, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    public func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
}
