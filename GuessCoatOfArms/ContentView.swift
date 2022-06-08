//
//  ContentView.swift
//  GuessCoatOfArms
//
//  Created by Marina Shvagir on 16.05.2022.
//

import SwiftUI
struct ContentView: View {
    
    @State private var banners = ["Arryn", "Baelish", "Baratheon", "Blackwood", "Bolton", "Bracken", "Bronn", "Clegane", "Darry", "Frey", "Gardener", "Glover", "Greyjoy", "Hoare", "Justman", "Lannister", "Karstark", "Mallister", "Martell", "Mormont", "Mudd", "Reed", "Smallwood", "Stark", "Targaryen", "Tarly", "Tully", "Tyrell", "Umber", "Whent"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var showNewScreen: Bool = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.08061445504, green: 0.004883728456, blue: 0.006463353056, alpha: 1)), Color(#colorLiteral(red: 0.1773463488, green: 0.02880751155, blue: 0.03436302021, alpha: 1)), Color(#colorLiteral(red: 0.4886262417, green: 0.05434928089, blue: 0.09543960541, alpha: 1))]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                Text("Choose a coat of arms:")
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding(.bottom)
                Text(banners[correctAnswer])
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .tracking(3)
                }
                ForEach(0..<3) {number in
                    Button(action: {
                        if score == 14 && number == correctAnswer {
                            self.showNewScreen = true
                            score = 0
                            self.askQuestion()
                        } else {
                        self.bannerTaped(number)
                        self.showingScore = true
                        }
                    }) {
                        Image(self.banners[number])
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(color: .black, radius: 2)
                            .padding()
                    }
                }
                Text("Total score: \(score)")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            ZStack {
                if showNewScreen {
                    YouWin(showOldScreen: $showNewScreen)
                        .transition(.move(edge: .bottom))
                }
            }
       }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Total score: \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
        
    func askQuestion() -> Void {
        banners.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func bannerTaped(_ number: Int) -> Void {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Oops...This is wrong ):"
            score -= 1
        }
    }
}

//second screen for a winner
struct YouWin: View {
    
    @Binding var showOldScreen: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.08061445504, green: 0.004883728456, blue: 0.006463353056, alpha: 1)), Color(#colorLiteral(red: 0.1773463488, green: 0.02880751155, blue: 0.03436302021, alpha: 1)), Color(#colorLiteral(red: 0.4886262417, green: 0.05434928089, blue: 0.09543960541, alpha: 1))]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image(systemName: "crown")
                    .padding(5)
                    .font(.largeTitle)
                .foregroundColor(Color.white)
                Text("Yeah! \n Congratulations, you win!")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding()
                HStack(alignment: .bottom, spacing: 45) {
                Button {
                    showOldScreen.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(#colorLiteral(red: 0.5439568162, green: 0.05588050932, blue: 0.1053478643, alpha: 1)))
                            .frame(width: 120, height: 45)
                            .shadow(color: Color(#colorLiteral(red: 0.0849269256, green: 0.004631793126, blue: 0.006345891394, alpha: 1)), radius: 7, x: 10, y: 10)
                    Text("Play again")
                        .foregroundColor(Color.white)
                    }
                }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
