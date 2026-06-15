import SwiftUI

struct PrimaryButton: View {
    var title: String
    var backgroundColor: Color = .appButton
    var textColor: Color = .black
    var isEnabled: Bool = true
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Typography.bodyStrong)
                .foregroundStyle(textColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, Constants.UI.defaultPadding)
                .background(backgroundColor)
                .cornerRadius(Constants.UI.cornerRadius)
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1.0 : 0.6)
    }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton(title: "Try Again", action: {})
        
        PrimaryButton(title: "Skip For Now", backgroundColor: .appGray, action: {})
        
        PrimaryButton(title: "Disabled Button", isEnabled: false, action: {})
    }
    .padding()
}
