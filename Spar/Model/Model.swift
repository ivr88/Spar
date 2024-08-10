import Foundation

struct Model: Codable {
    let product: [Product]
}

struct Product: Codable, Identifiable {
    let id: Int
    let image: String
    let description: String
    let country: Country
    let countryImage: String
    let rating: String?
    let reviews: String?
    let discount: Bool
    let badge: Badge?
    let hasPicker: Bool
    let price: String
    var measures: [Measure] 
    var quantities: [Quantity]
    let oldPrice: String?
    var selectedMeasure: Measure
    var selectedQuantity: Quantity
}

enum Country: String, Codable {
    case France = "Франция"
    case Spain = "Испания"
    case Russia = "Россия"
}

enum Badge: String, Codable {
    case redBadge = "Удар по ценам"
    case geenBadge = "Цена по карте"
    case blueBadge = "Новинка"
}

enum Measure: String, Codable, CaseIterable {
    case kilo = "кг"
    case things = "шт"
}

enum Quantity: Double, Codable, CaseIterable {
    case forKilo = 0.3
    case forThings = 1.0
}
