import SwiftUI

@main
struct AppStorageApp: App {
    var body: some Scene {
        Window("@AppStorage 持久化", id: "main") {
            ContentView()
        }
        .defaultSize(width: 500, height: 400)
    }
}
