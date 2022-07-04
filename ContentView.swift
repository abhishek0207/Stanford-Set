//
//  ContentView.swift
//  Set
//
//  Created by Ahuja, Abhishek on 6/12/22.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel : StandardSetViewModel = StandardSetViewModel(gameModel: GameModel(inputCards: StandardSetViewModel.createStandardGameCards(), size: 72))
    var body: some View {
        VStack {
            ZStack {
                HStack {
                Button("New game") {
                    viewModel.resetGame()
                    }
                Spacer()
                    Button("Deal 3 More Cards") {
                        viewModel.dealNewCards()
                    }
                    .disabled(viewModel.shouldDealNewCards)
                }
                Text("SET")
            }
            AspectVGrid(items: Array(viewModel.cards), aspectRatio: 2/3){
                card in
                CardView(card: card)
                    .onTapGesture {
                        viewModel.choose(card: card)
                    }
                    .padding(5)
    }
            HStack {
                Text("Score: \(viewModel.score)")
                Spacer()
                Text(viewModel.gameMessage)
                    .font(.system(size: 20, design: .serif))
               
            }
        }
       
        .padding()
    }
    
}

struct ShapeView: View {
    var card:  Card<StandardShapeTypes, StandardShadeTypes>
    var body: some View {
        GeometryReader {
            geometry in
            VStack(spacing: 2) {
           
            ForEach(0..<card.countOfShape, id: \.self ) { _ in
            createShapeOn(card: card)
                        .frame(width: geometry.size.width*0.2 , height: geometry.size.height*0.2)
                }
            }
        .position(x: geometry.frame(in: .local).midX, y:  geometry.frame(in: .local).midY)
        
        }
    } 
    @ViewBuilder func createShapeOn(card : Card<StandardShapeTypes, StandardShadeTypes>) -> some View {
    if card.shape == .diamond {
        if card.shading == .empty {
            Diamond()
                .stroke(card.color)
        }
        else if card.shading == .filled {
            Diamond()
                .fill(card.color)
        }
        else {
            Diamond()
            .fill(card.color)
            .opacity(0.4)
        }
    }
    if card.shape == .oval {
        if card.shading == .filled {
         Ellipse()
            .fill(card.color)
            .zIndex(2)
        }
        if card.shading == .empty {
            Ellipse()
                .stroke(card.color)
                .zIndex(2)
            }
    if card.shading == .lines {
        Ellipse()
            .fill(card.color)
            .opacity(0.4)
            .zIndex(2)
        }
    }
    if card.shape == .squiggle {
        if card.shading == .filled {
         Rectangle()
            .fill(card.color)
            .zIndex(2)
        }
        if card.shading == .empty {
             Rectangle()
                .stroke(card.color)
                .zIndex(2)
            }
    if card.shading == .lines {
         Rectangle()
            .fill(card.color)
            .opacity(0.4)
            .zIndex(2)
        }
    }
    }
}

struct CardView : View {
    var card: Card<StandardShapeTypes, StandardShadeTypes>
    var body: some View {
        ZStack {
            if card.isSelected {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill()
                    .foregroundColor(.red)
                    .opacity(0.3)
                    .aspectRatio(2 / 3, contentMode: .fit)
                ShapeView(card: card)
            }
            else {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .stroke(.blue, lineWidth: 2)
                    .foregroundColor(.white)
                    .aspectRatio(2 / 3, contentMode: .fit)
                ShapeView(card: card)
            }
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
