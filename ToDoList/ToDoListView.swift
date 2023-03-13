//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Jonathan Wheeler Jr. on 2/27/23.
//

import SwiftUI

struct ToDoListView: View {
    @State private var sheetIsPresented = false
    @EnvironmentObject var toDosVM: ToDosViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDosVM.toDos) { toDo in
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle": "rectangle")
                            .onTapGesture {
                                toDosVM.toggleCompleted(toDo: toDo)
                            }
                        NavigationLink {
                            DetailView(toDo: toDo)
                        } label: {
                            Text(toDo.item)
                        }
                        .font(.title2)
                    }
                    
                }
//                Shorthand Calls
                .onDelete(perform: toDosVM.deleteToDo)
                .onMove(perform: toDosVM.moveToDo)
//                Traditional Calls Below
//                .onDelete { indexSet in
//                    toDosVM.delete(indexSet: indexSet)
//                }
//                .onMove { fromOffsets, toOffset in
//                    toDosVM.toDos.move(fromOffsets: fromOffsets, toOffset: toOffset)
//                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                     EditButton()
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack {
                    DetailView(toDo: ToDo())
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
            .environmentObject(ToDosViewModel())
    }
}


