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
        tab == .history ? "No perfume snapped yet" : "Nothing Saved Yet"
    }

    var subtitle: String {
        tab == .history
            ? "Every perfume you like and upload\nwill leave its mark here"
            : "Tap ★ on any recommendations\nperfume to keep it here"
    }

    var imageName: String {
        tab == .history ? "sniffedEmpty" : "savedEmpty"
    }
}
