import SwiftUI

struct PerfumeFilterSheet: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: PerfumeRecommendationViewModel
    
    // Categories
    let longevities = ["Eternal", "Long Lasting", "Moderate", "Weak", "Very Weak"]
    let sillages = ["Intimate", "Moderate", "Strong", "Enormous"]
    let times = ["Day", "Night"]
    let occasions = ["Formal", "Casual"]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(.callout, weight: .bold))
                        .foregroundColor(.primary)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.7))
                                .background(.ultraThinMaterial)
                        )
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .strokeBorder(Color.white, lineWidth: 1)
                        )
                }
                
                Spacer()
                
                Text("Filter")
                    .font(Typography.bodyStrong)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        viewModel.clearFilter()
                    }
                }) {
                    Text("Clear All")
                        .font(Typography.body)
                        .foregroundColor(Color.appButton)
                }
            }
            .padding(Constants.UI.defaultPadding)
            .padding(.top, 10)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Longevity
                    filterSection(title: "Longevity", options: longevities, selectedOptions: $viewModel.selectedLongevities, displayMapper: formatLongevity)
                    
                    // Sillage
                    filterSection(title: "Sillage", options: sillages, selectedOptions: $viewModel.selectedSillages)
                    
                    // Time
                    filterSection(title: "Time", options: times, selectedOptions: $viewModel.selectedTimes)
                    
                    // Occasion
                    filterSection(title: "Occasion", options: occasions, selectedOptions: $viewModel.selectedOccasions)
                    
                }
                .padding(Constants.UI.defaultPadding)
            }
            
            // Bottom Button
            VStack {
                PrimaryButton(title: "Show Result") {
                    viewModel.applyFilter()
                    dismiss()
                }
                
                .padding(.horizontal, Constants.UI.defaultPadding)
                .padding(.vertical, Constants.UI.defaultPadding)
            }
            .background(Color.appBackground)
        }
        .background(Color.appBackground)
        .presentationDetents([.large]) // Use full sheet or large detent
        .presentationDragIndicator(.visible)
    }
    
    // Helper View for Sections
    @ViewBuilder
    private func filterSection(title: String, options: [String], selectedOptions: Binding<Set<String>>, displayMapper: ((String) -> String)? = nil) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(Typography.bodyStrong)
                .foregroundColor(.secondary)
            
            FlowLayout(spacing: 10) {
                ForEach(options, id: \.self) { option in
                    let isSelected = selectedOptions.wrappedValue.contains(option)
                    let displayText = displayMapper?(option) ?? option
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            if isSelected {
                                selectedOptions.wrappedValue.remove(option)
                            } else {
                                selectedOptions.wrappedValue.insert(option)
                            }
                        }
                    }) {
                        Text(displayText)
                            .font(Typography.body)
                            .foregroundColor(.primary)
                            .padding(.horizontal, Constants.UI.defaultPadding)
                            .padding(.vertical, 10)
                            .background(isSelected ? Color.appButton.opacity(0.15) : Color.appGray)
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
}

#Preview {
    Text("Preview")
        .sheet(isPresented: .constant(true)) {
            PerfumeFilterSheet(viewModel: PerfumeRecommendationViewModel())
        }
}
