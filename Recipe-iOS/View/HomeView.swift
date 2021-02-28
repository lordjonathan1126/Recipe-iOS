//
//  HomeView.swift
//  Recipe-iOS
//
//  Created by Jonathan Ng on 28/02/2021.
//

import SwiftUI

struct HomeView: View {
    @State var recipes = [Recipe]()
    @State var name = ""
    
    func handleRecipes(recipes: [Recipe], error: Error?) {
        if let error = error {
            print(error)
        }
        self.recipes = recipes
    }
    
    var body: some View {
        NavigationView{
            VStack{
                SearchBar(text: self.$name)
                List(recipes.filter({name.isEmpty ? true : $0.title!.localizedCaseInsensitiveContains(self.name)})
                     , id: \.self){ recipe in
                    RecipeCellView(recipe: recipe)
                }
            }
            .navigationBarTitle("Recipes", displayMode: .automatic)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(){
            DispatchQueue.global(qos: .userInitiated).async {
            Webservice.getRandomRecipe(completion: handleRecipes)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


