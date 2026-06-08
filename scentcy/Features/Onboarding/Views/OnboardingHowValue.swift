//
//  OnboardingHowValue.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI

struct OnboardingHowValue: View {
    @State private var navigateToContent = false
    var body: some View {
        VStack(spacing: 40) {


            Spacer()

            VStack(spacing: 40) {
                HStack {
                    Image(.illustResult)
                        .frame(width: 316, height: 357)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(Constants.UI.cornerRadius)
                }
               
                VStack(alignment: .leading) {
                        Text("Meet Your Scent")
                            .font(.title.bold())
                    
                 
                  
                    Text("Personality")
                        .font(.title.bold())
                        .italic()
                        .foregroundStyle(Color.highlitedText)
                        
                    Text("See the scent traits that best describe your perfume taste.")
                        .frame(width: 316, height: 50)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                }
                .frame(width: 316, alignment: .leading)
               // Spacer()
                PrimaryButton(title: "Next", backgroundColor: .appButton) {
                    navigateToContent = true
                }
                .navigationDestination(isPresented: $navigateToContent) {
                    ContentView()
                }
            }

            Spacer()

  
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: ContentView()){
                    Text("Skip")
                }
            }
            ToolbarItem (placement: .principal) {
                OnboardingProgressDots(currentPage: 4)
            }
        }
    }
    }

#Preview {
    OnboardingHowValue()
}
