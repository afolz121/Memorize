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
    var isFaceUp: Bool = false //set the default option of isfaceUp as false to turn cards face down.
    var body: some View {
        ZStack{
            if isFaceUp {
                RoundedRectangle(cornerRadius: 20.0)
                    .fill()
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 20.0)
                    .stroke(lineWidth: 3.0)
                Text("✈️")
                    .foregroundColor(Color.blue)
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 20.0)
                    .fill()
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        HStack{
            CardView()
            CardView()
            CardView()
            CardView()
        }
            .padding(.horizontal)
            .foregroundColor(.red)
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

