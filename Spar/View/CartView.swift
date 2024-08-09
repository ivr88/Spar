import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        List {
            ForEach(viewModel.selectedProducts, id: \.id) { product in
                HStack {
                    Image(product.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(product.description)
                            .font(.headline)
                        Text(product.country.rawValue)
                            .font(.subheadline)
                    }
                    Spacer()
                    HStack {
                        Button(action: {
                            viewModel.decreaseQuantity(for: product)
                        }) {
                            Image(systemName: "minus.circle")
                        }
                        Text("\(product.quantity)")
                            .frame(width: 40)
                        Button(action: {
                            viewModel.increaseQuantity(for: product)
                        }) {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
            }
        }
        .navigationTitle("Корзина")
    }
}

#Preview {
    CartView()
}
