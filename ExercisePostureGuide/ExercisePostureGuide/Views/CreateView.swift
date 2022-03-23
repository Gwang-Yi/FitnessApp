//
//  CreateView.swift
//  ExercisePostureGuide
//
//  Created by 박광이 on 2022/03/17.
//

import SwiftUI

struct CreateView: View{
    @StateObject var viewModel = CreateChallengeViewModel()
    //    @State private var isActive = false
    
    var dropdownList: some View{
        Group{
            DropdownView(viewModel: $viewModel.exerciseDropdown)
            DropdownView(viewModel: $viewModel.startAmountDropdown)
            DropdownView(viewModel: $viewModel.increaseDropdown)
            DropdownView(viewModel: $viewModel.lengthDropdown)
        }
        //        ForEach(viewModel.dropdowns.indices, id: \.self){
        //            index in DropdownView(viewModel: $viewModel.dropdowns[index])
        //        }
    }
    
    var mainContentView: some View{
        ScrollView{
            VStack{
                dropdownList
                Spacer()
                Button(action: {
                    viewModel.send(action:  .createChallenge)
                }) {
                    Text("생성 및 추가")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.primary)
                }
                
            }
            
        }
    }
    
    //    var actionSheet: ActionSheet {
    //        ActionSheet(
    //            title: Text("선택"),
    //            buttons: viewModel.displayedOptions.indices.map { index in
    //                let option = viewModel.displayedOptions[index]
    //                return .default(
    //                    Text(option.formatted)){
    //                        viewModel.send(action: .selectOption(index: index))
    //                    }
    //            }
    //        )
    //    }
    
    var body: some View{
        ZStack{
            if viewModel.isLoading{
                ProgressView()
            } else{
                mainContentView
            }
        }.alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil)) {
            Alert(title: Text("오류!"), message: Text($viewModel.error.wrappedValue?.localizedDescription ?? ""), dismissButton: .default(Text("확인"), action: {
                viewModel.error = nil
            }))
        }
        .navigationBarTitle("추가하기")
        .navigationBarBackButtonHidden(true)
        .padding(.bottom, 15)
    }
}

