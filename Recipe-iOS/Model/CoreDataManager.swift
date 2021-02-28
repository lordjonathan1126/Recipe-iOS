//
//  CoreDataManager.swift
//  Recipe-iOS
//
//  Created by Jonathan Ng on 28/02/2021.
//

import UIKit
import CoreData

class CoreDataManager: NSObject, ObservableObject {
    let webservice = Webservice()
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override init() {}
    var foodImage = UIImage()
    var ingredientsArray = [String]()
    var instructionsArray = [String]()
    
    func saveRecipe(_ recipe: Recipe!){
        let context = self.appDelegate!.persistentContainer.viewContext
        
        
        if recipe.imageURL != nil {
            Webservice.downloadRecipeImage(imageURL: recipe.imageURL!) { (image, success)  in
                self.foodImage = image!
            }
        }
        
        if let ingredients = recipe.ingredients {
            self.ingredientsArray = ingredients
        }
        if let instructions = recipe.instructions {
            self.instructionsArray = instructions
        }
        
        let foodRecipe = FoodRecipe(context: context)
        foodRecipe.title = recipe.title
        foodRecipe.timeRequired = Int64(recipe.timeRequired!)
        foodRecipe.sourceUrl = recipe.sourceURL
        foodRecipe.image = foodImage.pngData()
        
        let ingredient = Ingredient(context: context)
        if ingredientsArray.count != 0 {
            var count = 1
            for ingredientString in ingredientsArray {
                ingredient.ingredient = ingredientString
                ingredient.foodRecipe = foodRecipe
                count += 1
            }
            ingredient.number = Int64(recipe.ingredients!.count)
        }
        
        let instruction = Instruction(context: context)
        if instructionsArray.count != 0 {
            var count = 1
            for instructionString in instructionsArray {
                instruction.instruction = instructionString
                instruction.foodRecipe = foodRecipe
                instruction.stepNumber = Int64(count)
                count += 1
            }
        }
        
        do {
            try context.save()
            print("Saved Recipe to Core Data")
        } catch {
            print("Error saving: \(error) \(error.localizedDescription)")
        }
    }
    
    func deleteRecipe(_ recipe: FoodRecipe){
        let context = self.appDelegate!.persistentContainer.viewContext
        context.delete(recipe as NSManagedObject)
        try? context.save()
    }
}
