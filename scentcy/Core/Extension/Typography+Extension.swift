//
//  Typography+Extension.swift
//  scentcy
//
//  Created by Zildjian Vito  on 05/06/26.
//

import SwiftUI

enum Typography {
    static let display = Font.system(.title, design: .default, weight: .bold)
    static let screenTitle = Font.system(.title2, design: .serif, weight: .semibold)
    static let metric = Font.system(.title2, design: .default, weight: .bold)
    static let body = Font.system(.body, design: .default, weight: .regular)
    static let bodyStrong = Font.system(.headline, design: .default, weight: .semibold)
    static let label = Font.system(.footnote, design: .default, weight: .semibold)
    static let caption = Font.system(.caption, design: .default, weight: .bold)
}
