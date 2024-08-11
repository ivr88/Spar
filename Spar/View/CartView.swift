import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        List (viewModel.selectedProducts, id: \.id) { product in
            HStack {
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text(product.description)
                    .font(.headline)
                Spacer()
                HStack {
                    Button(action: {
                        viewModel.decreaseQuantity(for: product)
                    }) {
                        Image("Minus")
                            .frame(width: 20, height: 20)
                    }
                    .buttonStyle(PlainButtonStyle())
                    VStack {
                        Text("\(product.selectedQuantity.rawValue, specifier: "%.1f") \(viewModel.selectedProducts[viewModel.selectedProducts.firstIndex(where: { $0.id == product.id })!].selectedMeasure.rawValue)")
                        Text("\(viewModel.calculatePrice(for: product)) ₽")
                    }
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    Button(action: {
                        viewModel.increaseQuantity(for: product)
                    }) {
                        Image("Plus")
                            .frame(width: 20, height: 20)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .background(Color(UIColor(named: "#15B742") ?? .red))
                .clipShape(.rect(cornerRadius: 50))
                .foregroundColor(.white)
            }
            .foregroundStyle(.black)
            .contentShape(Rectangle())
            .listRowBackground(Color.white)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Корзина")
                            .font(.headline)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .listStyle(.plain)
        .listRowSpacing(1)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
        .background(.white)
        .toolbarBackground(.white, for: .navigationBar)
    }
}

#Preview {
    CartView()
}
