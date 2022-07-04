//
//  Diamond.swift
//  Set
//
//  Created by Ahuja, Abhishek on 6/25/22.
//

import Foundation
import SwiftUI

struct Diamond : Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let startingPoint  = CGPoint(x: rect.maxX , y : rect.midY)
        p.move(to: startingPoint)
        let secondPoint = CGPoint(x: rect.midX, y : rect.maxY)
        p.addLine(to: secondPoint)
        let thirdPoint = CGPoint(x: rect.minX, y : rect.midY)
        p.addLine(to: thirdPoint)
        let fourthPoint = CGPoint(x: rect.midX, y : rect.minY)
        p.addLine(to: fourthPoint)
        p.addLine(to: startingPoint)
        return p
    }
}
