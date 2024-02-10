//
//  ContentView.swift
//  CoreDataUIView
//
//  Created by Aditya Ghorpade on 08/02/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<FruitEntity>
    
    @State var textFieldText: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                TextField("Add fruit here...", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.3).clipShape(RoundedRectangle(cornerRadius: 10)))
                    .padding(.horizontal)
                   
                Button(action: {
                    if !textFieldText.isEmpty {
                        addItem()
                    }
                }, label: {
                    Text("Submit")
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.indigo.clipShape(RoundedRectangle(cornerRadius: 10)))
                })
                .padding(.horizontal)
                
                List {
                    ForEach(items) { fruits in
                        Text(fruits.name ?? "")
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(PlainListStyle())
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .navigationTitle("Learning Core Data")
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = FruitEntity(context: viewContext)
            newItem.name = textFieldText
            saveItems()
            textFieldText = ""
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            saveItems()
        }
    }
    
    func saveItems() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
