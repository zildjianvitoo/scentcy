//
//  OnboardingHow.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI

struct OnboardingHow: View {
    @State private var navigateToResult = false
    var body: some View {
        VStack(spacing: 40) {


            VStack(spacing: 40) {
                HStack {
                    Image(.illustOnboard)
                        .resizable()
                        .frame(width: 316, height: 357)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(Constants.UI.cornerRadius)
                }
               
                VStack(alignment: .leading) {
                    Text("Share Perfumes")
                        .font(.title.bold())
                    HStack{
                        Text("You")
                            .font(.title.bold())
                        Text("enjoy")
                            .font(.title.bold())
                            .italic()
                            .foregroundColor(.highlitedText)
                        
                    }
                   
                    Text("Upload perfumes you've smelled and liked. We'll learn your scent preferences from there.")
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .frame(width: 316, height: 60, alignment: .topLeading)
                    Spacer()
                        
                    PrimaryButton(title: "Next", backgroundColor: .appButton) {
                        navigateToResult = true
                    }
                    .navigationDestination(isPresented: $navigateToResult) {
                        OnboardingHowResult()
                    }
                }
                .frame(width: 316, alignment: .leading)
                
            }

    
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
               NavigationLink(destination: ContentView()) {
                    Text("skip")
                }
            }
            ToolbarItem (placement: .principal) {
                OnboardingProgressDots(currentPage: 2)
            }
        }
        
        
    }
       
}

#Preview {
    OnboardingHow()
}
