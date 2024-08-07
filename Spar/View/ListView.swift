import SwiftUI

struct ListView: View {
    let items = Array(1...10).map { "Item \($0)" }

    var body: some View {
        List(items, id: \.self) { item in
            Text(item)
        }
    }
}

#Preview {
    ListView()
}
