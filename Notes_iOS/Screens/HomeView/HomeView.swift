//
//  ContentView.swift
//  Notes_iOS
//
//  Created by Junaed Muhammad Chowdhury on 9/5/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var selectedNote: Note?
    
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(viewModel.noteList) { note in
                        Text(note.noteValue ?? "")
                            .padding()
                            .onTapGesture {
                                selectedNote = note
                                viewModel.showAddOrEditView = true
                            }
                    }
                    .onDelete(perform: viewModel.deleteNote)
                }
                
                if(viewModel.isLoading){
                    LoadingIndicator()
                }
                
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        selectedNote = nil
                        viewModel.showAddOrEditView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .task {
                viewModel.getNoteList()
            }
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            }
            .sheet(isPresented: $viewModel.showAddOrEditView, onDismiss: viewModel.getNoteList) {
                if let selectedNote{
                    AddOrUpdateNoteView(note: selectedNote)
                }else{
                    AddOrUpdateNoteView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

