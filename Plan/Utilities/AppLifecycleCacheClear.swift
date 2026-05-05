import SwiftUI

struct AppLifecycleCacheClear: ViewModifier {
    @Environment(\.scenePhase) private var scenePhase

    func body(content: Content) -> some View {
        content
            .onChange(of: scenePhase) { _, newPhase in
                
                if newPhase == .background {
                    NetworkManager.shared.clearCache()
                }
            }
    }
}

extension View {
    func clearCacheOnBackground() -> some View {
        modifier(AppLifecycleCacheClear())
    }
}
