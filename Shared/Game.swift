//
//  GameViewModel.swift
//  WeLoveWordle
//
//  Created by Mark Powell on 1/17/22.
//

import Foundation

enum GameState {
    case win
    case lose
    case playing
    case initializing
    case unrecognizedWord
}

class Game: ObservableObject {
    static let wordLength = 5
    static let numGuesses = 6
    @Published var guessNumber = 0
    @Published var letterNumber = 0
    @Published var gameState = GameState.initializing
    @Published var guesses = GuessesViewModel()
    @Published var keyStates: [String: Correctness] = [:]
    var answer = ""
    var allWords: [String: String] = [:]
    var randomWordIndex: Int = 0
    
    func loadWords() async throws {
        let fiveUrl = Bundle.main.url(forResource: "five_letter_words", withExtension: "txt")
        let wordLines = fiveUrl!.lines
        for try await line in wordLines {
            let word = line.uppercased()
            allWords[word] = word
        }
        randomWordIndex = Int.random(in: 0..<allWords.keys.count)
        answer = getAnswer()
    }
    
    func commitGuess() {
        if letterNumber == Game.wordLength {
            let guess = guesses.guesses[guessNumber].getWord()
            let answer = getAnswer()
            if isValid(word: guess) {
                gameState = .playing
                // update gameboard and keyboard appearance
                guesses.guesses[guessNumber].compareLetters(answer: answer, game: self)
                            
                // update guess count and check win/lose conditions
                letterNumber = 0
                guessNumber += 1
                if guess == answer {
                    gameState = .win
                } else if guessNumber == Game.numGuesses {
                    gameState = .lose
                }
            } else {
                gameState = .unrecognizedWord
            }
        }
    }
    
    func addLetter(letter: String) {
        if letterNumber < Game.wordLength {
            guesses.guesses[guessNumber].word[letterNumber].letter = letter
            letterNumber += 1
        }
    }
    
    func deleteLetter() {
        if letterNumber > 0 {
            letterNumber -= 1
            guesses.guesses[guessNumber].word[letterNumber].letter = " "
        }
    }
    
    func getAnswer() -> String {
        if answer.isEmpty {
            answer = Array(allWords.keys)[randomWordIndex]
        }
        return answer
    }
    
    func isValid(word: String) -> Bool {
        return allWords[word] != nil
    }
}
