import SwiftUI

struct NoseFatigueAlertView: View {
    var onContinue: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 24))
                    
                    Text("Nose Fatigue Warning")
                        .font(Typography.metric)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Step into fresh air or smell coffee beans to recalibrate your senses.")
                    .font(Typography.body)
                    .foregroundStyle(Color.black.opacity(0.8))
                    .lineSpacing(4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: onContinue) {
                    Text("Continue")
                        .font(Typography.bodyStrong)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Constants.UI.defaultPadding)
                        .background(Color.appPrimary)
                        .cornerRadius(Constants.UI.cornerRadius)
                }
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                    .fill(Color.white.opacity(0.85))
                    .background(
                        RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                            .fill(.ultraThinMaterial)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                    )
            )
            .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 10)
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    NoseFatigueAlertView(onContinue: {})
}
