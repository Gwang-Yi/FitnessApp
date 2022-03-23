//
//  Challenge.swift
//  ExercisePostureGuide
//
//  Created by 박광이 on 2022/03/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Challenge: Codable {
    @DocumentID var id: String?
    let exercise: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userId: String
    let startDate: Date
//    let activities: [Activity]
    
}

struct Activity: Codable {
    let date: Date
    let isComplete: Bool
}

