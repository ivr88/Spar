import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        List {
            ForEach(viewModel.favoriteProducts, id: \.id) { product in
                HStack {
                    Image(product.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(product.description)
                            .font(.headline)
                        Text(product.country.rawValue)
                            .font(.subheadline)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.toggleFavorite(for: product)
                    }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.green)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .contentShape(Rectangle())
            }
        }
        .navigationTitle("Избранное")
    }
}

#Preview {
    FavoriteView()
}
