//
//  ContentView.swift
//  Concentration
//
//  Created by Shuduo Liu on 2024/10/19.
//

import SwiftUI

struct ContentView: View {
    let emojiDict = [
        "Animals": ["🐶", "🐼", "🐯", "🐸", "🐭", "🐹","🐻","🐯","🐧","🐦","🐥","🐗"],
        "Flags": ["🇧🇲","🇧🇹","🇧🇴","🇧🇦","🇧🇳","🇻🇬","🇧🇷"],
        "Activities": ["⚽️","🏀","🏈","⚾️","🏉","🏐","🎾"]
    ]
    
    let symbolDict = [
        "Animals": "dog",
        "Flags": "flag",
        "Activities": "soccerball"
    ]

    @State var emojis: Array<String> = ["🐶", "🐼", "🐯", "🐸", "🐭", "🐹","🐻","🐯","🐧","🐦","🐥","🐗"]
    @State var cardCount: Int = 12
    
    var body: some View {
        VStack() {
            Text("Memorize !").font(.largeTitle)
            ScrollView{
                cards
            }
            Spacer()
            themeAdjusters
        }
        .padding()
    }
    
    func theme(name: String) -> some View {
        var themeEmojis = Array(emojiDict[name]!.shuffled().prefix(cardCount/2))
        themeEmojis = themeEmojis + themeEmojis
        return Button(
            action: {
                emojis = themeEmojis.shuffled()
            },
            label:{
                VStack{
                    Image(systemName: symbolDict[name]!).font(.title)
                    Text(name)
                }
            }
        )
        
    }
    
    var themeAdjusters: some View {
        HStack{
            Spacer()
            // Animal theme
            theme(name: "Animals")
            Spacer()
            theme(name: "Activities")
            Spacer()
            theme(name: "Flags")
            Spacer()
        }
    }
    
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 110))]) {
            if emojis.count > 0 {
                ForEach(0..<cardCount, id: \.self) { index in
                    if index < emojis.count {
                        CardView(content: emojis[index])
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            } else {
                Spacer()
            }
        }.foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
                cardRemover
                Spacer()
                cardAdder
            }
            .imageScale(.large)
            .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack() {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
