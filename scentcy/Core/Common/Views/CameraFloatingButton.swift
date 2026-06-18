import SwiftUI

struct CameraFloatingButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {

                Image(systemName: "camera")
                    .font(.system(.title2, weight: .semibold))
                    .foregroundStyle(Color(hex: "1F4360"))
            }
            .frame(width: 58, height: 58)
            .accessibilityLabel("Open Camera")
        }
        .buttonStyle(.glass)
        .tint(Color.blue)
        .background(Color.blue)
        .clipShape(Circle())
        
     

        
    }
}
#Preview {
    CameraFloatingButton(action: {})
        .padding()
}
