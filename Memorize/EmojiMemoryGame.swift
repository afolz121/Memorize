//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Andrew Folz on 12/21/21.
//
import SwiftUI

// step two is view model
// job is to be the intermediary between our view and our model
// so it needs to have a connection between the view and the model .
class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    //static means it's 'global' but its within this class only
    private static let emojis: [String] = ["🚗", "🚑", "🚓", "✈️", "🚜", "🏎",
                            "🚕", "🚀", "🚌", "🛺", "🚔", "🛸",
                            "🚁", "🚲", "🛴", "🛰", "🚎", "🚨",
                            "🚆", "🚛", "🚤", "⛵️", "🎡", "🚦"]

    // create model for view model
    // if view model creating a model then it becomes 'source of truth
    // private means only the view model's code itself can see the model
    // protects model from any view that is trying to alter the view model
    // private(set) means views can see the model but can't change it
    @Published private(set) var model =
        MemoryGame<String>(numberOfPairsOfCards: 10) {pairIndex in
            EmojiMemoryGame.emojis[pairIndex]}
    
    var cards: Array<Card> {
        return model.cards
        
    }
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        objectWillChange.send()
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
