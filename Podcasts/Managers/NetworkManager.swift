//
//  NetworkManager.swift
//  Podcasts
//
//  Created by Максим Горячкин on 26.09.2023.
//

import Foundation
import CryptoKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchDataPodcast(from url: String?, with complition: @escaping (PodcastAPI) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        let request = createRequest(with: url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let podcast = try JSONDecoder().decode(PodcastAPI.self, from: data)
                DispatchQueue.main.async {
                    complition(podcast)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchDataSearchPodcast(from url: String?, with complition: @escaping (SearchPodcast) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        let request = createRequest(with: url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let podcast = try JSONDecoder().decode(SearchPodcast.self, from: data)
                DispatchQueue.main.async {
                    complition(podcast)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchDataEpisode(from url: String?, with complition: @escaping (Episode) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        let request = createRequest(with: url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let podcast = try JSONDecoder().decode(Episode.self, from: data)
                DispatchQueue.main.async {
                    complition(podcast)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
//
//    func fetchArrayData(from url: String?, with complition: @escaping ([Podcast]) -> Void) {
//        guard let stringURL = url else { return }
//        guard let url = URL(string: stringURL) else { return }
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            guard let data = data else { return }
//            do {
//                let podcast = try JSONDecoder().decode(Podcast.self, from: data)
//                DispatchQueue.main.async {
//                    complition(podcast)
//                }
//            } catch let error {
//                print(error)
//            }
//        }.resume()
//    }
    
    func fetchData(from url: String?) async throws -> PodcastAPI? {
        guard let stringURL = url else { return nil }
        guard let url = URL(string: stringURL) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        let podcast = try JSONDecoder().decode(PodcastAPI.self, from: data)
        return podcast
    }
    
//    func fetchArrayData(from url: String?) async throws -> Podcast? {
//        guard let stringURL = url else { return nil }
//        guard let url = URL(string: stringURL) else { return nil }
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let podcasts = try JSONDecoder().decode(Recipes.self, from: data)
//        return podcasts
//    }
    
//
//    /////////////
//    func fetchResultsArrayData(from url: String?) async throws -> Results? {
//        guard let stringURL = url else { return nil }
//        guard let url = URL(string: stringURL) else { return nil }
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let results = try JSONDecoder().decode(Results.self, from: data)
//        return results
//    }
    
    
    
    // MARK: - Section Of Adding Images to Stash or donwload it from Stash
    
    func saveDataToCache(with data: Data, and responce: URLResponse) {
        guard let url = responce.url else { return }
        let request = URLRequest(url: url)
        let cachedResponce = CachedURLResponse(response: responce, data: data)
        URLCache.shared.storeCachedResponse(cachedResponce, for: request)
    }
    
    func getDataFromCache(from url: URL) -> Data? {
        let request = URLRequest(url: url)
        if let cachedResponce = URLCache.shared.cachedResponse(for: request) {
            return cachedResponce.data
        } else {
            return nil
        }
    }
    
    private func createRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        let timeInSeconds = Date().timeIntervalSince1970
        let apiHeaderTime = Int(timeInSeconds)
        let data4Hash = DataManager.shared.apiKey + DataManager.shared.apiSecret + "\(apiHeaderTime)"
        // ======== Hash them to get the Authorization token ========
        let inputData = Data(data4Hash.utf8)
        let hashed = Insecure.SHA1.hash(data: inputData)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        // ======== Send the request and collect/show the results ========
        request.httpMethod = "GET"
        request.addValue("\(apiHeaderTime)", forHTTPHeaderField: "X-Auth-Date")
        request.addValue(DataManager.shared.apiKey, forHTTPHeaderField: "X-Auth-Key")
        request.addValue(hashString, forHTTPHeaderField: "Authorization")
        request.addValue("SuperPodcastPlayer/1.8", forHTTPHeaderField: "User-Agent")
        return request
    }
    
}
