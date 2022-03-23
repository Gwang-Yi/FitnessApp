//
//  ExercisePostureGuideErrors.swift
//  ExercisePostureGuide
//
//  Created by 박광이 on 2022/03/22.
//

import Foundation

enum ExcerisePostureGuideError: LocalizedError {
    case auth(description: String)
    case `default`(description: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case let .auth(description):
            return description
        case let .default(description):
            return description ?? "오류 발생 / Something went wrong"
        }
    }
}

