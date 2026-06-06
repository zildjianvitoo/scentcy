import SwiftUI

struct PerfumeNotFoundSheet: View {
    var onRetake: () -> Void
    var onSkip: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "photo")
                .font(.system(size: 60))
                .foregroundColor(.black)
                .padding(.top, 30)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Oops! Perfume Not Found")
                    .font(Typography.metric)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                Text("We couldn't match this photo with our database. Please make sure the bottle label and brand name are clearly visible.")
                    .font(Typography.body)
                    .foregroundColor(Color.black.opacity(0.8))
                    .lineSpacing(4)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            
            Spacer(minLength: 16)
            
            VStack(spacing: 12) {
                Button(action: onRetake) {
                    Text("Retake Photo")
                        .font(Typography.bodyStrong)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Constants.UI.defaultPadding)
                        .background(Color.appPrimary)
                        .cornerRadius(Constants.UI.cornerRadius)
                }
                
                Button(action: onSkip) {
                    Text("Skip For Now")
                        .font(Typography.bodyStrong)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Constants.UI.defaultPadding)
                        .background(Color.appGray)
                        .cornerRadius(Constants.UI.cornerRadius)
                }
            }
            .padding(.bottom, 20)
        }
        .padding(.top, 16)
        .padding(.horizontal, 24)
        .background(Color.white)
    }
}

#Preview {
    PerfumeNotFoundSheet(onRetake: {}, onSkip: {})
}
