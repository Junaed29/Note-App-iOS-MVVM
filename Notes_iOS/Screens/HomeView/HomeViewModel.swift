//
//  HomeViewModel.swift
//  Notes_iOS
//
//  Created by Junaed Muhammad Chowdhury on 10/5/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var noteList:[Note] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = true
    @Published var showAddOrEditView = false
    
    func getNoteList(){
        isLoading = true
        
        NetworkManager.shared.getRequest(urlString: UrlConstant.GET_FOOD_LIST, respnseType: [Note].self) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let success):
                    self.noteList = success
                    
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
    
    
    func deleteNote(indexSet: IndexSet){
        var id: String?
        
        for index in indexSet{
            id = noteList[index].id
            break
        }
        
        if id != nil {
            var params: [String : String] = [:]
            params["id"] = id
            print(UrlConstant.DELETE_NOTE)
            NetworkManager.shared.postRequest(urlString: UrlConstant.DELETE_NOTE, params: params, respnseType: Note.self) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        self.noteList.remove(atOffsets: indexSet)
                    case .failure(let failure):
                        print(failure)
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
