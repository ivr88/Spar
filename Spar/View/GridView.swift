import SwiftUI

struct GridView: View {
    let items = Array(1...10).map { "Item \($0)" } //временно
    @State private var favorite = "Шт" //временно
    var favorites = ["Шт", "Кг"] //временно
    @State var tapOnCard = false
    @State var tapOnHeart = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(items, id: \.self) { item in
                    VStack (alignment: .leading) {
                        ZStack {
                            Image("Apples")
                                .resizable()
                                .scaledToFit()
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text("4.1")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                Spacer()
                                Text("25%")
                                    .foregroundStyle(Color(UIColor(named: "#C32323") ?? .red))
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                            }
                            .offset(y: 70)
                            Text("Удар по ценам")
                                .foregroundStyle(.white)
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .padding(EdgeInsets(top: 2, leading: 12, bottom: 4, trailing: 6))
                                .background(Color(UIColor(named: "#FC6A6FE5") ?? .red).opacity(0.9))
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .position(x: 40, y: 7.5)
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
                        Text("Салат Овощной с Крабовыми Палочками")
                            .foregroundStyle(.black)
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                        HStack {
                            Text("France")
                                .foregroundStyle(.black)
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                            Image("France")
                        }
                        
                        Picker("Favorite", selection: $favorite) {
                            ForEach(favorites, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        if !tapOnCard {
                            HStack (alignment: .top) {
                                VStack (alignment: .leading) {
                                    Text("260 90")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .minimumScaleFactor(0.5)
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                        .scaledToFit()
                                    Text("159,0")
                                        .foregroundStyle(.gray)
                                        .font(.system(size: 12))
                                        .fontWeight(.regular)
                                        .strikethrough()
                                }
                                Text("₽/кг")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .minimumScaleFactor(0.5)
                                    .scaledToFit()
                                
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
                            HStack {
                                Button(action: {
                                    tapOnCard = false
                                }) {
                                    Image("Minus")
                                }
                                Spacer()
                                VStack {
                                    Text("1 шт")
                                        .font(.system(size: 16))
                                        .fontWeight(.bold)
                                    Text("~10,0 ₽")
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
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 3)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 9)
        }
        .background(.white)
    }
}

#Preview {
    GridView()
}
