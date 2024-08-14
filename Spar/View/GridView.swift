import SwiftUI

struct GridView: View {
    @ObservedObject var viewModel = ViewModel()
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(viewModel.model?.product ?? [], id: \.id) { product in
                    ProductView(product: product, viewModel: viewModel)
                }
            }
            .padding(.horizontal, 16)
            .toolbarBackground(.white, for: .navigationBar)
        }
        .background(Color.white)
        .onAppear {
            viewModel.fetch()
            viewModel.loadSelectedProducts()
            viewModel.loadFavoriteProducts()
        }
    }
}

struct ProductView: View {
    var product: Product
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ProductImageView(product: product, viewModel: viewModel)
            ProductDetailsView(product: product, viewModel: viewModel)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 3)
    }
}

struct ProductImageView: View {
    var product: Product
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Image(product.image)
                .resizable()
                .scaledToFit()

            VStack(alignment: .leading) {
                ProductBadgeView(product: product, viewModel: viewModel)
                Spacer()
                ProductRatingAndDiscountView(product: product, viewModel: viewModel)
            }
        }
    }
}

struct ProductBadgeView: View {
    var product: Product
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            if let badge = product.badge {
                let text = Text(badge.rawValue)
                    .foregroundColor(.white)
                    .font(.system(size: 10))
                    .fontWeight(.regular)
                    .padding(EdgeInsets(top: 2, leading: 12, bottom: 4, trailing: 6))
                
                switch badge {
                case .redBadge:
                    text.background(Color(UIColor(named: "#FC6A6FE5") ?? .red).opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                case .geenBadge:
                    text.background(Color(UIColor(named: "#5BCD7BE5") ?? .red).opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                case .blueBadge:
                    text.background(Color(UIColor(named: "#7A79BAE5") ?? .red))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
            Spacer()
            ProductActionButtons(product: product, viewModel: viewModel)
        }
    }
}

struct ProductActionButtons: View {
    var product: Product
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            Button(action: {
                // Действие для списка
            }) {
                Image("Tallon")
                    .padding(8)
            }
            Button(action: {
                viewModel.toggleFavorite(for: product)
            }) {
                Image(systemName: viewModel.isFavorite(product) ? "heart.fill" : "heart")
                    .foregroundColor(viewModel.isFavorite(product) ? Color(UIColor(named: "#15B742") ?? .red) : .gray)
                    .padding(8)
            }
        }
        .background(Color.white.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct ProductRatingAndDiscountView: View {
    var product: Product
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        HStack(alignment: .bottom) {
            if let rating = product.rating {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(rating)
                        .foregroundColor(.black)
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                }
            }
            Spacer()
            if product.discount {
                Text(viewModel.discountCalculation(newPrice: product.price, oldPrice: product.oldPrice))
                    .foregroundColor(Color(UIColor(named: "#C32323") ?? .red))
                    .font(.system(size: 16))
                    .fontWeight(.bold)
            }
        }
        .padding([.bottom, .leading, .trailing], 5)
    }
}

struct ProductDetailsView: View {
    var product: Product
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(product.description)
                .foregroundColor(.black)
                .font(.system(size: 12))
                .fontWeight(.regular)
            HStack {
                Text(product.country.rawValue)
                    .foregroundColor(.black)
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                AsyncImage(url: URL(string: product.countryImage)) { phase in
                    phase.image?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                }
            }
            if !viewModel.selectedProducts.contains(where: { $0.id == product.id }) {
                ProductAddToCartView(product: product, viewModel: viewModel)
            } else {
                ProductQuantitySelectorView(product: product, viewModel: viewModel)
            }
        }
        .padding([.horizontal, .bottom], 5)
    }
}

struct ProductAddToCartView: View {
    var product: Product
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(product.price, specifier: "%.2f") ₽/\(product.selectedMeasure.rawValue)")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                if let price = product.oldPrice {
                    Text("\(price, specifier: "%.2f") ₽")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                        .strikethrough()
                }
            }
            Spacer()
            Button(action: {
                viewModel.selectedProducts.append(product)
                viewModel.saveSelectedProducts()
            }) {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(UIColor(named: "#15B742") ?? .red))
                    .frame(width: 40, height: 36)
                    .overlay(
                        Image("Cart")
                            .foregroundColor(.white)
                    )
            }
        }
    }
}

struct ProductQuantitySelectorView: View {
    var product: Product
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            if product.hasPicker {
                if let index = viewModel.selectedProducts.firstIndex(where: { $0.id == product.id }) {
                    Picker("Единица измерения", selection: $viewModel.selectedProducts[index].selectedMeasure) {
                        Text("Шт").tag(Measure.pieces)
                        Text("Кг").tag(Measure.kilograms)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                } else {
                    Text("Продукт не найден")
                }
            }
            HStack {
                Button(action: {
                    viewModel.decreaseQuantity(for: product)
                }) {
                    Image("Minus")
                        .frame(width: 20, height: 20)
                }
                Spacer()
                VStack {
                    Text("\(viewModel.quantityText(for: product))")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                    Text("~\(viewModel.totalCost(for: product))")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                }
                Spacer()
                Button(action: {
                    viewModel.increaseQuantity(for: product)
                }) {
                    Image("Plus")
                        .frame(width: 20, height: 20)
                }
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .background(Color(UIColor(named: "#15B742") ?? .red))
            .clipShape(Capsule())
            .foregroundColor(.white)
        }
    }
}

#Preview {
    GridView()
}
