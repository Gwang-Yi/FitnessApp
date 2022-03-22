//
//  ContentView.swift
//  ExercisePostureGuide
//
//  Created by 박광이 on 2022/03/17.
//

import SwiftUI

struct LandingView: View {
    @State private var isActive = false
    var body: some View {
        NavigationView{
            GeometryReader{ proxy in
                VStack{
                    Spacer().frame( height: proxy.size.height * 0.3)
                    Text("Fitness APP")
                        .font(.system(size:50, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink(destination: CreateView(), isActive: $isActive) {
                        Button(action: {
                            isActive = true
                        }) {
                            HStack(spacing:20){
                                Spacer()
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                                Text("운동 추가")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }.padding(15)
                            .buttonStyle(PrimaryButtonStyle())
                    }
                }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                    .background(Image("IntroImage")
                                    .resizable()
                                    .aspectRatio(
                                        contentMode: .fill
                                    ).overlay(Color.black.opacity(0.2))
                                    .frame(width: proxy.size.width)
                                    .edgesIgnoringSafeArea(.all)
                    )
            }
        }.accentColor(.primary)
        
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView().previewDevice("iPhone 11")
    }
}

