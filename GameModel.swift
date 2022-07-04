//
//  GameModel.swift
//  Set
//
//  Created by Ahuja, Abhishek on 6/12/22.
//

import Foundation
import SwiftUI

public struct GameModel<GameShape, GameShading> where GameShape : Equatable, GameShading: Equatable{
    public var cards : [Card<GameShape, GameShading>]
    public var dealtCards: [Card<GameShape, GameShading>]
    public var gameMessage: String = ""
    public var score = 0
    public var hasFoundASet : Bool = true
    public var isDeckEmpty = false
    init(inputCards : [Card<GameShape, GameShading>], size: Int) {
        self.dealtCards = Array(inputCards.prefix(upTo: size))
        self.cards =  Array(inputCards[size..<inputCards.count])
    }
    func checkForSet(on selectedIndices : [Int]) -> Bool {
        if selectedIndices.count > 3 {
            fatalError("User selected more than 3 cards, this should not be happening!!")
        }
        
        let card1 = dealtCards[selectedIndices[0]]
        let card2 = dealtCards[selectedIndices[1]]
        let card3 = dealtCards[selectedIndices[2]]
        let colorCheck = (card1.color == card2.color && card2.color == card3.color) || (card1.color != card2.color && card2.color != card3.color && card1.color != card3.color)
        let shapeCheck =  (card1.shape == card2.shape && card2.shape == card3.shape) || (card1.shape != card2.shape && card2.shape != card3.shape && card1.shape != card3.shape)
        let shadingCheck =  (card1.shading == card2.shading && card2.shading == card3.shading) || (card1.shading != card2.shading && card2.shading != card3.shading && card1.shading != card3.shading)
        let numCheck =  (card1.countOfShape == card2.countOfShape && card2.countOfShape == card3.countOfShape) || (card1.countOfShape != card2.countOfShape && card2.countOfShape != card3.countOfShape && card1.countOfShape != card3.countOfShape)
        print("color check \(colorCheck)")
        print("shape Check \(shapeCheck)")
        print("shadingCheck \(shadingCheck)")
        print("numCheck \(numCheck)")
        
       return colorCheck && shapeCheck && shadingCheck && numCheck
        
    }
    public func getSelectedCards() -> [Int] {
        return dealtCards.indices.filter{
            dealtCards[$0].isSelected == true
            
        }
    }
    
    mutating func dealNewCards()  {
        print("called function")
        let selectedCards = getSelectedCards()
        let newRange : [Card<GameShape, GameShading>] = Array(cards.prefix(through: 2))
        cards = Array(cards.dropFirst(3))
        dealtCards[selectedCards[0]] = newRange[0]
        dealtCards[selectedCards[1]] = newRange[1]
        dealtCards[selectedCards[2]] = newRange[2]
        if cards.count == 0 {
            isDeckEmpty = true
        }
    }
    mutating  func choose(card : Card<StandardShapeTypes, StandardShadeTypes>) {
        let choosenIndex = dealtCards.indices.filter({
            self.dealtCards[$0].id == card.id
        }).first
        guard let choosenIndex = choosenIndex else {
            return
        }
        self.dealtCards[choosenIndex].isSelected = !self.dealtCards[choosenIndex].isSelected
        
        let selectedCards : [Int] = getSelectedCards()
        print("chose card \(card)")
        if selectedCards.count == 4 {
            dealtCards.indices.forEach {
                index in
                dealtCards[index].isSelected = false
            }
            self.dealtCards[choosenIndex].isSelected = !self.dealtCards[choosenIndex].isSelected
        }
        else if selectedCards.count == 3 {
         
            if checkForSet(on : selectedCards) {
                gameMessage = "Thats a set. Good One!!"
                hasFoundASet = true
                score+=1
                if isDeckEmpty {
                    selectedCards.sorted().reversed().forEach {
                        index in
                        dealtCards.remove(at: index)
                    }
                }
            } else {
                hasFoundASet = false
                gameMessage = "Unfortunately thats not a set, try again!!"
                score-=1
            }
        }
        
    }
    
}
public struct Card<ShapeType, ShadeType> : Identifiable {
    public var id: Int
    public var shape: ShapeType
    public var countOfShape: Int
    public var color : Color
    public var shading: ShadeType
    public var isSelected: Bool = false
}
