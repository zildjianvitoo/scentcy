//
//  JourneyEmptyModel.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import Foundation

struct JourneyEmptyModel {
    let tab: JourneyTab

    var title: String {
        tab == .sniffed ? "No sniffed perfume yet" : "Nothing Saved Yet"
    }

    var subtitle: String {
        tab == .sniffed
            ? "Every perfume you snap will leave\na trace here"
            : "Tap ★ on any recommendations\nperfume to keep it here"
    }

    var imageName: String {
        tab == .sniffed ? "SniffedEmpty" : "SavedEmpty"
    }
}
