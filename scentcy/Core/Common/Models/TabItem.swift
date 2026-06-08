//
//  TabItem.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import Foundation

enum TabItem: String, CaseIterable {
    case discover, journey

    var title: String {
        switch self {
        case .discover: return "Discover"
        case .journey:  return "Journey"
        }
    }

    var icon: String {
        switch self {
        case .discover: return "flask"
        case .journey:  return "bookmark"
        }
    }
}
