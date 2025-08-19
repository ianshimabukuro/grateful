//
//  InputView.swift
//  grateful
//
//  Created by Ian Shimabukuro on 8/16/25.
//

import SwiftUI
import SwiftData


struct HistoryView: View{
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.timestamp, order:.reverse) private var items: [Item]
    
    var body: some View{
        VStack{
            List {
                Section(header: Text("Gratitude Diary")){
                    ForEach(items) { item in
                            VStack(alignment: .leading){
                                Text(item.gratitude)
                                    .font(.body)
                                    .fontWeight(.light)
                                    .foregroundColor(.accentColor)
                                HStack {
                                    Text(item.timestamp, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
                                        .font(.footnote.italic())
                                        .fontWeight(.light)
                                    Spacer()
                                    Image(item.mood)
                                        .resizable()
                                        .frame(width: 20,height: 20)
                                }
                            }
                    }
                }
            }
        }
    }
    private func moodToScore(_ mood: String) -> Int {
        switch mood {
        case "Horrible": return 0
        case "Bad": return 1
        case "Neutral": return 2
        case "Good": return 3
        case "Incredible": return 4
        default: return 2
        }
    }
    
    // Map numeric → string (for axis)
    private func scoreToMood(_ score: Int) -> String {
        ["Horrible","Bad","Neutral","Good","Incredible"][score]
    }
   
    
}

#Preview("Seeded History") {
    // 1) In-memory container for previews
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Item.self, configurations: config)

    // 2) Seed some fake data
    let ctx = container.mainContext
    let cal = Calendar(identifier: .gregorian)
    let startOfToday = cal.startOfDay(for: .now)

    let moods = ["Horrible","Bad","Neutral","Good","Incredible"]

    // Insert ~20 days of entries, plus a couple of “same-day” duplicates
    for offset in 0..<20 {
        let date = cal.date(byAdding: .day, value: -offset, to: startOfToday)!
        // stagger times a bit during the day
        let time = cal.date(byAdding: .hour, value: Int.random(in: 8...20), to: date)!
        let mood = moods[Int.random(in: 0..<moods.count)]
        let gratitude = [
            "Coffee with a friend ☕️",
            "Finished a tough task ✅",
            "Nice weather walk 🌤️",
            "Called family 📞",
            "Read a chapter 📖"
        ].randomElement()!

        ctx.insert(Item(timestamp: time, gratitude: gratitude, mood: mood))

        // Occasionally add a second entry on the same day
        if Bool.random() {
            let time2 = cal.date(byAdding: .hour, value: Int.random(in: 12...22), to: date)!
            let mood2 = moods[Int.random(in: 0..<moods.count)]
            ctx.insert(Item(timestamp: time2, gratitude: "Second entry: \(gratitude)", mood: mood2))
        }
    }
    try? ctx.save()

    // 3) Render your view with the seeded container
    return NavigationStack {
        HistoryView()
    }
    .modelContainer(container)
}
