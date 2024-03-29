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
        get { cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly }
        set { cards.indices.forEach({cards[$0].isFaceUp = ($0 == newValue)}) }
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
        cards.shuffle()
        
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
    mutating func shuffle() {
        cards.shuffle()
    }
}


//extension are added methods of classes

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}


// step two will be to create the view model from the model
// we will make a new file for this step.


