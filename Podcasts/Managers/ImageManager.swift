//
//  ImageManager.swift
//  Podcasts
//
//  Created by Максим Горячкин on 09.10.2023.
//

import Foundation

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: String, complition: @escaping (Data, URLResponse) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error desctription")
                return
            }
            DispatchQueue.main.async {
                complition(data, response)
            }
        }.resume()
    }
    
}
