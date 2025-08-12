//
//  ContentView.swift
//  grateful
//
//  Created by Ian Shimabukuro on 8/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var showModal : Bool = false
    @State var textField: String = ""
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                Section(header: Text("Gratitude Diary")){
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        } label: {
                            VStack(alignment: .leading){
                                Text(item.gratitude)
                                    .font(.body)
                                    .fontWeight(.light)
                                    .foregroundColor(.accentColor)
                                Text(item.timestamp, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
                                    .font(.footnote.italic())
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .bottomBar){
                    Text("\(items.count)")
                }
                ToolbarItem {
                    Button{
                        showModal = true
                        
                    } label:{
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showModal){
                VStack{
                    Text("What are you grateful for?")
                        .font(.largeTitle)
                    TextEditor(text: $textField)
                        .frame(minHeight: 100, maxHeight: 200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.accent, lineWidth: 2)
                        )
                        .padding()
                    Button{
                        if textField != ""{
                            addItem(gratitude: textField)
                            showModal = false
                        }
                    } label:{
                        ZStack{
                            Text("Done")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.accent)
                                )
                        }
                    }
                }
                .presentationDetents([.fraction(0.5)])
            }
           
        } detail: {
            Text("Select an item")
        }
        
    }

    private func addItem(gratitude : String) {
        withAnimation {
            let newItem = Item(timestamp: Date(),gratitude: gratitude)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
