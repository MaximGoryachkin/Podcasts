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
    
    // MARK: - Section Of Adding Images to Stash or donwload it from Stash
    
    func saveDataToCache(with data: Data, and responce: URLResponse) {
        
    }
    
    func getDataFromCache(from url: String) {
        
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
