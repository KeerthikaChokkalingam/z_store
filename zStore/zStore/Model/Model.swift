//
//  Model.swift
//  zStore
//
//  Created by Keerthika on 27/05/24.
//

struct ApiResponseWrapper: Codable {
    let response: String
}
struct ApiResponse: Decodable {
  var category: [CategoryResponse]?
  var cardOffers: [CardOfferResponse]?
  var products: [ProductResponse]?
  enum CodingKeys: String, CodingKey {
    case category
    case cardOffers = "card_offers"
    case products
  }
}
struct CategoryResponse: Decodable {
  let id: String
  let name: String
  let layout: String
}
struct CardOfferResponse: Decodable {
  let id: String
  let percentage: Double
  let cardName: String
  let offerDesc: String
  let maxDiscount: String
  let imageUrl: String
  enum CodingKeys: String, CodingKey {
    case id
    case percentage
    case cardName = "card_name"
    case offerDesc = "offer_desc"
    case maxDiscount = "max_discount"
    case imageUrl = "image_url"
  }
}
struct ProductResponse: Decodable {
  let id: String
  let name: String
  let rating: Double
  let reviewCount: Int
  let price: Double
  let categoryId: String
  let cardOfferIds: [String]
  let imageUrl: String
  let description: String
    let colors: [String]?
    var addToFav: Bool?
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case rating
    case reviewCount = "review_count"
    case price
    case categoryId = "category_id"
    case cardOfferIds = "card_offer_ids"
    case imageUrl = "image_url"
    case description
      case colors
      case addToFav
  }
}
