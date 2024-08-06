import SwiftUI

struct ContentView: View {
    @State private var isGridView = true

    var body: some View {
        NavigationView {
            Group {
                if isGridView {
                    GridView()
                } else {
                    ListView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isGridView.toggle()
                    }) {
                        Rectangle()
                            .fill(Color(UIColor(named: "#F1F1F1") ?? .red))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Image(isGridView ? "List" : "Grid")
                            )
                            .cornerRadius(12)
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .backgroundStyle(.white)
    }
}

struct GridView: View {
    let items = Array(1...10).map { "Item \($0)" } //временно
    @State private var favorite = "Шт" //временно
    var favorites = ["Шт", "Кг"] //временно
    @State var tapOnCard = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(items, id: \.self) { item in
                    ZStack {
                        VStack (alignment: .leading) {
                            Image("1")
                            Text("Салат Овощной с Крабовыми Палочками")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                            HStack {
                                Text("France")
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
                                        Text("260,90")
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                        Text("159,0")
                                            .font(.system(size: 12))
                                            .fontWeight(.regular)
                                            .foregroundColor(.gray)
                                            .strikethrough()
                                    }
                                    Text("₽/кг")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        tapOnCard = true
                                    }) {
                                        Rectangle()
                                            .fill(Color(UIColor(named: "#15B742") ?? .red))
                                            .frame(width: 40, height: 36)
                                            .cornerRadius(18)
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
                                .clipShape(.rect(cornerRadius: 20))
                                .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal, 5)
                        .padding(.bottom, 4)
                        .background(Color.white)
                        .clipShape(.rect(cornerRadius: 20))
                        .shadow(radius: 2)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("4.1")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                        }
                        .offset(x: -60)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 9)
        }
    }
}

struct ListView: View {
    let items = Array(1...10).map { "Item \($0)" }

    var body: some View {
        List(items, id: \.self) { item in
            Text(item)
        }
    }
}

#Preview {
    ContentView()
}
