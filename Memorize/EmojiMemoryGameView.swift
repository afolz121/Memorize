//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Andrew Folz on 11/9/21.
//
//view preview of UI with editor / canvas
import SwiftUI

// struct short for data structure
// or a collection of variables.
// you can also have functions in structs.
// view means it behaves like a View struct
/* All View structs have a function called .padding()
    padding means create a boundary around the text
    padding returns something that behaves like a View
    or a padded modified View. It DOES NOT return text.
    
 */

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius) //make shape a constant with let
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                        
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20.0
        static let lineWidth: CGFloat = 3.0
        static let fontScale: CGFloat = 0.75
    }
}

/*
 
 ForEach is a for loop
 must have an identifier
 the identifier first here is id: \.self, which means the identifier
 is just the emojis array itself.
 Not the best thing to do here, especially if there are duplicate emoji in the array
 */

//lazyview grid is lazy about accessing the body vars for the views that actually appear on screen
struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    var body: some View {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(game.cards) { card in
                        CardView(card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                
                }
            }
            .foregroundColor(.red)
        .padding(.horizontal)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
            
    }
}
