//
//  AddItemView.swift
//  Recipe-iOS
//
//  Created by Jonathan Ng on 28/02/2021.
//

import SwiftUI

struct AddItem: View {
    @State private var title: String = ""
    @State private var minutes = 45
    @State private var ingredients: String = ""
    @State private var instructions: String = ""
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack{
            TextField("Enter recipe title", text: $title)
                .padding()
            Stepper(value: $minutes) {
                Text("\(minutes) minutes")
            }.padding()
            TextField("Enter ingredients", text: $ingredients)
                .padding()
            TextField("Enter instructions", text: $instructions)
                .padding()
            Spacer()
            HStack{
                Spacer()
                Button("Save") {
                    let recipe = FoodRecipe(context: self.context)
                    recipe.title = title
                    recipe.timeRequired = Int64(minutes)
                    recipe.instructions = [instructions as NSString] as NSSet
                    recipe.ingredients = [ingredients as NSString] as NSSet
                    
                    do{
                        try self.context.save()
                    }catch {
                        print(error)
                    }
                }.padding()
                Spacer()
            }
        }
        .navigationBarTitle("Add Item")
        
    }
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem()
    }
}
