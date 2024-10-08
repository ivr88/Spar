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
                            .frame(width: 10, height: 10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    VStack {
                        Text("\(viewModel.quantityText(for: product))")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                        Text("~\(viewModel.totalCost(for: product))")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                    }
                    Button(action: {
                        viewModel.increaseQuantity(for: product)
                    }) {
                        Image("Plus")
                            .frame(width: 10, height: 10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .contentShape(Rectangle())
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
