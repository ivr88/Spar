import Foundation

struct Model: Codable {
    let prodact: [Product]
}

struct Product: Codable {
    let image: String
    let description: String
    let country: Country
    let countryImage: String
    let rating: String?
    let reviews: String?
    let discount: Bool
    let badge: Badge
    let hasPicker: Bool
    let price: String
    let measure: Measure
    let oldPrice: String?
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

enum Measure: String, Codable {
    case kilo = "кг"
    case things = "шт"
}
