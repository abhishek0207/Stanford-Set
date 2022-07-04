//
//  GameViewModel.swift
//  Set
//
//  Created by Ahuja, Abhishek on 6/12/22.
//

import Foundation
import SwiftUI

public enum StandardShapeTypes : CaseIterable {
    case diamond
    case oval
    case squiggle
}
public enum StandardShadeTypes : CaseIterable {
    case filled
    case empty
    case lines
}

public class StandardSetViewModel : ObservableObject {
    public static let allowedColors : [Color]  = [.red, .purple, .green]
    @Published private var gameModel : GameModel<StandardShapeTypes, StandardShadeTypes> // with published whenever there will be a change in model, this will get published
    private var currentCards : [Card<StandardShapeTypes, StandardShadeTypes>] = []
    public static func createStandardGameCards() -> [Card<StandardShapeTypes, StandardShadeTypes>] {
        var allCards : [Card<StandardShapeTypes, StandardShadeTypes>] = []
        var index = 0
        for shape in StandardShapeTypes.allCases {
            for count in 1...3 {
            for color in allowedColors {
                for shading in StandardShadeTypes.allCases {
                    allCards.append(Card(id : index, shape: shape, countOfShape: count, color: color, shading: shading))
                    index+=1
                }
            }
        }

        }
        return allCards.shuffled()
    }
    public func resetGame() {
        gameModel = GameModel(inputCards: StandardSetViewModel.createStandardGameCards(), size: 72)
        
    }
    public func dealNewCards() {
        if gameModel.hasFoundASet {
            gameModel.dealNewCards()
        }
    }
    public var shouldDealNewCards : Bool {
        return gameModel.isDeckEmpty
    }
    public var gameMessage: String {
        return  gameModel.gameMessage
    }
    public var score : Int {
        return gameModel.score
    }
    public var cards : [Card<StandardShapeTypes, StandardShadeTypes>] {
        return gameModel.dealtCards
    }
    public init(gameModel :  GameModel<StandardShapeTypes, StandardShadeTypes> ) {
        self.gameModel = gameModel
    }
    public func choose(card : Card<StandardShapeTypes, StandardShadeTypes>) {
        return gameModel.choose(card: card)
    }

}
