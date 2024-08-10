import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        List (viewModel.favoriteProducts, id: \.id) { product in
            HStack {
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text(product.description)
                        .font(.headline)
                    Text("\(product.price) ₽")
                        .font(.subheadline)
                }
                .foregroundStyle(.black)
                Spacer()
                Button(action: {
                    viewModel.toggleFavorite(for: product)
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color(UIColor(named: "#15B742") ?? .red))
                }
                .buttonStyle(PlainButtonStyle())
            }
            .contentShape(Rectangle())
            .listRowBackground(Color.white)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Избранное")
                            .font(.headline)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .listStyle(.plain)
        .listRowSpacing(1)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
        .background(.white)
    }
}

#Preview {
    FavoriteView()
}
