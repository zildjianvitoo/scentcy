//
//  ScanFailedModal.swift
//  scentcy
//
//  Created by Afra on 06/06/26.
//

import SwiftUI

struct ScanFailedModal: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            VStack (alignment: .leading, spacing: 45) {
                VStack (alignment: .leading) {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .resizable()
                        .frame(width: 57, height: 57)
                        .foregroundColor(Color.red)
                }
                
                VStack (alignment: .leading) {
                    Text ("Oops! Perfume Not \nFound")
                        .multilineTextAlignment(.leading)
                        .font(Typography.display)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
            }
            
            VStack (alignment: .leading) {
                Text("We couldn't match this photo with our database. Please make sure the bottle label and brand name are clearly visible.")
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 46)
    }
}

#Preview {
    ScanFailedModal()
}
