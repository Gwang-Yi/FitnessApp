//
//  ChallengeService.swift
//  ExercisePostureGuide
//
//  Created by 박광이 on 2022/03/22.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ChallengeServiceProtocol {
    func create(_ challenge: Challenge) -> AnyPublisher<Void, ExcerisePostureGuideError>
    func observeChallenges(userId: UserId) -> AnyPublisher<[Challenge], ExcerisePostureGuideError>
//    func delete(_ challengeId: String) -> AnyPublisher<Void, IncrementError>
//    func updateChallenge(_ challengeId: String, activities: [Activity]) -> AnyPublisher<Void, IncrementError>
}

final class ChallengeService: ChallengeServiceProtocol {
    private let db = Firestore.firestore()
    func create(_ challenge: Challenge) -> AnyPublisher<Void, ExcerisePostureGuideError> {
        return Future<Void, ExcerisePostureGuideError> { promise in
            do {
                _ = try self.db.collection("challenges").addDocument(from: challenge) { error in
                    if let error = error {
                        promise(.failure(.default(description: error.localizedDescription)))
                    } else {
                        promise(.success(()))
                    }
                }
            } catch {
                promise(.failure(.default()))
            }
        }.eraseToAnyPublisher()
    }

    func observeChallenges(userId: UserId) -> AnyPublisher<[Challenge], ExcerisePostureGuideError> {
        let query = db.collection("challenges").whereField("userId", isEqualTo: userId) // .order(by: "startDate", descending: true)
        return Publishers.QuerySnapshotPublisher(query: query).flatMap { snapshot -> AnyPublisher<[Challenge], ExcerisePostureGuideError> in
            do {
                let challenges = try snapshot.documents.compactMap {
                     try $0.data(as: Challenge.self)
                }
                return Just(challenges).setFailureType(to: ExcerisePostureGuideError.self).eraseToAnyPublisher()
            } catch {
                print(error.localizedDescription)
                return Fail(error: .default(description: "Parsing error")).eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
//
//    func delete(_ challengeId: String) -> AnyPublisher<Void, IncrementError> {
//        return Future<Void, IncrementError> { promise in
//            self.db.collection("challenges").document(challengeId).delete { error in
//                if let error = error {
//                    promise(.failure(.default(description: error.localizedDescription)))
//                } else {
//                    promise(.success(()))
//                }
//            }
//        }.eraseToAnyPublisher()
//    }
//
//    func updateChallenge(_ challengeId: String, activities: [Activity]) -> AnyPublisher<Void, IncrementError> {
//        return Future<Void, IncrementError> { promise in
//            self.db.collection("challenges").document(challengeId).updateData(
//                ["activities": activities.map {
//                    return ["date": $0.date, "isComplete": $0.isComplete]
//                }]
//            ) { error in
//                if let error = error {
//                    promise(.failure(.default(description: error.localizedDescription)))
//                } else {
//                    promise(.success(()))
//                }
//            }
//        }.eraseToAnyPublisher()
//    }
}

