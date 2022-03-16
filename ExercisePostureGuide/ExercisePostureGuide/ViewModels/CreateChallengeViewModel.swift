//
//  CreateChallengeViewModel.swift
//  ExercisePostureGuide
//
//  Created by 박광이 on 2022/03/17.
//

import SwiftUI

final class CreateChallengeViewModel: ObservableObject{
    @Published var dropdowns: [ChallengePartViewModel] = [
        .init(type: .exercise),
        .init(type: .startAmount),
        .init(type: .increase),
        .init(type: .length),
    ]
    
    enum Action {
        case selectOption(index : Int)
    }
    
    var hasSelectedDropdown: Bool {
        selectedDropdownIndex != nil
    }
    
    var selectedDropdownIndex: Int? {
        dropdowns.enumerated().first(where: { $0.element.isSelected})?.offset
    }
    
    var displayedOptions: [DropdownOption]{
        guard let selectedDropdownIndex = selectedDropdownIndex else {return []}
        return dropdowns[selectedDropdownIndex].options
    }
    
    func send(action: Action) {
        switch action {
        case let .selectOption(index):
            guard let selectedDropdownIndex = selectedDropdownIndex else { return }
            clearSelectedOption()
            dropdowns[selectedDropdownIndex].options[index].isSelected = true
            clearSelectedDropdown()
        }
    }
    
    func clearSelectedOption(){
        guard let selectedDropdownIndex = selectedDropdownIndex else { return }
        dropdowns[selectedDropdownIndex].options.indices.forEach{ index in
            dropdowns[selectedDropdownIndex].options[index].isSelected = false
        }
    }
    func clearSelectedDropdown(){
        guard let selectedDropdownIndex = selectedDropdownIndex else { return }
        dropdowns[selectedDropdownIndex].isSelected = false
    }
}

extension CreateChallengeViewModel{
    struct ChallengePartViewModel: DropdownItemProtocol{
        var options: [DropdownOption]
        
        var headerTitle: String{
            type.rawValue
        }
        
        var dropdownTitle: String{
            options.first(where: {$0.isSelected})?.formatted ?? ""
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
            //self.selectedOption = options.first!
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
                .init(type: .text(rawValue), formatted: rawValue.capitalized, isSelected: self == .팔굽혀펴기)
            }
        }
        
        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropDownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue)", isSelected: self == .one)
            }
        }
        
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropDownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "+\(rawValue)", isSelected: self == .one)
            }
        }
        
        enum LengthOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropDownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue) days", isSelected: self == .seven)
            }
        }
    }
}

