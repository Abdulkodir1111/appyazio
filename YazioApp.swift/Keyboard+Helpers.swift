//
//  Keyboard+Helpers.swift
//  YazioApp.swift
//
//  Created by Abdulkodir Juraev on 11/11/25.
//

#if canImport(UIKit)
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
