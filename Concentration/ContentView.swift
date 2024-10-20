//
//  ContentView.swift
//  Concentration
//
//  Created by Shuduo Liu on 2024/10/19.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack() {
            HStack() {
                CardView(isFaceUp: true)
                CardView()
                CardView()
                CardView()
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    @State var isFaceUp = false
    
    var body: some View {
        ZStack() {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text("🐶").font(.largeTitle)
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
