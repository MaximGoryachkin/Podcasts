//
//  Product.swift
//  Podcasts
//
//  Created by Леонид Турко on 01.10.2023.
//

struct Product: Hashable {
  let name: String
  let imageName: String
}

struct ProductList: Hashable {
  
  let featured = [
    Product(name: "itemOne", imageName: "sun.haze"),
    Product(name: "itemTwo", imageName: "sun.haze"),
    Product(name: "itemThree", imageName: "sun.haze"),
    Product(name: "itemFour", imageName: "sun.haze"),
    Product(name: "itemFive", imageName: "sun.haze"),
    Product(name: "itemSix", imageName: "sun.haze")
  ]
  
  let onSale = [
    Product(name: "1", imageName: "moon"),
    Product(name: "2", imageName: "moon"),
    Product(name: "3", imageName: "moon"),
    Product(name: "4", imageName: "moon")
  ]
  
  let all = [
    Product(name: "one", imageName: "dollarsign.circle.fill"),
    Product(name: "two", imageName: "dollarsign.circle.fill"),
    Product(name: "three", imageName: "dollarsign.circle.fill"),
    Product(name: "four", imageName: "dollarsign.circle.fill"),
    Product(name: "five", imageName: "dollarsign.circle.fill"),
    Product(name: "six", imageName: "dollarsign.circle.fill"),
    Product(name: "seven", imageName: "dollarsign.circle.fill"),
    Product(name: "eight", imageName: "dollarsign.circle.fill")
  ]
}
