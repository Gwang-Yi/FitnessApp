//
//  UserService.swift
//  ExercisePostureGuide
//
//  Created by 박광이 on 2022/03/21.
//

import Combine
import FirebaseAuth

protocol UserServiceProtocol {
    func currentUser() -> AnyPublisher<User?, Never>
    func signInAnonymously() -> AnyPublisher<User, ExcerisePostureGuideError>
    func observeAuthChanges() -> AnyPublisher<User?, Never>
}

final class UserService: UserServiceProtocol {
    func currentUser() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    // Single use publisher
    func signInAnonymously() -> AnyPublisher<User, ExcerisePostureGuideError> {
        return Future<User, ExcerisePostureGuideError> { promise in
            Auth.auth().signInAnonymously { result, error in
                if let error = error {
                    return promise(.failure(.auth(description: error.localizedDescription)))
                } else if let user = result?.user {
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
    func observeAuthChanges() -> AnyPublisher<User?, Never> {
        Publishers.AuthPublisher().eraseToAnyPublisher()
    }
}
