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
            Text("It's Time to Be Grateful")
                .font(.largeTitle)
                .fontWeight(.light)
                .foregroundColor(.accent)
            NavigationLink(destination: MoodView()){
                Text("Daily Check-In")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(50)
                    .background{
                        Circle()
                            .fill(.accent)
                            .scaledToFill()
                            
                    }
            }
            .padding(.top,100)
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}
#Preview {
    DailyCheckInView()
}

