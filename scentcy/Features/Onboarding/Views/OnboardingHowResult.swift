//
//  OnboardingHowResult.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI

struct OnboardingHowResult: View {
    var body: some View {
        VStack(spacing: 40) {


            Spacer()

            VStack(spacing: 40) {
                HStack {
                    Image(.illustResult)
                        .imageStyle()
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
                NavigationLink(destination: OnboardingHowValue()) {
                    Text("Next")
                        .frame(width: 303, height: 48)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.appButton)
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
