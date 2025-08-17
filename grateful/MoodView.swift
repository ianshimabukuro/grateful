//
//  DailyCheckInView.swift
//  grateful
//
//  Created by Ian Shimabukuro on 8/16/25.
//
import SwiftUI
import SwiftData

struct MoodView : View{
    
    @State private var selection : String = "Neutral"
    var list = ["Horrible","Bad","Neutral","Good","Incredible"]
    
    var body: some View{
        VStack {
            Text("How's your mood today?")
                .font(.largeTitle)
            Image(selection)
                .resizable()
                .frame(width: 250,height: 250)
            Picker("Pick your mood",selection: $selection){
                ForEach(list,id:\.self){ item in
                    Text(item)
                    
                }
            }
            .padding()
            .pickerStyle(.wheel)
            
            NavigationLink(destination: InputView(mood: list.firstIndex(of: selection)!)){
                Text("Next")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding()
                    .background{
                        Capsule()
                            .fill(.accent)
                    }
            }
        }
        .navigationBarBackButtonHidden()
        .padding()
    }
}
#Preview {
        MoodView()
}

