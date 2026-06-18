//
//  Typography+Extension.swift
//  scentcy
//
//  Created by Zildjian Vito  on 05/06/26.
//

import SwiftUI

enum Typography {
    static let display = Font.system(size: 28, weight: .bold, design: .default)
    static let displayLarge = Font.system(size: 32, weight: .bold, design: .serif)
    static let screenTitle = Font.system(.title, design: .default, weight: .bold)
    static let metric = Font.system(.title2, design: .default, weight: .bold)
    static let body = Font.system(size: 17, weight: .regular, design: .default)
    static let bodyStrong = Font.system(.headline, design: .default, weight: .semibold) //bentrok sm di sketch
    static let label = Font.system(.footnote, design: .default, weight: .semibold)
    static let caption = Font.system(.caption, design: .default, weight: .bold)
    static let notes = Font.system(.title3, design: .default, weight: .regular)
    static let description = Font.system(.footnote, design: .default, weight: .regular)
    static let titlePerfume = Font.system(size: 17, weight: .bold, design: .default)
    static let sectionTitle = Font.system(size: 20, weight: .semibold, design: .default)
    static let sectionSubtitle = Font.system(size: 20, weight: .regular, design: .default)
    static let titleSubheadline = Font.system(size: 15, weight: .semibold, design: .default)
    static let detailPerfume = Font.system(size: 15, weight: .regular, design: .default)
    static let footnote = Font.system(size: 13, weight: .regular, design: .default)
    static let scentNotes = Font.system(size: 11, weight: .regular, design: .default)
    static let titleOnboard = Font.system(size: 17, weight: .semibold, design: .default)
    static let brandOnboard = Font.system(size: 11, weight: .semibold, design: .default)
    static let notesOnboard = Font.system(size: 11, weight: .regular, design: .default)
    static let flashcard = Font.system(size: 10, weight: .regular, design: .default)
}
    
