import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var tapOnCard = false
    @State var tapOnHeart = false

    var body: some View {
        VStack {
            List(viewModel.model?.product ?? [], id: \.id) { product in
                HStack {
                    ZStack {
                        Image(product.image)
                            .resizable()
                            .scaledToFit()
                        HStack {
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
                    VStack {
                        VStack {
                            HStack {
                                if let rating = product.rating {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text(rating)
                                        .foregroundStyle(.black)
                                        .font(.system(size: 12))
                                        .fontWeight(.regular)
                                    Rectangle()
                                        .frame(width: 2, height: 20)
                                        .foregroundColor(.gray)
                                }
                                if let reviews = product.reviews {
                                    Text("\(reviews) отзывов")
                                        .foregroundStyle(.gray)
                                        .font(.system(size: 12))
                                        .fontWeight(.regular)
                                }
                            }
                            Text(product.description)
                                .foregroundStyle(.black)
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                        }
                    }
                }
                .listRowBackground(Color.white)
            }
            .listRowSpacing(1)
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
            .onAppear {
                viewModel.fetch()
            }
        }
        .background(.white)
    }
}

#Preview {
    ListView()
}
