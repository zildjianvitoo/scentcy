//
//  OnboardingWhat.swift
//  scentcy
//
//  Created by Afra on 04/06/26.
//

import SwiftUI

struct OnboardingWhat: View {
    var body: some View {
        VStack(spacing: 40) {
            OnboardingProgressDots(currentPage: 1)
                .padding(.top, 20)
            
            Spacer()
            
            VStack(spacing: 40) {
                HStack {
                    Image(systemName: "zzz")
                        .frame(width: 177, height: 150)
                        .background(Color.gray.opacity(0.2))
                    Spacer()
                }
               
                VStack(alignment: .leading) {
                    Text("Find Your Next Bottle,")
                        .font(.title.bold())
                    Text("Effortlessly.")
                        .font(.title.bold())
                    
                    Text("Forget complex perfumes theories. Discover new perfumes based on what you love.")
                        .font(.callout)
                }
            }
            
            Spacer()
            
            NavigationLink(destination: OnboardingHow()) {
                Text("See how it works!")
                    .frame(width: 303, height: 48)
                    
            }
          //  .buttonStyle(Color.black)
            .buttonStyle(.borderedProminent)
            .tint(Color.black)
        }
        .padding(20)
        .background(Color.brandSecondaryCream)
        //.frame(maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Skip") {
                    
                }
            }
        }
    }
}
       
#Preview {
    NavigationStack {
        OnboardingWhat()
    }
}
