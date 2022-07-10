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
                Pie(startAngle: Angle(degrees: 0-90), endAngle:Angle(degrees: 110-90))
                    .padding(5)
                    .opacity(0.5)
                Text(card.content).font(font(in: geometry.size))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360.0 : 0.0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits:geometry.size))
                }
            .cardify(isFaceUp: card.isFaceUp)
                }
            }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.5
        static let fontSize: CGFloat = 24
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
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
        })
            .foregroundColor(.red)
        .padding(.horizontal)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}

