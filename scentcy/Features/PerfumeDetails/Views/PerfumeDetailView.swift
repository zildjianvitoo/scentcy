//
//  PerfumeDetailView.swift
//  scentcy
//
//  Created by Afra on 06/06/26.
//

import SwiftUI
import SwiftData

struct PerfumeDetailView: View {
    @Environment(\.dismiss) private var dismiss

    @Bindable var perfume: Perfume

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ProductTopBar(
                        icon: perfume.imageName,
                        ProductName: perfume.name,
                        brand: perfume.brand
                    )

                    VStack(alignment: .leading, spacing: 32) {
                        
                        // Performance Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Performance")
                                .font(.title3)
                                .fontWeight(.semibold)

                            VStack(spacing: 16) {
                                SliderIndicator(
                                    value: 2,
                                    title: "Longevity",
                                    low: "Very Weak",
                                    high: "Long Lasting"
                                )
                                SliderIndicator(
                                    value: 3,
                                    title: "Sillage",
                                    low: "Intimate",
                                    high: "Enormous"
                                )
                            }
                        }

                        // Time Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Time")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            HStack(spacing: 16) {
                                TimeOccasionCard(title: "Day", icon: "sun.max", value: 2)
                                TimeOccasionCard(title: "Night", icon: "moon", value: 4)
                            }
                        }
                        
                        // Occasion Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Occasion")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            HStack(spacing: 16) {
                                TimeOccasionCard(title: "Formal", icon: "jacket", value: 4)
                                TimeOccasionCard(title: "Informal", icon: "tshirt", value: 2)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    .padding(.bottom, 40)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(Color.appBackground.ignoresSafeArea())
            .ignoresSafeArea(edges: .top)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        perfume.isFavorite.toggle()
                    }) {
                        Image(systemName: perfume.isFavorite ? "star.fill" : "star")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(perfume.isFavorite ? .yellow : .primary)
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }

}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Perfume.self, configurations: config)
    let mockPerfume = Perfume(name: "GoodGirl", brand: "Carolina Herrera", imageName: "goodgirl1")
    
    return PerfumeDetailView(perfume: mockPerfume)
        .modelContainer(container)
}
