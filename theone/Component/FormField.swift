//
//  FormField.swift
//  theone
//
//  Created by nguyenlam on 4/28/22.
//

import SwiftUI

struct FormField: View {
    // MARK: Properties
    @Binding var value: String
    var icon: String
    var placeholder: String
    var isSecure = false
    
    // MARK: View
    var body: some View {
        Group {
            HStack {
                Image(systemName: icon).foregroundColor(Color.primary).padding()
                Group {
                    if isSecure {
                        SecureField("", text: $value)
                            .placeholder(when: value.isEmpty) {
                                Text(placeholder).foregroundColor(Color.thirdly)
                        }
                    }
                    else {
                        TextField("", text: $value)
                            .placeholder(when: value.isEmpty) {
                                Text(placeholder).foregroundColor(Color.thirdly)
                        }
                    }
                    
                }.font(Font.system(size: 20, design: .monospaced))
                .foregroundColor(.primary)
                .textFieldStyle(PlainTextFieldStyle())
                .multilineTextAlignment(.leading)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                
            }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 4))
        }
    }
}
