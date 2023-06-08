//
//  AddNoteViewModel.swift
//  Notes_iOS
//
//  Created by Junaed Muhammad Chowdhury on 12/5/23.
//

import Foundation

class AddOrUpdateNoteViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var noteText = ""
    @Published var showAddNoteView = true
    
    
    func operationNote(note: Note?){
        guard !noteText.isEmpty else {
            alertItem = AlertContext.noteCantBeEmpty
            return
        }
        
        if let note, let id = note.id{
            updateNote(id: id, newValue: noteText)
        }else{
            addNewNote(note: noteText)
        }
    }
    
    
    func updateNote(id: String, newValue: String){
        isLoading = true
        
        var params: [String : String] = [:]
        params["id"] = id
        params["note"] = newValue
        print(UrlConstant.UPDATE_NOTE)
        NetworkManager.shared.postRequest(urlString: UrlConstant.UPDATE_NOTE, params: params, respnseType: Note.self) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(_):
                    self.showAddNoteView = false
                case .failure(let failure):
                    switch failure{
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                    case .invalidDeta:
                        self.alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func addNewNote(note: String){
        self.isLoading = true
        
        var params: [String : String] = [:]
        params["note"] = note
        print(UrlConstant.ADD_NOTE)
        NetworkManager.shared.postRequest(urlString: UrlConstant.ADD_NOTE, params: params, respnseType: Note.self) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(_):
                    self.showAddNoteView = false
                case .failure(let failure):
                    switch failure{
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                    case .invalidDeta:
                        self.alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
