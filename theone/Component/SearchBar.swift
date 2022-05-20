//
//  SearchBar.swift
//  theone
//
//  Created by nguyennam on 5/10/22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var users: [User]
    @Binding var value: String
    @State var isSearching = false
    
    func clear() {
        value = ""
        users.removeAll()
    }
    
    var body: some View {
        HStack {
            TextField("", text: $value)
                .placeholder(when: value.isEmpty) {
                    Text("Search User here").foregroundColor(Color.thirdly)
                }.padding(.leading, 24)
        }.padding()
        .foregroundColor(Color.primary)
        .background(Color(.thirdly))
        .cornerRadius(6.0)
        .padding(.horizontal)
        .onTapGesture(perform: {
            isSearching = true
        })
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.secondary)
                
                Spacer()
                
                Button(action: clear) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.secondary)
                }
            }
            .padding(.horizontal, 32)
        )
    }
}

//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}
