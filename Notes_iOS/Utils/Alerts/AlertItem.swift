//
//  AlertItem.swift
//  Food-Mela iOS
//
//  Created by Junaed Muhammad Chowdhury on 15/3/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    //MARK: - Network Alert
    static let invalidData = AlertItem(title: Text("Server Error"),
                                              message: Text("The data received from the server was invalid. Please contact support."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidResponse = AlertItem(title: Text("Server Error"),
                                              message: Text("Invalid response from the server. Please try again letter or contact support."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidURL = AlertItem(title: Text("Server Error"),
                                              message: Text("There was an issue connecting to the server. If this persists, please contact support."),
                                              dismissButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItem(title: Text("Unknown Error"),
                                              message: Text("Unable to complete your request at this time. Please check your internet connection."),
                                              dismissButton: .default(Text("OK")))
    
    //MARK: - Account Alert
    static let textFieldEmpty = AlertItem(title: Text("Invalid Form"),
                                              message: Text("Please ensure all fields in thr form have been filled out."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidEmail = AlertItem(title: Text("Imvalid Email"),
                                              message: Text("Please ensure your email is correct."),
                                              dismissButton: .default(Text("OK")))
    
    static let userDataSavedSuccess = AlertItem(title: Text("Profile Saved"),
                                              message: Text("Your profile information was successfully saved."),
                                              dismissButton: .default(Text("OK")))
    
    static let userDataSavedFailed = AlertItem(title: Text("Profile Saved Failed"),
                                              message: Text("Unable to save your profile informations."),
                                              dismissButton: .default(Text("OK")))
    
    static let noteCantBeEmpty = AlertItem(title: Text("Note Saved Failed"),
                                              message: Text("Note is empty. Unable to save your note."),
                                              dismissButton: .default(Text("OK")))
}
