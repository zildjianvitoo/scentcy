//
//  ShutterButtonStyle.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 12/06/26.
//

import SwiftUI

struct ShutterButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                Circle()
                    .fill(configuration.isPressed ? Color.appButton : Color.clear)
            )
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
