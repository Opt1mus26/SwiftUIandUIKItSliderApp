//
//  ContentView.swift
//  SwiftUIandUIKItSliderApp
//
//  Created by Pavel Tsyganov on 31.01.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentValue: Double
    @State private var textValue = ""
    @State private var targetValue = Int.random(in: 0...100)
    @State private var showAlert = false
   
    
    var body: some View {
        VStack {
            Text("Подвиньте слайдер? как можно ближе к: \(targetValue)")
            HStack {
                Text("0")
                SliderUI(currentValue: $currentValue)
                    .onChange(of: currentValue) { newValue in
                        textValue = "\(lround(currentValue))"
                    }
                Text("100")
            }
            .padding()
            Button("Проверь меня") {
                showAlert.toggle()
            }
            .alert("Your score",
                   isPresented: $showAlert,
                   actions: {}) {
            Text(String(computeScore()))
            }
                .padding()
            Button("Начать заново") {
                changeValue()
            }
        }
        .onAppear {
            textValue = "\(lround(currentValue))"
        }
        .padding()
    }
    
    private func changeValue() {
        let newValue = Int.random(in: 0...100)
        targetValue = newValue
    }
    
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(currentValue))
        return 100 - difference
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentValue: 50)
    }
}
