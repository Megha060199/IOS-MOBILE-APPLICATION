//
//  SharedVariables.swift
//  ebayApp
//
//  Created by Megha Chandwani on 15/11/23.
//

import Foundation
import SwiftUI
import Combine

class SharedVariables: ObservableObject {
    @Published var isUsedSelected: Bool = false
    @Published var isNewSelected: Bool = false
    
    // Other shared variables...
    
    static let shared = SharedVariables()
    private init() {}
}
