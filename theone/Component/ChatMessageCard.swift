//
//  ChatMessageView.swift
//  theone
//
//  Created by nguyenlam on 5/22/22.
//

import SwiftUI

struct ChatMessageCard: View {
    // MARK: Properties
    var chat: ChatModel?
    
    // MARK: View
    var body: some View {
        if chat!.isCurrentUser {
            HStack{
                Spacer()
                Text(chat!.textMessage).bold()
                    .foregroundColor(Color.black)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15).fill(Color.primary)
                    )
            }.padding(.vertical, 5)
            .padding(.leading,30)
            .padding(.trailing)
        }
        else {
            HStack{
                Text(chat!.textMessage).bold()
                    .foregroundColor(Color.black)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15).fill(Color.primary)
                    )
                    Spacer()
            }.padding(.vertical, 5)
            .padding(.trailing,30)
            .padding(.leading)
        }
    }
}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageCard()
    }
}
