import SwiftUI

struct ContentView: View {
    @State private var isGridView = true
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        NavigationView {
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
                            NavigationLink(destination: FavoriteView(viewModel: viewModel)) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.green)
                            }
                        }

                        if !viewModel.selectedProducts.isEmpty {
                            NavigationLink(destination: CartView(viewModel: viewModel)) {
                                Image(systemName: "cart.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

