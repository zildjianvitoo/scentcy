//
//  Typography+Extension.swift
//  scentcy
//
//  Created by Zildjian Vito  on 05/06/26.
//

import SwiftUI

enum Typography {
    static let display = Font.system(.title, design: .default, weight: .bold)
    static let displayLarge = Font.system(.largeTitle, design: .serif, weight: .bold)
    static let screenTitle = Font.system(.title, design: .default, weight: .bold)
    static let metric = Font.system(.title2, design: .default, weight: .bold)
    static let body = Font.system(.body, design: .default, weight: .regular)
    static let bodyStrong = Font.system(.headline, design: .default, weight: .semibold)
    static let label = Font.system(.footnote, design: .default, weight: .semibold)
    static let caption = Font.system(.caption, design: .default, weight: .bold)
    static let notes = Font.system(.title3, design: .default, weight: .regular)
    static let description = Font.system(.footnote, design: .default, weight: .regular)
    static let titlePerfume = Font.system(.body, design: .default, weight: .bold)
    static let sectionTitle = Font.system(.title3, design: .default, weight: .semibold)
    static let sectionSubtitle = Font.system(.title3, design: .default, weight: .regular)
    static let titleSubheadline = Font.system(.subheadline, design: .default, weight: .semibold)
    static let detailPerfume = Font.system(.subheadline, design: .default, weight: .regular)
    static let footnote = Font.system(.footnote, design: .default, weight: .regular)
    static let scentNotes = Font.system(.caption2, design: .default, weight: .regular)
    static let titleOnboard = Font.system(.body, design: .default, weight: .semibold)
    static let brandOnboard = Font.system(.caption2, design: .default, weight: .semibold)
    static let notesOnboard = Font.system(.caption2, design: .default, weight: .regular)
    static let scannerStatus = Font.system(.caption2, design: .monospaced, weight: .medium)
}
