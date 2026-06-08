//
//  JourneyPerfume.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import Foundation

struct JourneyPerfume: Identifiable {
    let id = UUID()
    let name: String
    let brand: String
    let imageName: String
    var isSaved: Bool = false
}

let dummySniffed: [JourneyPerfume] = [
    JourneyPerfume(name: "Rose 31",      brand: "Le Labo",  imageName: "rose31"),
    JourneyPerfume(name: "Eau Capitale", brand: "Diptyque", imageName: "eaucapitale"),
    JourneyPerfume(name: "Rose 31",      brand: "Le Labo",  imageName: "rose31"),
    JourneyPerfume(name: "Eau Capitale", brand: "Diptyque", imageName: "eaucapitale"),
]

let dummySaved: [JourneyPerfume] = [
    JourneyPerfume(name: "Libre",  brand: "YSL",    imageName: "libre",  isSaved: true),
    JourneyPerfume(name: "My Way", brand: "Armani", imageName: "myway",  isSaved: true),
]   
