import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    @Published var selectedProducts: [Product] = []
    @Published var favoriteProducts: [Product] = []
    @Published var model: Model?
    
    private let kiloStep: Double = 0.3
    private let thingsStep: Double = 1.0

    func fetch() {
        guard let url = URL(string: "https://run.mocky.io/v3/4091b4cf-827b-4e0a-86ef-483e95be2ea4") else {
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
    
    func discountCalculation(newPrice: Double, oldPrice: Double?) -> String {
        guard let oldPrice = oldPrice else {
            return ""
        }
        let discount = ((oldPrice - newPrice) / oldPrice) * 100
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
            if product.selectedMeasure == .pieces {
                selectedProducts[index].quantity += thingsStep
            } else {
                selectedProducts[index].quantity += kiloStep
            }
            saveSelectedProducts()
        }
    }
    
    func decreaseQuantity(for product: Product) {
        if let index = selectedProducts.firstIndex(where: { $0.id == product.id }) {
            if product.selectedMeasure == .pieces {
                if selectedProducts[index].quantity - thingsStep <= 0 {
                    selectedProducts.remove(at: index)
                } else {
                    selectedProducts[index].quantity -= thingsStep
                }
            } else if product.selectedMeasure == .kilograms {
                if selectedProducts[index].quantity - kiloStep <= 0 {
                    selectedProducts.remove(at: index)
                } else {
                    selectedProducts[index].quantity -= kiloStep
                }
            }
            saveSelectedProducts()
        }
    }
    
    func totalCost(for product: Product) -> String {
        if let index = selectedProducts.firstIndex(where: { $0.id == product.id }) {
            let calculatedCost = selectedProducts[index].price * selectedProducts[index].quantity
            return String(format: "%.2f ₽", calculatedCost)
        }
        return "0.00 ₽"
    }
        
    func quantityText(for product: Product) -> String {
        if let index = selectedProducts.firstIndex(where: { $0.id == product.id }) {
            let quantity = selectedProducts[index].quantity
            let formattedQuantity: String
            
            if selectedProducts[index].selectedMeasure == .pieces {
                formattedQuantity = String(format: "%.0f", quantity)
            } else {
                formattedQuantity = String(format: "%.1f", quantity)
            }
            return "\(formattedQuantity) \(selectedProducts[index].selectedMeasure.rawValue)"
        }
        return "0 \(product.selectedMeasure.rawValue)"
    }
}
