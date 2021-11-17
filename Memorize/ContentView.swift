//
//  ContentView.swift
//  Memorize
//
//  Created by Andrew Folz on 11/9/21.
//

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
    var content: String
    @State var isFaceUp: Bool = true //set the default option of isfaceUp as false to turn cards face down. @State makes a pointer and overwrites the 'state' of the variable.
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20.0) //make shape a constant with let
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3.0)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture(perform: {
            isFaceUp = !isFaceUp
        })
    }
}


/*
 
 ForEach is a for loop
 must have an identifier
 the identifier first here is id: \.self, which means the identifier
 is just the emojis array itself.
 Not the best thing to do here, especially if there are duplicate emoji in the array
 */

struct ContentView: View {
    var emojis: [String] = ["🚗", "🚑", "🚓", "✈️", "🚜", "🏎",
                            "🚕", "🚀", "🚌", "🛺", "🚔", "🛸",
                            "🚁", "🚲", "🛴", "🛰", "🚎", "🚨",
                            "🚆", "🚛", "🚤", "⛵️", "🎡", "🚦"]
    @State var emoji_count: Int = 4
                            
    var body: some View {
        VStack {
            HStack{
                ForEach(emojis[0..<emoji_count], id: \.self) { emoji in
                    CardView(content: emoji)
                }
            }
            
            HStack {
                removeButton
                Spacer()
                addButton
            }
            .padding(.horizontal)
        }
            .padding(.horizontal)
            .foregroundColor(.red)
    }
    var addButton: some View {
        Button(action: {emoji_count += 1}, label: {
            VStack {
                Text("Add")
                Text("Card")
            }
        })
    }
    var removeButton: some View {
        Button(action: {emoji_count -= 1}, label: {
            VStack {
                Text("Remove")
                Text("Card")
            }
        })
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
            
    }
}

