//
//  DataManager.swift
//  Podcasts
//
//  Created by Максим Горячкин on 26.09.2023.
//

import Foundation

class DataManager {
    
    enum Tegs: String {
        case podcasts
        case search
    }
    
    static let shared = DataManager()
    
    let baseURL = "https://api.podcastindex.org/api/1.0/"
    
    let episodeURL = "https://api.podcastindex.org/api/1.0/episodes/byfeedid?id=75&pretty"
    let searchURL = "https://api.podcastindex.org/api/1.0/search/byterm?q=batman+university&pretty"
    let trendingURL = "https://api.podcastindex.org/api/1.0/podcasts/trending?pretty&max=30"
    let apiKey = "MSDWATAHX8CSACA8PECJ"
    let apiSecret = "^kwug67D7mhbPT#7FwwdzLgrLVzjqmMdZwdXy3pB"

    private init() {}
    
//    var randomRecipe: String {
//        baseURL + GetRecipe.random.rawValue + "?apiKey=" + apiKey + "&number=\(number)"
//    }
//    
//    var recipeURL: String {
//        baseURL + "\(id)/" + GetRecipe.information.rawValue + "?apiKey=" + apiKey
//    }
//    
//    var trendingsRecipes: String {
//        baseURL + GetRecipe.random.rawValue + "?apiKey=" + apiKey + "&number=15" + "&instructionsRequired=true"
//    }
//    
//    var trendingsRecipesPlusFive: String {
//        baseURL + GetRecipe.random.rawValue + "?apiKey=" + apiKey + "&number=5" + "&instructionsRequired=true"
//    }
//    
//    var mainCoursePopulars: String {
//        baseURL + GetRecipe.random.rawValue + "?apiKey=" + apiKey + "&number=5" + "&tags=main%20course"
//    }
//    
//    var popularCategoryes: String {
//        baseURL + GetRecipe.random.rawValue + "?apiKey=" + apiKey
//    }
//    
//    var searchURL : String {
//        baseURL + "complexSearch" + "?apiKey=" + apiKey + "&addRecipeInformation=true" + "&number=20" + "&fillIngredients=true" + "&instructionsRequired=true"
//    }
//    
//    var arrayRecipes = [Int : RecipeDataModel]()
}
