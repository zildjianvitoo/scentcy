//
//  OnboardingHow.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI

struct OnboardingHow: View {
    var body: some View {
        VStack(spacing: 40) {
            OnboardingProgressDots(currentPage: 2)
                .padding(.top, 20)


            VStack(spacing: 40) {
                HStack {
                    Image(.illustOnboard)
                        .resizable()
                        .frame(width: 316, height: 357)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(16)
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
                            .foregroundColor(.highlightedText)
                        
                    }
                   
                    Text("Upload perfumes you've smelled and liked. We'll learn your scent preferences from there.")
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .frame(width: 316, height: 60, alignment: .topLeading)
                    Spacer()
                        
                    NavigationLink(destination: OnboardingHowResult()) {
                        Text("Next")
                            .frame(width: 303, height: 48)
                    }
                    .tint(Color.black)
                    .buttonStyle(.borderedProminent)
                }
                .frame(width: 316, alignment: .leading)
                
            }

    
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.brandsecondarycream)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Skip") {
                    
                }
            }
        }
        
        
    }
       
}

#Preview {
    OnboardingHow()
}
