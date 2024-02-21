import SwiftUI

@main
struct GreenhouseApp: App {
    
    init() {
        AppContainer.setup()
    }
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
        }
    }
}
