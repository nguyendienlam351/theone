//
//  ButtonModifiers.swift
//  theone
//
//  Created by nguyenlam on 4/28/22.
//

import SwiftUI

struct ButtonModifiers: ViewModifier {
    // MARK: View
    func body(content: Content) -> some View {
        content
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .frame(height: 20)
            .padding()
            .foregroundColor(.black)
            .font(.system(size: 14, weight: .bold))
            .background(Color.primary)
            .cornerRadius(5)
    }
}
