//
//  LaunchScreen.swift
//  ebayApp
//
//  Created by Megha Chandwani on 06/12/23.
//

import SwiftUI

struct LaunchScreen: View {
    @State var isActive:Bool = false
    @State private var size:Double = 0.8
    @State private var opacity:Double = 0.5
    var body: some View {
        if isActive{
            ContentView()
        }
        else{
            
        VStack{
            HStack{
                Text("Powered by")
                Image("ebay")
                    .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 200)
            }.frame(width:300)
            
        
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.isActive = true
            }
        }
        }
    }
}

#Preview {
    LaunchScreen()
}
