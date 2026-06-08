//
//  OnboardingHowResult.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI

struct OnboardingHowResult: View {
    @State private var navigateToValue = false
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
                    HStack {
                        Text("Get")
                            .font(.title.bold())
                        Text("Personalized")
                            .font(.title.bold())
                            .foregroundStyle(.highlitedText)
                    }
                 
                  
                    Text("Recommendations")
                        .font(.title.bold())
                        
                    Text("Discover new perfumes chosen based on the scents you've liked before.")
                        .frame(width: 316, height: 50)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                }
                .frame(width: 316, alignment: .leading)
                //Spacer()
                PrimaryButton(title: "Next", backgroundColor: .appButton) {
                    navigateToValue = true
                }
                .navigationDestination(isPresented: $navigateToValue) {
                    OnboardingHowValue()
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
                OnboardingProgressDots(currentPage: 3)
            }
        }
    }
}


#Preview {
    OnboardingHowResult()
}
