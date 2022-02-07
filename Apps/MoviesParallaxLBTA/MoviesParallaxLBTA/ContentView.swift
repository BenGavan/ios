//
//  ContentView.swift
//  MoviesParallaxLBTA
//
//  Created by Ben Gavan on 17/06/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(0..<20) { num in
                            GeometryReader { proxy in
                                Text(num.description)
                                    .font(.system(size: 30, weight: .bold))
//                                    .padding()
//                                    .scaleEffect(CGSize(width: 2, height: 2))
                            }
                            .background(Color.red)
                            .frame(width: 100, height: 150)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
