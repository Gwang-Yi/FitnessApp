//
//  CreateChallengeViewModel.swift
//  ExercisePostureGuide
//
//  Created by 박광이 on 2022/03/17.
//

import Firebase
import SwiftUI
import Combine

typealias UserId = String

final class CreateChallengeViewModel: ObservableObject{
//    @Published var dropdowns: [ChallengePartViewModel] = [
//        .init(type: .exercise),
//        .init(type: .startAmount),
//        .init(type: .increase),
//        .init(type: .length),
//    ]
    @Published var exerciseDropdown = ChallengePartViewModel(type: .exercise)
    @Published var startAmountDropdown = ChallengePartViewModel(type: .startAmount)
    @Published var increaseDropdown = ChallengePartViewModel(type: .increase)
    @Published var lengthDropdown = ChallengePartViewModel(type: .length)
    
    @Published var error: ExcerisePostureGuideError?
    @Published private(set) var isLoading = false
    
    
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    enum Action {
        case createChallenge
    }
    
    init(userService: UserServiceProtocol = UserService(),
         challengeService: ChallengeServiceProtocol = ChallengeService()
    ){
        self.userService = userService
        self.challengeService = challengeService
    }
    
    func send(action: Action) {
        switch action {
        case .createChallenge:
            isLoading = true
            currentUserId().flatMap{ userId -> AnyPublisher<Void, ExcerisePostureGuideError> in
                return self.createChallenge(userId: userId)
            }.sink { completion in
                self.isLoading = false
                switch completion {
                case let .failure(error):
                    self.error = error
                case .finished:
                    print("완료")
                }
            } receiveValue: { _ in
                print("성공")
            }.store(in: &cancellables)
        }
    }
    
    private func createChallenge(userId: UserId) -> AnyPublisher<Void, ExcerisePostureGuideError>{
        guard let exercise = exerciseDropdown.text,
              let startAmount = startAmountDropdown.number,
              let increase = increaseDropdown.number,
              let length = lengthDropdown.number else {
                  return Fail(error: .default(description:"Parsing error")).eraseToAnyPublisher()
        }
        //let startDate = Calendar.current.startOfDay(for: Date())

        let challenge = Challenge(
            exercise: exercise,
            startAmount: startAmount,
            increase: increase,
            length: length,
            userId: userId,
            startDate: Date()
            
//            ,activities: (0..<length).compactMap { dayNum in
//                if let dateForDayNum = Calendar.current.date(byAdding: .day, value: dayNum, to: startDate) {
//                    return .init(date: dateForDayNum, isComplete: false)
//                } else {
//                    return nil
//                }
//            }
        )
        
        return challengeService.create(challenge).eraseToAnyPublisher()
        
    }
    
    
    private func currentUserId() -> AnyPublisher<UserId, ExcerisePostureGuideError> {
        print("getting user id")
        return userService.currentUser().flatMap { user -> AnyPublisher<UserId, ExcerisePostureGuideError> in
            if let userId = user?.uid {
               // print("user is logged in...")
                return Just(userId)
                    .setFailureType(to: ExcerisePostureGuideError.self)
                    .eraseToAnyPublisher()
            } else {
               // print("user is being logged in annonmously...")
                return self.userService
                    .signInAnonymously()
                    .map {$0.uid}
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}

extension CreateChallengeViewModel{
    struct ChallengePartViewModel: DropdownItemProtocol{
        var selectedOption: DropdownOption
        
        var options: [DropdownOption]
        
        var headerTitle: String{
            type.rawValue
        }
        
        var dropdownTitle: String{
            selectedOption.formatted
        }
        
        var isSelected: Bool = false
        
        private let type: ChallengePartType
        
        init(type: ChallengePartType) {
            switch type {
            case .exercise:
                self.options = ExerciseOption.allCases.map {$0.toDropDownOption}
            case .startAmount:
                self.options = StartOption.allCases.map {$0.toDropDownOption}
            case .increase:
                self.options = IncreaseOption.allCases.map {$0.toDropDownOption}
            case .length:
                self.options = LengthOption.allCases.map {$0.toDropDownOption}
            }
            self.type = type
            self.selectedOption = options.first!
        }
        
        enum ChallengePartType: String, CaseIterable {
            case exercise = "Exercise"
            case startAmount = "Starting Amount"
            case increase = "Daily Increase"
            case length = "Challenge Length"
        }
        
        enum ExerciseOption: String, CaseIterable, DropdownOptionProtocol {
            case 팔굽혀펴기 // 예시일뿐, ML 으로 학습시킨 운동 자세를 넣을까 함
            case 윗몸일으키기
            case 런지
            
            var toDropDownOption: DropdownOption {
                .init(type: .text(rawValue), formatted: rawValue.capitalized )
            }
        }
        
        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropDownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue)")
            }
        }
        
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropDownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "+\(rawValue)")
            }
        }
        
        enum LengthOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropDownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue) days")
            }
        }
    }
}

extension CreateChallengeViewModel.ChallengePartViewModel {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
}

