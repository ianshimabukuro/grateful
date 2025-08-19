//
//  InputView.swift
//  grateful
//
//  Created by Ian Shimabukuro on 8/16/25.
//

import SwiftUI
import SwiftData

struct InputView : View{
    
    
    @State var textField : String = ""
    @State var shouldNavigate : Bool = false
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.timestamp, order:.reverse) private var items: [Item]
    var mood : Int
    var list = ["Horrible","Bad","Neutral","Good","Incredible"]
    var l = ["I’m sorry today feels rough. Even on the hardest days, there’s always a small thing to appreciate. What’s one thing I can be grateful for today?","It seems like today hasn’t been the best, but sometimes the smallest joys make the biggest difference. What can I be grateful for right now?","An average kind of day. Let’s pause and notice one thing that I’m grateful for today.","Nice! Things are going well. Let’s add to the positivity. What’s something I’m grateful for today?","Awesome! I’m feeling amazing. Let’s keep the good vibes. What am I grateful for today?"]
    
    var body:some View{
        VStack{
            Text(l[mood])
                .font(.title2)
                .fontWeight(.light)
            TextEditor(text: $textField)
                .frame(minHeight: 100, maxHeight: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.accent, lineWidth: 2)
                )
                
            HStack {
                Text("Character count: \(textField.count) \n Min: 50")
                    .font(.callout)
                Spacer()
            }
            
            Button{
                if textField != ""{
                    addItem(gratitude: textField, mood: mood)
                    shouldNavigate = true
                    textField = "" // reset the text
                }
            } label:{
                ZStack{
                    Text("Done")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .background(
                            Capsule()
                                .fill(.accent)
                        )
                }
            }
            .disabled(textField.count<50)
            .opacity(textField.count<50 ? 0.5 : 1.0)
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $shouldNavigate){
            MainView()
            
        }
        .padding()
    }
    private func addItem(gratitude: String, mood: Int) {
        withAnimation {
            let text = gratitude.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !text.isEmpty, list.indices.contains(mood) else { return }

            let newItem = Item(timestamp: Date(), gratitude: text, mood: list[mood])
            modelContext.insert(newItem)
            do {
                try modelContext.save()
                print("Saved OK")

                // 🔎 Fresh, synchronous check that bypasses @Query's async update:
                let fetch = FetchDescriptor<Item>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
                let now = try modelContext.fetch(fetch)
                print("Manual fetch count:", now.count, "top:", now.first?.gratitude ?? "nil")

                // If you still want to peek at @Query after it updates:
                DispatchQueue.main.async {
                    print("(@Query) items after tick:", items.count)
                }
            } catch {
                print("SAVE ERROR:", error)
            }
        }
    }

    
}

#Preview {
        InputView(mood: 2)
}
