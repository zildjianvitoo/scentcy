//
//  ScannerReticleShape.swift
//  scentcy
//
//  Created by Zildjian Vito  on 04/06/26.
//

import SwiftUI

struct ScannerReticleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let length: CGFloat = 40 // Panjang garis di setiap sudut
        
        // Kiri Atas
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + length))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + length, y: rect.minY))
        
        // Kanan Atas
        path.move(to: CGPoint(x: rect.maxX - length, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + length))
        
        // Kanan Bawah
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY - length))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - length, y: rect.maxY))
        
        // Kiri Bawah
        path.move(to: CGPoint(x: rect.minX + length, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - length))
        
        return path
    }
}

#Preview {
    ScannerReticleShape()
}
