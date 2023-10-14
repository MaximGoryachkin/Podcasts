//
//  DataManager.swift
//  Podcasts
//
//  Created by Максим Горячкин on 26.09.2023.
//

import Foundation
import RealmSwift

class DataManager {
    
    let realm = try! Realm()
    
    enum Tegs: String {
        case podcasts
        case search
    }
    
    static let shared = DataManager()
    
    let baseURL = "https://api.podcastindex.org/api/1.0/"
    
    let episodeURL = "https://api.podcastindex.org/api/1.0/episodes/byfeedid?id=75&pretty"
    let searchURL = "https://api.podcastindex.org/api/1.0/search/byterm?q=batman+university&pretty"
    var categoriesURL: String = "https://api.podcastindex.org/api/1.0/podcasts/trending?pretty&max=30"
    
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
    
    func saveEpisode(with item: Item) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func loadEpisodes() -> Results<Item> {
        let items = realm.objects(Item.self)
        return items
    }
    
    func updateCtegoryURL(with category: Medium) {
        if category == .tranding {
            categoriesURL = "https://api.podcastindex.org/api/1.0/podcasts/trending?pretty&max=30"
        } else {
            categoriesURL = "https://api.podcastindex.org/api/1.0/podcasts/bymedium?medium=\(category.rawValue)&pretty"
        }
    }
    
    func setCategory(with category: PodcastCategory) -> String {
        switch category {
        case .music:
            "https://api.podcastindex.org/api/1.0/podcasts/trending?cat=16,18,19,23&pretty"
        case .art:
            "https://api.podcastindex.org/api/1.0/podcasts/trending?cat=1,2,3,4,5&pretty"
        case .business:
            "https://api.podcastindex.org/api/1.0/podcasts/trending?cat=9,10,12,13,14&pretty"
        case .games:
            "https://api.podcastindex.org/api/1.0/podcasts/trending?cat=6,48,49&pretty"
        case .science:
            "https://api.podcastindex.org/api/1.0/podcasts/trending?cat=21,22,24,25,26,67,68,69,70,71,72,73,74,75&pretty"
        case .sport:
            "https://api.podcastindex.org/api/1.0/podcasts/trending?cat=86,87,88,89,91,92,93,94,95,96,97,98,99,101&pretty"
        case .news:
            "https://api.podcastindex.org/api/1.0/podcasts/trending?cat=55,56,57,58,59&pretty"
        case .mults:
            "https://api.podcastindex.org/api/1.0/podcasts/trending?cat=43,44,104,105,106,107&pretty"
        }
    }
}
