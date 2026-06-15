//
//  SegmentedControl.swift
//  scentcy
//
//  Created by Fathimah Az Zahra Sanjani on 08/06/26.
//

import SwiftUI

struct SegmentedControl: View {
    @Binding var selected: JourneyTab

    var body: some View {
        HStack(spacing: 0) {
            SegmentButton(title: "History", isSelected: selected == .history) {
                withAnimation(.easeInOut(duration: 0.2)) { selected = .history }
            }
            SegmentButton(title: "Saved", isSelected: selected == .saved) {
                withAnimation(.easeInOut(duration: 0.2)) { selected = .saved }
            }
        }
        .background(Color.primary.opacity(0.06))
        .clipShape(Capsule())
    }
}

#Preview {
    @Previewable @State var selected: JourneyTab = .sniffed
    
    SegmentedControl(selected: $selected)
}
