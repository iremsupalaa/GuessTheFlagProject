//
//  ContentView.swift
//  GuessTheFlagProject
//
//  Created by İremsu Pala on 2.11.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia","France", "Germany","Ireland","Italy","Nigeria","Poland","Spain","UK","Ukraine","US"].shuffled() //array sırası otomatik olarak rastgele hale geliyor
    @State private var showingScore = false
    @State private var showingWrongAnswer = false
    @State private var scoreTitle = ""
    @State private var correctAnswer = Int.random(in: 0...2) //Int.random methodu rastgele bir sayı verir
    @State private var correctAnswerText = ""
    @State private var answerState = false
    @State private var score = 0
    @State private var answerCount = 0
    @State private var showingGrandResult = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red:0.76 , green: 0.15, blue:0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                
                VStack(spacing: 15) {
                    
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.white)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.white)
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .cornerRadius(20)
            }
            .padding()
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func reset() {
        score = 0
        answerCount = 0
        askQuestion()
    
    }
}

#Preview {
    ContentView()
}

