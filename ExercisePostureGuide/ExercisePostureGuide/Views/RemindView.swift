//
//  RemindView.swift
//  ExercisePostureGuide
//
//  Created by 박광이 on 2022/03/17.
//

import SwiftUI

struct RemindView: View{
    var body: some View{
        VStack{
            Spacer()
         //   DropdownView()
            Spacer()
            Button(action: {}){
                Text("완료")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }.padding(.bottom, 15)
            Button(action: {}){
                Text("선택 안함")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }
        }.navigationTitle("알림 설정")
            .padding(.bottom, 15)
    }
}

struct RemindView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationView{
            RemindView()
        }
    }
}

