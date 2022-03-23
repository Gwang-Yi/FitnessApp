//
//  DropdownItemProtocol.swift
//  ExercisePostureGuide
//
//  Created by 박광이 on 2022/03/17.
//

import Foundation

protocol DropdownItemProtocol {
    var options: [DropdownOption] {get}
    var headerTitle: String {get}
    var dropdownTitle: String {get}
    var isSelected: Bool {get set}
    var selectedOption: DropdownOption {get set}
}

protocol DropdownOptionProtocol {
    var toDropDownOption: DropdownOption {get}
}

struct DropdownOption {
    enum DropdownOptionType {
        case text(String)
        case number(Int)
    }
    let type: DropdownOptionType
    let formatted: String
}

