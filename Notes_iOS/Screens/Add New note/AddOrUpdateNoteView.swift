//
//  AddNoteView.swift
//  Notes_iOS
//
//  Created by Junaed Muhammad Chowdhury on 12/5/23.
//

import SwiftUI

struct AddOrUpdateNoteView: View {
    
    @StateObject private var viewModel = AddOrUpdateNoteViewModel()
    @Environment(\.dismiss) private var dismiss
    var note: Note?
    
    var body: some View {
        ZStack{
            VStack {
                TextEditor(text: $viewModel.noteText)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.cyan ,lineWidth: 1)
                    }.padding(.top,40)
                
                Button {
                    viewModel.operationNote(note: note)
                } label: {
                    Text(note == nil ? "Save" : "Update").frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top,30)
                
                Spacer()
            }
            
            if(viewModel.isLoading){
                LoadingIndicator()
            }
            
            
        }
        
        .padding()
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        .onAppear {
            if let note, let noteValue = note.noteValue{
                viewModel.noteText = noteValue
            }
        }
        .onChange(of: viewModel.showAddNoteView) { showAddNoteView in
            if !showAddNoteView{
                dismiss()
            }
        }.overlay(alignment: .topTrailing) {
            Button {
                dismiss()
            } label: {
                XDismissButton().padding(.trailing)
            }

        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddOrUpdateNoteView()
    }
}
