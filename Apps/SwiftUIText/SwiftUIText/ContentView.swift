//
//  ContentView.swift
//  SwiftUIText
//
//  Created by Ben Gavan on 29/10/2019.
//  Copyright © 2019 Ben Gavan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hey there")
            .fontWeight(.bold)
            .font(.system(.largeTitle, design: .rounded))
            .foregroundColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
