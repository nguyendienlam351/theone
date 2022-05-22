//
//  ChatPhotoCard.swift
//  theone
//
//  Created by nguyenlam on 5/22/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatPhotoCard: View {
    // MARK: Properties
    let width = UIScreen.main.bounds.size.width * 0.6
    var chat: ChatModel?
    
    // MARK: View
    var body: some View {
        if chat!.isCurrentUser {
            HStack{
                Spacer()
                WebImage(url: URL(string: chat!.photoUrl)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width , height: width * 0.6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
                    .cornerRadius(7)
                        .padding(5)
                        .background(Color.primary)
                        .cornerRadius(10)
            }.padding(.vertical, 5)
            .padding(.leading,30)
            .padding(.trailing)
        }
        else {
            HStack{
                WebImage(url: URL(string: chat!.photoUrl)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width , height: width * 0.6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
                    .cornerRadius(7)
                    .padding(5)
                    .background(Color.primary)
                    .cornerRadius(10)
                    Spacer()
            }.padding(.vertical, 5)
            .padding(.trailing,30)
            .padding(.leading)
        }
    }
}

struct ChatPhotoCard_Previews: PreviewProvider {
    static var previews: some View {
        ChatPhotoCard()
    }
}
