//
//  LoadingIndicator.swift
//  Notes_iOS
//
//  Created by Junaed Muhammad Chowdhury on 10/5/23.
//


import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .cyan
        activityIndicator.startAnimating()
        return activityIndicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}

struct LoadingIndicator: View {
    var body: some View{
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            //ActivityIndicator()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .cyan))
                .scaleEffect(2)
        }
    }
}



struct CirculerLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
    }
}
