//
//  PrimaryButtonStyle.swift
//  ExercisePostureGuide
//
//  Created by 박광이 on 2022/03/17.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var fillButton: Color = .darkPrimaryButton
    func makeBody(configuration: Configuration) -> some View {
        return PrimaryButton(configuration: configuration, fillColor: fillButton)
    }
    
    struct PrimaryButton: View {
        let configuration: Configuration
        let fillColor: Color
        var body: some View {
            return configuration.label
                .padding(20)
                .background(RoundedRectangle(cornerRadius: 8).fill(fillColor))
        }
    }
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}){
            Text("Create a challenge")
        }.buttonStyle(PrimaryButtonStyle())
    }
}

