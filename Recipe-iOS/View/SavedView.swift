//
//  SavedView.swift
//  Recipe-iOS
//
//  Created by Jonathan Ng on 28/02/2021.
//

import SwiftUI

struct SavedView: View {
    @FetchRequest(
        entity: FoodRecipe.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \FoodRecipe.title, ascending: true)]
    ) var recipes: FetchedResults<FoodRecipe>
    var body: some View {
        
        NavigationView{
            if(_recipes.wrappedValue.count == 0){
                VStack {
                    Text("You don't have any saved recipes")
                }
                .navigationBarTitle("Saved", displayMode: .automatic)
                .navigationBarItems(trailing: NavigationLink(destination: AddItem()) {
                    Image(systemName: "plus")
                })
            }else {
                List(_recipes.wrappedValue, id:\.self){ recipe in
                    SavedRecipeCellView(recipe: recipe)
                }
                .navigationBarTitle("Saved", displayMode: .automatic)
                .navigationBarItems(trailing: NavigationLink(destination: AddItem()) {
                    Image(systemName: "plus")
                })
        }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

