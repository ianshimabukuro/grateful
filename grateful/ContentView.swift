//
//  ContentView.swift
//  grateful
//
//  Created by Ian Shimabukuro on 8/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationStack{
            MainView()
        }
        
       
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
