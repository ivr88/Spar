import SwiftUI

struct GridView: View {
    var favorites = ["Шт", "Кг"] // временно
    @ObservedObject var viewModel = ViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(viewModel.model?.product ?? [], id: \.id) { product in
                    VStack (alignment: .leading) {
                        ZStack {
                            Image(product.image)
                                .resizable()
                                .scaledToFit()
                            HStack {
                                if let rating = product.rating {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text(rating)
                                        .foregroundStyle(.black)
                                        .font(.system(size: 12))
                                        .fontWeight(.regular)
                                }
                                Spacer()
                                if product.discount {
                                    Text(viewModel.discountCalculation(newPrice: product.price, oldPrice: product.oldPrice))
                                        .foregroundStyle(Color(UIColor(named: "#C32323") ?? .red))
                                        .font(.system(size: 16))
                                        .fontWeight(.bold)
                                }
                            }
                            .frame(alignment: .bottom)
                            if let badge = product.badge {
                                Text(badge.rawValue)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 10))
                                    .fontWeight(.regular)
                                    .padding(EdgeInsets(top: 2, leading: 12, bottom: 4, trailing: 6))
                                    .background(Color(UIColor(named: "#FC6A6FE5") ?? .red).opacity(0.9))
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .position(x: 0, y: 0)
                            }
                            VStack {
                                Button(action: {
                                }) {
                                    Image(systemName: "list.bullet.rectangle.portrait")
                                        .padding(8)
                                }
                                Button(action: {
                                    viewModel.toggleFavorite(for: product)
                                }) {
                                    Image(systemName: viewModel.isFavorite(product) ? "heart.fill" : "heart")
                                        .foregroundStyle(viewModel.isFavorite(product) ? Color(UIColor(named: "#15B742") ?? .red) : .gray)
                                        .padding(8)
                                }
                            }
                            .foregroundStyle(.gray)
                            .background(Color.white.opacity(0.9))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .position(x: 155, y: 35)
                        }
                        Text(product.description)
                            .foregroundStyle(.black)
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                        HStack {
                            Text(product.country.rawValue)
                                .foregroundStyle(.black)
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                            Image(product.countryImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                        }
                        
                        if !viewModel.selectedProducts.contains(where: { $0.id == product.id }) {
                            HStack {
                                VStack (alignment: .leading) {
                                    Text("\(product.price) ₽/\(product.measure.rawValue)")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .minimumScaleFactor(0.5)
                                        .scaledToFit()
                                    if let price = product.oldPrice {
                                        Text(price)
                                            .foregroundStyle(.gray)
                                            .font(.system(size: 12))
                                            .fontWeight(.regular)
                                            .strikethrough()
                                    }
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    viewModel.increaseQuantity(for: product)
                                }) {
                                    Rectangle()
                                        .fill(Color(UIColor(named: "#15B742") ?? .red))
                                        .frame(width: 40, height: 36)
                                        .clipShape(RoundedRectangle(cornerRadius: 18))
                                        .overlay(
                                            Image("Cart")
                                        )
                                }
                            }
                        } else {
                            if product.hasPicker {
                                Picker("Выбор единицы измерения", selection: $viewModel.selectedProducts[viewModel.selectedProducts.firstIndex(where: { $0.id == product.id })!].measure) {
                                    ForEach(favorites, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                            HStack {
                                Button(action: {
                                    viewModel.decreaseQuantity(for: product)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .frame(width: 20, height: 20)
                                }
                                Spacer()
                                VStack {
                                    Text("\(viewModel.selectedProducts.first(where: { $0.id == product.id })!.quantity) \(product.measure.rawValue)")
                                        .font(.system(size: 16))
                                        .fontWeight(.bold)
                                    Text("~\(product.price)")
                                        .font(.system(size: 12))
                                        .fontWeight(.regular)
                                }
                                Spacer()
                                Button(action: {
                                    viewModel.increaseQuantity(for: product)
                                }) {
                                    Image(systemName: "plus.circle")
                                        .frame(width: 20, height: 20)
                                }
                            }
                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .background(Color(UIColor(named: "#15B742") ?? .red))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 5)
                    .padding(.bottom, 4)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 3)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 9)
        }
        .background(.white)
        .onAppear {
            viewModel.fetch()
            viewModel.loadSelectedProducts()
            viewModel.loadFavoriteProducts()
        }
    }
}

#Preview {
    GridView()
}
