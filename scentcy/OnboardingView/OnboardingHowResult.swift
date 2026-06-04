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
            OnboardingProgressDots(currentPage: 3)
                .padding(.top, 20)

            Spacer()

            VStack(spacing: 40) {
                HStack {
                    Image(.illustResult)
                        .frame(width: 316, height: 357)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(24)
                }
               
                VStack(alignment: .leading) {
                    HStack {
                        Text("Get")
                            .font(.title.bold())
                        Text("Personalized")
                            .font(.title.bold())
                            .foregroundStyle(Color.highlightedText)
                    }
                 
                  
                    Text("Recommendations")
                        .font(.title.bold())
                        
                    Text("Discover new perfumes chosen based on the scents you've liked before.")
                        .frame(width: 316, height: 50)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                }
                .frame(width: 316, alignment: .leading)
                
                NavigationLink(destination: OnboardingWhat()) {
                    Text("Next")
                        .frame(width: 303, height: 48)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.black)
            }

            Spacer()

  
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.brandsecondarycream)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Skip") {
                    
                }
            }
        }
    }
}


#Preview {
    OnboardingHowResult()
}
