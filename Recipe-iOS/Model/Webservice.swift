//
//  Webservice.swift
//  Recipe-iOS
//
//  Created by Jonathan Ng on 28/02/2021.
//

import SwiftUI
class Webservice {
    static let apiKey = "cdd60e8bdcb645589624b6a615e20218"
    static let host = "api.spoonacular.com"
    static let scheme = "https"
    
    static var randomRecipeURL: URL {
        var components = URLComponents()
        components.host = host
        components.path = "/recipes/random"
        components.scheme = scheme
        
        components.queryItems = [URLQueryItem]()
        components.queryItems?.append(URLQueryItem(name: "apiKey", value: Webservice.apiKey))
        components.queryItems?.append(URLQueryItem(name: "number", value: "12"))
        
        return components.url!
    }
    
    class func getRandomRecipe(completion: @escaping ([Recipe], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Webservice.randomRecipeURL) { (data, response, error) in
            guard data != nil else{
                return
            }
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed) as? [AnyHashable: Any]
                if let recipeArray = responseObject?["recipes"] as? [[String: Any]] {
                    let recipes = createRecipes(recipeArray: recipeArray)
                    completion(recipes, nil)
                }
                else {
                    completion([], error)
                }
            } catch {
                completion([], error)
            }
        }
        task.resume()
        
    }
        
    
    private class func createRecipes(recipeArray: [[String: Any]]) -> [Recipe] {
        var recipes = [Recipe]()
        for recipeInfo in recipeArray {
            let recipe = configureRecipe(recipeInfo: recipeInfo)
            recipes.append(recipe)
        }
        return recipes
    }
    
    private class func configureRecipe(recipeInfo: [String: Any]) -> Recipe{
        var recipe = Recipe()
        
        if let title = recipeInfo["title"] as? String {
            recipe.title = title
        }
        
        if let servings = recipeInfo["servings"] as? Int {
            recipe.servings = servings
        }
        
        if let imageURL = recipeInfo["image"] as? String {
            recipe.imageURL = imageURL
        }
        
        if let sourceURL = recipeInfo["sourceUrl"] as? String {
            recipe.sourceURL = sourceURL
        }

        if let ingredientArray = recipeInfo["extendedIngredients"] as? [[String: Any]] {
            if ingredientArray.count == 0 {
                recipe.ingredients = []
            } else {
                var ingredients = [String]()
                for ingredient in ingredientArray {
                    if let ingredient = ingredient["originalString"] as? String {
                        ingredients.append(ingredient)
                    }
                }
                recipe.ingredients = ingredients
            }
        } else {
            recipe.ingredients = []
        }
        
        if let timeRequired = recipeInfo["readyInMinutes"] as? Int {
            recipe.timeRequired = timeRequired
        }
        
        if let instructions = recipeInfo["analyzedInstructions"] as? [[String : Any]]  {
            if instructions.count == 0 {
                recipe.instructions = []
            } else {
                var instructionsArray = [String]()
                for instructionSteps in instructions {
                    if let instructionSteps = instructionSteps["steps"] as? [[String : Any]] {
                        for step in instructionSteps {
                            if let instructionStep = step["step"] as? String {
                                instructionsArray.append(instructionStep)
                            }
                        }
                    }
                }
                recipe.instructions = instructionsArray
            }
        } else {
            recipe.instructions = []
        }
        return recipe
    }
    
    class func downloadRecipeImage(imageURL: String, completion: @escaping (UIImage?, Bool) -> Void) {
        if let url = URL(string: imageURL) {
            DispatchQueue.global(qos: .userInitiated).async {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let data = data else {
                        completion(nil, false)
                        return
                    }
                    DispatchQueue.main.async{
                        completion(UIImage(data: data), true)
                    }
                }
                task.resume()
            }
        }
    }
}

