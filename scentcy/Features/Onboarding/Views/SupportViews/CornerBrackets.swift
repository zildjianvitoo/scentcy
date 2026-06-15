//
//  CornerBrackets.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 15/06/26.
//

import SwiftUI

struct CornerBrackets: View {
    var color: Color = Color.primary.opacity(0.4)
    var length: CGFloat = 24
    var thickness: CGFloat = 3

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            Path { path in
                // Top-left
                path.move(to: CGPoint(x: 0, y: length))
                path.addLine(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: length, y: 0))
                // Top-right
                path.move(to: CGPoint(x: w - length, y: 0))
                path.addLine(to: CGPoint(x: w, y: 0))
                path.addLine(to: CGPoint(x: w, y: length))
                // Bottom-left
                path.move(to: CGPoint(x: 0, y: h - length))
                path.addLine(to: CGPoint(x: 0, y: h))
                path.addLine(to: CGPoint(x: length, y: h))
                // Bottom-right
                path.move(to: CGPoint(x: w - length, y: h))
                path.addLine(to: CGPoint(x: w, y: h))
                path.addLine(to: CGPoint(x: w, y: h - length))
            }
            .stroke(color, style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .round))
        }
    }
}
