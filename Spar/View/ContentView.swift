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
        }
    }
}

#Preview {
    ContentView()
}

