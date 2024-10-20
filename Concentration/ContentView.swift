//
//  ContentView.swift
//  Concentration
//
//  Created by Shuduo Liu on 2024/10/19.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        let emojis: Array<String> = ["🐶", "🐼", "🐯", "🐸"]
        
        VStack() {
            HStack() {
                ForEach(emojis.indices, id: \.self) { index in
                    CardView(content: emojis[index])
                }
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack() {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
