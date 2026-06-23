//
//  ToastNotification.swift
//  scentcy
//
//  Created by Afra on 18/06/26.
//
import SwiftUI

import SwiftUI

struct ToastNotificationAddPerfume: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showToast: Bool
    var perfumeName: String
    
    var body: some View {
        VStack {
            HStack {
                Image (systemName: "checkmark.circle.fill")
                
                Text("\(perfumeName) is added to Journey")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer(minLength: 12)
                
                Button("View") {
                    withAnimation { showToast = false }
                    dismiss()
                    NotificationCenter.default.post(name: NSNotification.Name("SwitchToJourneyHistory"), object: nil)
                }
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color(hex: "E1B376"))
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color.white)
                .cornerRadius(20)
            }
            .padding()
            .background(Color(hex: "FAFAFA"))
            .cornerRadius(15)
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
            .gesture(
                DragGesture(minimumDistance: 10, coordinateSpace: .local)
                    .onChanged { value in
                        if value.translation.height < -20 {
                            withAnimation { showToast = false }
                        }
                    }
            )
            .transition(.move(edge: .top).combined(with: .opacity))
            Spacer()
        }
        .zIndex(100)
    }
}

#Preview {
    ToastNotificationAddPerfume(showToast: .constant(true), perfumeName: "Libre Intense EDP")
}

