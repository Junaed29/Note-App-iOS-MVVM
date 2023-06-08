//
//  XDismissButton.swift
//  Notes_iOS
//
//  Created by Junaed Muhammad Chowdhury on 12/5/23.
//
import SwiftUI

struct XDismissButton: View {
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(.cyan)
                .opacity(0.7)
            
            Image(systemName: "xmark")
                .imageScale(.small)
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
        }
    }
}

struct XDismissButton_Previews: PreviewProvider {
    static var previews: some View {
        XDismissButton()
    }
}
