import Foundation

final class DeepLinkCoordinator {
    private var deepLinks: [any DeepLink]

    init(deepLinks: [any DeepLink] = []) {
        self.deepLinks = deepLinks
    }
    
    func addDeepLinks(_ deepLinks: [any DeepLink]) {
        self.deepLinks.append(contentsOf: deepLinks)
    }
    
    @discardableResult
    func handleURL(_ url: URL) -> Bool {
        guard let deepLink = deepLinks.first(where: { $0.canOpenURL(url) }) else { return false }

        deepLink.openURL(url)

        return true
    }
}
