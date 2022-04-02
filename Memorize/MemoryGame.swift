//
//  MemoryGame.swift
//  Memorize
//
//  Created by Andrew Folz on 12/21/21.
//
// "<something>" indicates a generic or a 'dont care'
// in our code we don't care what this is, but at some point
// we will have to tell the program what a don't care actually is

import Foundation

//step one, create the model called MemoryGame

struct MemoryGame<CardContent> where CardContent: Equatable {
    // creatke struct Card that will define what a card has in it.
        
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int

    }
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            var faceUpCardIndices = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpCardIndices.append(index)
                }
            }
            if faceUpCardIndices.count == 1 {
                return faceUpCardIndices.first
            } else {
                return nil
        }
    }
        set {
            for index in cards.indices {
                if index != newValue {
                    cards[index].isFaceUp = false
                } else {
                    cards[index].isFaceUp = true
                }
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // add numberofpairsofcards x 2 cards to cards array
        //do this with a for loop
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
    }
    // create array of Cards which will be a bunch of struct cards.
    private(set) var cards: Array<Card>
    
    
    mutating func choose(_ card: Card) {
//        if let chosenIndex = index(of: card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
                if let potentialmatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialmatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialmatchIndex].isMatched = true
                    }
                    cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
        //chosenCard.isFaceUp.toggle()
        //print("\(cards)")
    }
}


// step two will be to create the view model from the model
// we will make a new file for this step.


