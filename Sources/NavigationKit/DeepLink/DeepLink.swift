import Foundation

protocol DeepLink {
    func canOpenURL(_ url: URL) -> Bool
    func openURL(_ url: URL)
}
