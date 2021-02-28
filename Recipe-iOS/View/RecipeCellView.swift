//
//  RecipeCellView.swift
//  Recipe-iOS
//
//  Created by Jonathan Ng on 28/02/2021.
//

import SwiftUI

struct RecipeCellView: View {
    var recipe:Recipe
    
    var body: some View {
        NavigationLink(destination: DetailView(recipe: recipe)) {
            HStack{
                
                if (recipe.imageURL != nil){
                    UrlImageView(urlString: recipe.imageURL)
                        .frame(width: 100, height: 100)
                        .clipped()
                } else {
                    Image("food")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipped()
                }
                VStack(alignment: .leading) {
                    Text(recipe.title!)
                        .font(.headline)
                        .bold()
                    Text("\(recipe.timeRequired!) minutes")
                        .font(.system(.subheadline))
                }.padding(.leading)
            }
        }
    }
}

struct SavedRecipeCellView: View {
    var recipe: FoodRecipe
    
    var body: some View {
        NavigationLink(destination: SavedDetailView(recipe: recipe)) {
            HStack{
                if(recipe.image != nil){
                    Image(uiImage: UIImage(data: recipe.image!)!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipped()
                } else {
                    Image("food")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipped()
                }
                
                
                VStack(alignment: .leading) {
                    Text(recipe.title!)
                        .font(.headline)
                        .bold()
                    Text("\(recipe.timeRequired) minutes")
                        .font(.system(.subheadline))
                }.padding(.leading)
            }
        }
    }
}
