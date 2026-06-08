//
//  PerfumeDetailView.swift
//  scentcy
//
//  Created by Afra on 06/06/26.
//

import SwiftUI

struct PerfumeDetailView: View {
    @Environment(\.dismiss) private var dismiss

    let icon: String
    let productName: String
    let brand: String

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ProductTopBar(
                        icon: icon,
                        ProductName: productName,
                        brand: brand
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
                        // TODO: Implement Favorite Logic
                    }) {
                        Image(systemName: "star")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }

}

#Preview {
    PerfumeDetailView(
        icon: "goodgirl1",
        productName: "GoodGirl",
        brand: "Carolina Herrera"
    )
}
