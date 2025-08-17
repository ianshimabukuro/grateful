//
//  DailyCheckInView.swift
//  grateful
//
//  Created by Ian Shimabukuro on 8/16/25.
//
import SwiftUI
struct DailyCheckInView : View{
    var body: some View{
        VStack {
            Image(.capybara)
                .resizable()
                .frame(width:200,height:200)
            Text("It's Time to Be Grateful")
                .font(.largeTitle.bold())
                .foregroundColor(.accent)
            NavigationLink(destination: MoodView()){
                Text("Daily Check-In")
                    .foregroundColor(.white)
                    .padding()
                    .background{
                        Circle()
                            .fill(.accent)
                            .scaledToFill()
                            
                    }
            }
            .padding(.top,40)
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}
#Preview {
    DailyCheckInView()
}

