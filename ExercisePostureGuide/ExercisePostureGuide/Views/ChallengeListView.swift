//
//  ChallengeListView.swift
//  ExercisePostureGuide
//
//  Created by 박광이 on 2022/03/23.
//

import SwiftUI

struct ChallengeListView: View{
    @StateObject private var viewModel = ChallengeListViewModel()
    var body: some View{
        ZStack{
            if viewModel.isLoading{
                ProgressView()
            } else if let error = viewModel.error{
                VStack {
                    Text(error.localizedDescription)
                    Button("Retry"){
                        viewModel.send(action: .retry)
                    }.padding(10)
                        .background(Rectangle().fill(Color.red).cornerRadius(5))
                }
            } else{
                mainContentView
            }
        }
    }
    
    var mainContentView: some View{
        ScrollView{
            VStack{
                LazyVGrid(columns: [.init(.flexible(), spacing: 20), .init(.flexible())], spacing: 20){
                    ForEach(viewModel.itemViewModels, id: \.self){ viewModel in
                        ChallengeItemView(viewModel: viewModel)
                    }
                }
                Spacer()
            }.padding(10)
        }.sheet(isPresented: $viewModel.showingCreateModel){
            NavigationView{
            CreateView()
            }
        }
        .navigationBarItems(trailing: Button {
            viewModel.send(action: .create)
        } label: {
            Image(systemName: "plus.circle").imageScale(.large)
        })
        .navigationTitle(viewModel.title)
    }
}


struct ChallengeItemView: View{
    private let viewModel: ChallengeItemViewModel
    init(viewModel: ChallengeItemViewModel){
        self.viewModel = viewModel
    }
    
    var titleRow: some View{
        HStack {
            Text(viewModel.title)
                .font(.system(size: 24, weight: .bold))
            Spacer()
            Image(systemName: "trash")
        }
    }
    
    var dailyIncreaseRow: some View{
        HStack{
            Text(viewModel.dailyIncreaseText)
                .font(.system(size: 24, weight: .bold))
            Spacer()
        }
    }
    
    var body: some View{
        HStack{
            Spacer()
            VStack{
                titleRow
                Text(viewModel.statusText)
                    .font(.system(size: 12, weight: .bold))
                    .padding(25)
                dailyIncreaseRow
            }.padding(.vertical, 10)
            Spacer()
        }
        .background(
            Rectangle()
                .fill(Color.darkPrimaryButton)//
                .cornerRadius(7)
        )
    }
}
