//
//  StepsView.swift
//  YazioApp.swift
//
//  Created by Abdulkodir Juraev on 11/11/25.
//

import SwiftUI

struct StepsView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Image(systemName: "figure.walk")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray.opacity(0.7))

                Text("Steps Tracking")
                    .font(.title2)
                    .bold()

                Text("Coming Soon...")
                    .font(.headline)
                    .foregroundColor(.gray)

                
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)

                Spacer()
            }
            .padding()
            .navigationTitle("Steps")
        }
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        StepsView()
    }
}
