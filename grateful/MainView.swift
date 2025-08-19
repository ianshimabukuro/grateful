//
//  InputView.swift
//  grateful
//
//  Created by Ian Shimabukuro on 8/16/25.
//

import SwiftUI
import SwiftData

struct MainView : View{
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.timestamp, order:.reverse) private var items: [Item]
    
    var body: some View{
        VStack{
            if let last = items.first{
                if !Calendar.current.isDate(last.timestamp, inSameDayAs: Date.now){
                    //if you havent done it today, check in
                    DailyCheckInView()
                }
                else{
                    //look at the previous ones
                    HistoryView()                }
            }
            
            else{
                //if it is just check in
                DailyCheckInView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
   
    
}

#Preview {
    MainView()
}
