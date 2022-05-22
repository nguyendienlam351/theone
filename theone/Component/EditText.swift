//
//  EditText.swift
//  theone
//
//  Created by nguyenlam on 5/22/22.
//

import SwiftUI

struct EditText: View {
    // MARK: Properties
    @Binding var value: String
    var placeholder: String
    var height: CGFloat
    @Binding var disable: Bool
    
    // MARK: View
    var body: some View {
        Group {
            HStack {
                Group {
                    TextField("", text: $value)
                        .disabled(disable)
                        .placeholder(when: value.isEmpty) {
                            Text(placeholder).foregroundColor(Color.thirdly)
                        }.frame(height: height)
                    
                }.font(Font.system(size: 20, design: .monospaced))
                .foregroundColor(.primary)
                .textFieldStyle(PlainTextFieldStyle())
                .multilineTextAlignment(.leading)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(.horizontal)
                
            }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 4))
        }
    }
}
