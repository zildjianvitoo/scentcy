import SwiftUI

struct CameraFloatingButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "E6F2FC"), Color(hex: "A3CAEC")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay {
                        Circle()
                            .stroke(Color.white.opacity(0.8), lineWidth: 2)
                    }
                    .shadow(color: Color(hex: "A3CAEC").opacity(0.6), radius: 8, x: 0, y: 4)
                    .frame(width: 64, height: 64)

                Image(systemName: "plus")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(Color(hex: "1F4360"))
            }
        }
    }
}

#Preview {
    CameraFloatingButton(action: {})
        .padding()
}
