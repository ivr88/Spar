import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var tapOnCard = false

    var body: some View {
        List(viewModel.model?.product ?? [], id: \.id) { product in
            HStack (alignment: .top) {
                ZStack {
                    Image(product.image)
                        .resizable()
                        .scaledToFit()

                    VStack (alignment: .leading) {
                        HStack (alignment: .top) {
                            if let badge = product.badge {
                                let text = Text(badge.rawValue)
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .fontWeight(.regular)
                                    .padding(EdgeInsets(top: 2, leading: 12, bottom: 4, trailing: 6))
                                switch badge {
                                    case .redBadge:
                                        text.background(Color(UIColor(named: "#FC6A6FE5") ?? .red).opacity(0.9)).clipShape(RoundedRectangle(cornerRadius: 6))
                                    case .geenBadge:
                                        text.background(Color(UIColor(named: "#5BCD7BE5") ?? .red).opacity(0.9)).clipShape(RoundedRectangle(cornerRadius: 6))
                                    case .blueBadge:
                                        text.background(Color(UIColor(named: "#7A79BAE5") ?? .red).opacity(0.9)).clipShape(RoundedRectangle(cornerRadius: 6))
                                }
                            }
                            Spacer()
                        }
                        Spacer()
                        HStack (alignment: .bottom) {
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
                VStack (alignment: .leading) {
                    HStack (alignment: .top) {
                        VStack (alignment: .leading, spacing: 5) {
                            if let rating = product.rating {
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text(rating)
                                        .foregroundColor(.black)
                                        .font(.system(size: 12))
                                        .fontWeight(.regular)
                                    if let review = product.reviews {
                                        Rectangle()
                                            .frame(width: 1, height: 16)
                                            .foregroundColor(.gray)
                                        Text("\(review) отзывов")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12))
                                            .fontWeight(.regular)
                                    }
                                }
                            }
                            Text(product.description)
                                .foregroundColor(.black)
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                            HStack {
                                Text(product.country.rawValue)
                                    .foregroundColor(.black)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                Image(product.countryImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                            }
                        }
                        Spacer()
                        VStack {
                            Button(action: {
                                // Действие для списка
                            }) {
                                Image("Tallon")
                                    .padding(8)
                            }
                            .buttonStyle(PlainButtonStyle())
                            Button(action: {
                                viewModel.toggleFavorite(for: product)
                            }) {
                                Image(systemName: viewModel.isFavorite(product) ? "heart.fill" : "heart")
                                    .foregroundColor(viewModel.isFavorite(product) ? Color(UIColor(named: "#15B742") ?? .red) : .gray)
                                    .padding(8)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .background(Color.white.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    Spacer()
                    if !viewModel.selectedProducts.contains(where: { $0.id == product.id }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(product.price) ₽/\(product.selectedMeasure.rawValue)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                if let price = product.oldPrice {
                                    Text(price)
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
                            .buttonStyle(PlainButtonStyle())
                        }
                    } else {
                        VStack {
                            if product.hasPicker {
                                Picker("Выбор единицы измерения", selection: $viewModel.selectedProducts[viewModel.selectedProducts.firstIndex(where: { $0.id == product.id })!].selectedMeasure) {
                                    ForEach(product.measures, id: \.self) { measure in
                                        Text(measure.rawValue)
                                    }
                                }
                                .pickerStyle(.segmented)
                                .onChange(of: viewModel.selectedProducts[viewModel.selectedProducts.firstIndex(where: { $0.id == product.id })!].selectedMeasure) { newValue in
                                    viewModel.selectedProducts[viewModel.selectedProducts.firstIndex(where: { $0.id == product.id })!].selectedQuantity = newValue == .kilo ? .forKilo : .forThings
                                }
                            }
                            
                            HStack {
                                Button(action: {
                                    viewModel.decreaseQuantity(for: product)
                                }) {
                                    Image("Minus")
                                        .frame(width: 20, height: 20)
                                }
                                .buttonStyle(PlainButtonStyle())
                                Spacer()
                                VStack {
                                    Text("\(viewModel.selectedProducts[viewModel.selectedProducts.firstIndex(where: { $0.id == product.id })!].selectedQuantity.rawValue) \(viewModel.selectedProducts[viewModel.selectedProducts.firstIndex(where: { $0.id == product.id })!].selectedMeasure.rawValue)")
                                    Text("\(viewModel.calculatePrice(for: product)) ₽")
                                }
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                Spacer()
                                Button(action: {
                                    viewModel.increaseQuantity(for: product)
                                }) {
                                    Image("Plus")
                                        .frame(width: 20, height: 20)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .contentShape(Rectangle())
                            .padding()
                            .background(Color(UIColor(named: "#15B742") ?? .red))
                            .clipShape(.rect(cornerRadius: 50))
                            .foregroundColor(.white)
                        }
                    }
                }
            }
            .listRowBackground(Color.white)
            .contentShape(Rectangle())
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .listStyle(.plain)
        .listRowSpacing(1)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
        .background(.white)
        .toolbarBackground(.white, for: .navigationBar)
        .onAppear {
            viewModel.fetch()
        }
    }
}

#Preview {
    ListView()
}
