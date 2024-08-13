import SwiftUI

struct ContentView: View {
    @State private var isGridView = true
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if isGridView {
                    GridView(viewModel: viewModel)
                } else {
                    ListView(viewModel: viewModel)
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        if !viewModel.favoriteProducts.isEmpty {
                            NavigationLink(destination: FavoriteView(viewModel: viewModel).toolbarRole(.editor)) {
                                Rectangle()
                                    .fill(Color(UIColor(named: "#F1F1F1") ?? .red))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(Color(UIColor(named: "#15B742") ?? .red))
                                    )
                                    .cornerRadius(12)
                            }
                        }
                        if !viewModel.selectedProducts.isEmpty {
                            NavigationLink(destination: CartView(viewModel: viewModel).toolbarRole(.editor)) {
                                Rectangle()
                                    .fill(Color(UIColor(named: "#15B742") ?? .red))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Image("Cart")
                                    )
                                    .cornerRadius(12)
                            }
                        }
                    }
                }
            }
        }
        .tint(.black)
    }
}

#Preview {
    ContentView()
}

