//
//  ToastNotification.swift
//  scentcy
//
//  Created by Afra on 18/06/26.
//
import SwiftUI

import SwiftUI

struct ToastNotification: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showFavoriteToast: Bool
    // ntar kalo mau dibedain bakal pake var, kalau ga salah dua kali muncul notif kaya gini.
//    var icon: String
//    var content: String
    
    var body: some View {
        VStack {
            HStack {
                Image (systemName: "checkmark.circle.fill")
                
                
                Text("Saved to your favourites")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer(minLength: 12)
                
                Button("View") {
                    withAnimation { showFavoriteToast = false }
                    dismiss()
                    NotificationCenter.default.post(name: NSNotification.Name("SwitchToJourneySaved"), object: nil)
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
                            withAnimation { showFavoriteToast = false }
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
    ToastNotification(showFavoriteToast: .constant(true))
}

