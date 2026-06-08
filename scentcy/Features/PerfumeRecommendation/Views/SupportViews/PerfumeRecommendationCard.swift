import SwiftUI

struct PerfumeRecommendationCard: View {
    let perfume: Perfume
    
    var body: some View {
        HStack(spacing: 16) {
            // Image
            Image(perfume.name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .padding(8)
                .background(Color.white)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.appSecondary, lineWidth: 2)
                )
            
            // Text Details
            VStack(alignment: .leading, spacing: 6) {
                Text(perfume.name)
                    .font(Typography.bodyStrong)
                    .foregroundColor(.black)
                
                Text(perfume.brand)
                    .font(Typography.body)
                
                // Tags
                HStack(spacing: 8) {
                    let allowedTags = Set(["Day", "Night", "Formal", "Informal", "Casual"])
                    ForEach(perfume.tags.filter { allowedTags.contains($0) }, id: \.self) { tag in
                        Text(tag)
                            .font(Typography.label)
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(tag == "Day" ? Color.appSecondary.opacity(0.4) : Color.appPrimary.opacity(0.4))
                            .cornerRadius(10)
                    }
                }
                .padding(.top, 8)
            }
            
            Spacer()
        }
        .padding(Constants.UI.defaultPadding)
        .background(Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                .stroke(Color.appGray, lineWidth: 1)
        )
    }
}

#Preview {
    ZStack {
        Color.appBackground.ignoresSafeArea()
        PerfumeRecommendationCard(perfume: Perfume(name: "Eau Capitale", brand: "Diptyque", imageName: "goodgirl", tags: ["Day", "Casual"]))
            .padding()
    }
}
