import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    @Published var selectedProducts: [Product] = []
    @Published var favoriteProducts: [Product] = []
    @Published var model: Model?
    
    // Создание запроса в сеть
    func fetch() {
        guard let url = URL(string: "https://run.mocky.io/v3/a4e5a474-3b00-4fbf-92ae-3e5936c45fdb") else {
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
    
    // Расчёт процента
    func discountCalculation(newPrice: String, oldPrice: String?) -> String {
        guard let oldPrice = oldPrice,
              let newPriceDouble = Double(newPrice),
              let oldPriceDouble = Double(oldPrice) else {
            return ""
        }
        let discount = ((oldPriceDouble - newPriceDouble) / oldPriceDouble) * 100
        return String(format: "%.1f%%", discount)
    }
    
    // Сохранение выбранных продуктов в UserDefaults
    func saveSelectedProducts() {
        if let encoded = try? JSONEncoder().encode(selectedProducts) {
            UserDefaults.standard.set(encoded, forKey: "selectedProducts")
        }
    }

    // Загрузка выбранных продуктов из UserDefaults
    func loadSelectedProducts() {
        if let savedData = UserDefaults.standard.data(forKey: "selectedProducts"),
           let decodedProducts = try? JSONDecoder().decode([Product].self, from: savedData) {
            selectedProducts = decodedProducts
        }
    }
    
    // Сохранение избранных продуктов в UserDefaults
    func saveFavoriteProducts() {
        if let encoded = try? JSONEncoder().encode(favoriteProducts) {
            UserDefaults.standard.set(encoded, forKey: "favoriteProducts")
        }
    }

    // Загрузка избранных продуктов из UserDefaults
    func loadFavoriteProducts() {
        if let savedData = UserDefaults.standard.data(forKey: "favoriteProducts"),
           let decodedProducts = try? JSONDecoder().decode([Product].self, from: savedData) {
            favoriteProducts = decodedProducts
        }
    }

    // Добавление или удаление продукта из избранного
    func toggleFavorite(for product: Product) {
        if let index = favoriteProducts.firstIndex(where: { $0.id == product.id }) {
            favoriteProducts.remove(at: index)
        } else {
            favoriteProducts.append(product)
        }
        saveFavoriteProducts()
    }

    // Проверка, находится ли продукт в избранном
    func isFavorite(_ product: Product) -> Bool {
        return favoriteProducts.contains(where: { $0.id == product.id })
    }

    // Увеличение количества товара
    func increaseQuantity(for product: Product) {
        if let index = selectedProducts.firstIndex(where: { $0.id == product.id }) {
            selectedProducts[index].quantity += 1
            saveSelectedProducts()
        }
    }
    
    // Уменьшение количества товара
    func decreaseQuantity(for product: Product) {
        if let index = selectedProducts.firstIndex(where: { $0.id == product.id }) {
            if selectedProducts[index].quantity > 1 {
                selectedProducts[index].quantity -= 1
            } else {
                selectedProducts.remove(at: index)
            }
            saveSelectedProducts()
        }
    }
}
