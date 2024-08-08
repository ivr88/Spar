import Foundation

final class ViewModel: ObservableObject {
    
    @Published var model: Model?
    
    func fetch() {
        guard let url = URL(string: "https://run.mocky.io/v3/139b45da-dc8c-4dd3-8a58-066b28b2947b") else {
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
}
