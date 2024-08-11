import SwiftUI

struct CoordinatorView: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            ContentView()
        } else {
            SplashView(isActive: $isActive)
        }
    }
}

#Preview {
    CoordinatorView()
}

