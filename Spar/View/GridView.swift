import SwiftUI

struct GridView: View {
    @State private var favorite = "Шт" //временно
    var favorites = ["Шт", "Кг"] //временно
    @ObservedObject var viewModel = ViewModel()
    @State var tapOnCard = false
    @State var tapOnHeart = false

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
                            .offset(y: 70)
                            if let badge = product.badge {
                                Text(badge.rawValue)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 10))
                                    .fontWeight(.regular)
                                    .padding(EdgeInsets(top: 2, leading: 12, bottom: 4, trailing: 6))
                                    .background(Color(UIColor(named: "#FC6A6FE5") ?? .red).opacity(0.9))
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .position(x: 40, y: 7.5)
                            }
                            VStack {
                                Button(action: {
                                }) {
                                    Image(systemName: "list.bullet.rectangle.portrait")
                                        .padding(8)
                                }
                                Button(action: {
                                    tapOnHeart.toggle()
                                }) {
                                    if tapOnHeart {
                                        Image(systemName: "heart.fill")
                                            .foregroundStyle(Color(UIColor(named: "#15B742") ?? .red))
                                            .padding(8)
                                    } else {
                                        Image(systemName: "heart")
                                            .padding(8)
                                    }
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
                        
                        if !tapOnCard {
                            HStack (alignment: .top) {
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
                                    tapOnCard = true
                                }) {
                                    Rectangle()
                                        .fill(Color(UIColor(named: "#15B742") ?? .red))
                                        .frame(width: 40, height: 36)
                                        .clipShape(RoundedRectangle(cornerRadius: 18))
                                        .overlay(
                                            Image("Card")
                                        )
                                }
                            }
                        }
                        
                        if tapOnCard {
                            if product.hasPicker {
                                Picker("Favorite", selection: $favorite) {
                                    ForEach(favorites, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                            HStack {
                                Button(action: {
                                    tapOnCard = false
                                }) {
                                    Image("Minus")
                                }
                                Spacer()
                                VStack {
                                    Text("1 \(product.measure.rawValue)")
                                        .font(.system(size: 16))
                                        .fontWeight(.bold)
                                    Text("~\(product.price)")
                                        .font(.system(size: 12))
                                        .fontWeight(.regular)
                                }
                                Spacer()
                                Button(action: {
                                    
                                }) {
                                    Image("Plus")
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
        }
    }
}

#Preview {
    GridView()
}
