import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    @Published var selectedProducts: [Product] = []
    @Published var favoriteProducts: [Product] = []
    @Published var model: Model?
    
    // Константы для шагов изменения количества
    private let kiloStep: Double = 0.3
    private let thingsStep: Double = 1.0

    func fetch() {
        guard let url = URL(string: "https://run.mocky.io/v3/a9d42bcb-edc6-4e99-ba1a-549d877277ae") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let model = try JSONDecoder().decode(Model.self, from: data)
                DispatchQueue.main.async {
                    self?.model = model
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func discountCalculation(newPrice: String, oldPrice: String?) -> String {
        guard let oldPrice = oldPrice,
              let newPriceDouble = Double(newPrice),
              let oldPriceDouble = Double(oldPrice) else {
            return ""
        }
        let discount = ((oldPriceDouble - newPriceDouble) / oldPriceDouble) * 100
        return String(format: "%.1f%%", discount)
    }
    
    func saveSelectedProducts() {
        if let encoded = try? JSONEncoder().encode(selectedProducts) {
            UserDefaults.standard.set(encoded, forKey: "selectedProducts")
        }
    }

    func loadSelectedProducts() {
        if let savedData = UserDefaults.standard.data(forKey: "selectedProducts"),
           let decodedProducts = try? JSONDecoder().decode([Product].self, from: savedData) {
            selectedProducts = decodedProducts
        }
    }
    
    func saveFavoriteProducts() {
        if let encoded = try? JSONEncoder().encode(favoriteProducts) {
            UserDefaults.standard.set(encoded, forKey: "favoriteProducts")
        }
    }

    func loadFavoriteProducts() {
        if let savedData = UserDefaults.standard.data(forKey: "favoriteProducts"),
           let decodedProducts = try? JSONDecoder().decode([Product].self, from: savedData) {
            favoriteProducts = decodedProducts
        }
    }

    func toggleFavorite(for product: Product) {
        if let index = favoriteProducts.firstIndex(where: { $0.id == product.id }) {
            favoriteProducts.remove(at: index)
        } else {
            favoriteProducts.append(product)
        }
        saveFavoriteProducts()
    }

    func isFavorite(_ product: Product) -> Bool {
        return favoriteProducts.contains(where: { $0.id == product.id })
    }

    func increaseQuantity(for product: Product) {
        if let index = selectedProducts.firstIndex(where: { $0.id == product.id }) {
            let step = product.selectedMeasure == .kilo ? kiloStep : thingsStep
            let currentQuantity = selectedProducts[index].selectedQuantity
            let newQuantityValue = currentQuantity.rawValue + step
            selectedProducts[index].selectedQuantity = Quantity(rawValue: newQuantityValue) ?? currentQuantity
            saveSelectedProducts()
        }
        
    }

    func decreaseQuantity(for product: Product) {
        if let index = selectedProducts.firstIndex(where: { $0.id == product.id }) {
            let step = product.selectedMeasure == .kilo ? kiloStep : thingsStep
            let currentQuantity = selectedProducts[index].selectedQuantity
            let newQuantityValue = currentQuantity.rawValue - step
            if newQuantityValue <= 0 {
                selectedProducts.remove(at: index)
            } else {
                selectedProducts[index].selectedQuantity = Quantity(rawValue: newQuantityValue) ?? currentQuantity
            }
            saveSelectedProducts()
        }
    }
    
    // Функция для вычисления цены в зависимости от количества
    func calculatePrice(for product: Product) -> String {
        let pricePerUnit = Double(product.price) ?? 0.0
        let quantityMultiplier = selectedProducts.first(where: { $0.id == product.id })?.selectedQuantity.rawValue ?? 0.0
        let totalPrice = pricePerUnit * quantityMultiplier
        return String(format: "%.2f", totalPrice)
    }
}
