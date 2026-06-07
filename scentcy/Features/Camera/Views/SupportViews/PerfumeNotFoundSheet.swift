import SwiftUI

struct PerfumeNotFoundSheet: View {
    var onTryAgain: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Image("perfumeNotFound")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 120)
                .padding(.top, 30)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Perfume Not Found!")
                    .font(Typography.metric)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                Text("Try a clearer shot, or snap a different bottle")
                    .font(Typography.body)
                    .lineSpacing(4)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            
            Spacer(minLength: 16)
            
            PrimaryButton(title: "Try Again", action: onTryAgain)
            .padding(.bottom, 20)
        }
        .padding(.top, 16)
        .padding(.horizontal, 24)
        .background(Color.appBackground)
    }
}

#Preview {
    PerfumeNotFoundSheet(onTryAgain: {})
}
