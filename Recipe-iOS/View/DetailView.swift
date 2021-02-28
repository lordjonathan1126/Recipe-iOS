//
//  DetailView.swift
//  Recipe-iOS
//
//  Created by Jonathan Ng on 28/02/2021.
//

import SwiftUI

struct DetailView: View {
    var ingredientsArray = [String]()
    var recipe:Recipe
    var body: some View {
        ScrollView{
            VStack (alignment: .leading){
                if (recipe.imageURL != nil){
                    UrlImageView(urlString: recipe.imageURL)
                        .clipped()
                } else {
                    Image("food")
                        .resizable()
                        .clipped()
                }
                Text("\(recipe.title!)")
                    .font(.title)
                    .lineLimit(nil)
                    .padding(.top)
                    .padding(.horizontal)
                Text("\(recipe.timeRequired!) Minutes")
                    .font(.subheadline)
                    .padding()
                
                Text("\(recipe.ingredients!.count) Ingredients")
                    .font(.headline)
                    .padding(.horizontal)
                ForEach(recipe.ingredients!, id: \.self){ ingredient in
                    Text("\(ingredient)")
                }.padding()
                Spacer()
                Text("Instructions")
                    .font(.headline)
                    .padding(.horizontal)
                ForEach(recipe.instructions!, id: \.self){ instruction in
                    Text("\(instruction)")
                }.padding()
                Spacer()
                    .navigationBarItems(trailing:
                                            saveButton(recipe: recipe)
                    )
            }
        }.edgesIgnoringSafeArea(.top)
    }
    
}

struct saveButton:View {
    @State private var showingAlert = false
    var recipe:Recipe
    let cdManager = CoreDataManager()
    
    var body: some View{
        Button(action:{
            self.cdManager.saveRecipe(recipe)
            showingAlert = true
        }){
            Image(systemName: "square.and.arrow.down")
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Recipe Saved"), message: Text("Recipe saved for offline use."), dismissButton: .default(Text("Dismiss")))
        }
    }
}

struct SavedDetailView: View {
    var recipe: FoodRecipe
    var body: some View {
        ScrollView{
            VStack (alignment: .leading){
                if (recipe.image != nil){
                    Image(uiImage: UIImage(data: recipe.image!)!)
                        .resizable()
                        .frame(height: 200)
                        .clipped()
                } else {
                    Image("food")
                        .resizable()
                        .frame(height: 200)
                        .clipped()
                }
                Text("\(recipe.title!)")
                    .font(.title)
                    .lineLimit(nil)
                    .padding(.top)
                    .padding(.horizontal)
                Text("\(recipe.timeRequired) Minutes")
                    .font(.subheadline)
                    .padding()
                Text("\(Array(recipe.ingredients! as Set).count) Ingredients")
                    .font(.headline)
                    .padding(.horizontal)
                ForEach(Array(recipe.ingredients! as Set), id: \.self){ ingredient in
                    Text("\(ingredient.description)")
                }
                Spacer()
                Text("Instructions")
                    .font(.headline)
                    .padding(.horizontal)
                ForEach(Array(recipe.instructions! as Set), id: \.self){ instruction in
                    Text("\(instruction.description)")
                }
                Spacer()
                 .navigationBarItems(trailing:
                deleteButton(recipe: recipe)
                 )
            }
        }.edgesIgnoringSafeArea(.top)
    }
    
}
struct deleteButton:View {
    @State private var showingAlert = false
    var recipe:FoodRecipe
    let cdManager = CoreDataManager()
    var body: some View{
        Button(action:{
            showingAlert = true
        }){
            Image(systemName: "trash")
                .foregroundColor(.red)
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                           title: Text("Are you sure you want to delete this?"),
                           message: Text("There is no undo"),
                           primaryButton: .destructive(Text("Delete")) {
                            self.cdManager.deleteRecipe(recipe)
                               print("Deleting...")
                           },
                           secondaryButton: .cancel()
                       )
        }
    }
}
