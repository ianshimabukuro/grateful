//
//  DailyCheckInView.swift
//  grateful
//
//  Created by Ian Shimabukuro on 8/16/25.
//
import SwiftUI
struct DailyCheckInView : View{
    @State private var didTap : Bool = false
    var body: some View{
        VStack {
            Button(""){
                didTap.toggle()
            }
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 1), trigger: didTap)
            Text("It's Time to Be Grateful")
                .font(.largeTitle)
                .fontWeight(.light)
                .foregroundColor(.accent)
            Button{
                didTap.toggle()
            }label:{
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
        .navigationDestination(isPresented: $didTap){
            MoodView()
        }
        .navigationBarBackButtonHidden()
    }
}
#Preview {
    DailyCheckInView()
}

