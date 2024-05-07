//
//  Checkbox.swift
//  ebayApp
//
//  Created by Megha Chandwani on 15/11/23.
//

import Foundation
import SwiftUI

struct ToggleCheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            
            
                
        }
    label:
        {
            Image(systemName: configuration.isOn ? "checkmark.square" :"square").symbolVariant(configuration.isOn ? .fill : .none).tint(configuration.isOn ? .blue : .gray)
                .onTapGesture{
                configuration.isOn.toggle()
                    
            }
            
    
        }
        
    }
    
}

//struct ToggleNewCheckboxStyle: ToggleStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        Button {
//            configuration.isOn.toggle()
//                
//        }
//    label:
//        {
//            Image(systemName: configuration.isOn ? "checkmark.square" :"square").symbolVariant(configuration.isOn ? .fill : .none).tint(configuration.isOn ? .blue : .gray)
//            
//    
//        }
//        
//    }
//    
//}
