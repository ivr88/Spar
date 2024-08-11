import SwiftUI

struct SplashView: View {
    @Binding var isActive: Bool
    var body: some View {
        Color.white
            .ignoresSafeArea()
            .overlay (
                Image("Logo")
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView(isActive: .constant(true))
}
