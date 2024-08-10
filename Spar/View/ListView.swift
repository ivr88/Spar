import SwiftUI

struct ListView: View {
    @State private var favorite = "Шт" //временно
    var favorites = ["Шт", "Кг"] //временно
    @ObservedObject var viewModel = ViewModel()
    @State var tapOnCard = false
    @State var tapOnHeart = false

    var body: some View {
        Text("Hello")
//        viewModel.selectedProducts.append(product)
//        viewModel.saveSelectedProducts()
//        List(viewModel.model?.product ?? [], id: \.id) { product in
//            HStack (alignment: .top) {
//                ZStack (alignment: .leading) {
//                    Image(product.image)
//                        .resizable()
//                        .scaledToFit()
//                    HStack {
//                        Spacer()
//                        if product.discount {
//                            Text(viewModel.discountCalculation(newPrice: product.price, oldPrice: product.oldPrice))
//                                .foregroundStyle(Color(UIColor(named: "#C32323") ?? .red))
//                                .font(.system(size: 16))
//                                .fontWeight(.bold)
//                        }
//                    }
//                    .frame(alignment: .bottomTrailing)
//                    if let badge = product.badge {
//                        Text(badge.rawValue)
//                            .foregroundStyle(.white)
//                            .font(.system(size: 10))
//                            .fontWeight(.regular)
//                            .padding(EdgeInsets(top: 2, leading: 12, bottom: 4, trailing: 6))
//                            .background(Color(UIColor(named: "#FC6A6FE5") ?? .red).opacity(0.9))
//                            .clipShape(RoundedRectangle(cornerRadius: 6))
//                            .position(x: 40, y: 7.5)
//                    }
//                }
//                VStack (alignment: .leading) {
//                    HStack {
//                        VStack (alignment: .leading) {
//                            HStack {
//                                if let rating = product.rating {
//                                    Image(systemName: "star.fill")
//                                        .foregroundColor(.yellow)
//                                    Text(rating)
//                                        .foregroundStyle(.black)
//                                        .font(.system(size: 12))
//                                        .fontWeight(.regular)
//                                    Rectangle()
//                                        .frame(width: 1, height: 16)
//                                        .foregroundColor(.gray)
//                                }
//                                if let reviews = product.reviews {
//                                    Text("\(reviews) отзывов")
//                                        .foregroundStyle(.gray)
//                                        .font(.system(size: 12))
//                                        .fontWeight(.regular)
//                                        .lineLimit(1)
//                                        .minimumScaleFactor(0.5)
//                                        .scaledToFit()
//                                }
//                            }
//                            Text(product.description)
//                                .foregroundStyle(.black)
//                                .font(.system(size: 12))
//                                .fontWeight(.regular)
//                            HStack {
//                                Text(product.country.rawValue)
//                                    .foregroundStyle(.black)
//                                    .font(.system(size: 12))
//                                    .fontWeight(.regular)
//                                Image(product.countryImage)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 16, height: 16)
//                            }
//                        }
//                        Spacer()
//                        VStack {
//                            Button(action: {
//                            }) {
//                                Image(systemName: "list.bullet.rectangle.portrait")
//                                    .padding(8)
//                            }
//                            Button(action: {
//                                tapOnHeart.toggle()
//                            }) {
//                                if tapOnHeart {
//                                    Image(systemName: "heart.fill")
//                                        .foregroundStyle(Color(UIColor(named: "#15B742") ?? .red))
//                                        .padding(8)
//                                } else {
//                                    Image(systemName: "heart")
//                                        .padding(8)
//                                }
//                            }
//                            .buttonStyle(PlainButtonStyle())
//                        }
//                        .foregroundStyle(.gray)
//                        .background(Color.white.opacity(0.9))
//                        .clipShape(RoundedRectangle(cornerRadius: 16))
//                        
//                    }
//                    if !tapOnCard {
//                        HStack {
//                            VStack (alignment: .leading) {
//                                Text("\(product.price) ₽/\(product.measure.rawValue)")
//                                    .foregroundStyle(.black)
//                                    .font(.system(size: 20))
//                                    .fontWeight(.bold)
//                                    .minimumScaleFactor(0.5)
//                                    .scaledToFit()
//                                if let price = product.oldPrice {
//                                    Text(price)
//                                        .foregroundStyle(.gray)
//                                        .font(.system(size: 12))
//                                        .fontWeight(.regular)
//                                        .strikethrough()
//                                }
//                            }
//                            
//                            Spacer()
//                            
//                            Button(action: {
//                                tapOnCard = true
//                            }) {
//                                Rectangle()
//                                    .fill(Color(UIColor(named: "#15B742") ?? .red))
//                                    .frame(width: 40, height: 36)
//                                    .clipShape(RoundedRectangle(cornerRadius: 18))
//                                    .overlay(
//                                        Image("Cart")
//                                    )
//                            }
//                            .buttonStyle(PlainButtonStyle())
//                        }
//                        .contentShape(Rectangle())
//                    }
//                    
//                    if tapOnCard {
//                        if product.hasPicker {
//                            Picker("Favorite", selection: $favorite) {
//                                ForEach(favorites, id: \.self) {
//                                    Text($0)
//                                }
//                            }
//                            .pickerStyle(.segmented)
//                        }
//                        HStack {
//                            Button(action: {
//                                tapOnCard = false
//                            }) {
//                                Image("Minus")
//                            }
//                            Spacer()
//                            VStack {
//                                Text("1 \(product.measure.rawValue)")
//                                    .font(.system(size: 16))
//                                    .fontWeight(.bold)
//                                Text("~\(product.price)")
//                                    .font(.system(size: 12))
//                                    .fontWeight(.regular)
//                            }
//                            Spacer()
//                            Button(action: {
//                                
//                            }) {
//                                Image("Plus")
//                            }
//                        }
//                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
//                        .background(Color(UIColor(named: "#15B742") ?? .red))
//                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                        .foregroundColor(.white)
//                    }
//                }
//            }
//            .listRowBackground(Color.white)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//        }
//        .listStyle(.plain)
//        .listRowSpacing(1)
//        .scrollIndicators(.hidden)
//        .scrollContentBackground(.hidden)
//        .background(.white)
//        .onAppear {
//            viewModel.fetch()
//        }
    }
}

#Preview {
    ListView()
}
