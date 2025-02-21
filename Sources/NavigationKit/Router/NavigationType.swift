import SwiftUI

public enum NavigationType: Equatable {
    /// A push transition style, commonly used in navigation controllers.
    case push
    /// A presentation style, often used for modal or overlay views.
    case present(PresentationType)
}

public enum PresentationType: Equatable {
    /// A sheet presentation style
    case sheet(Set<PresentationDetent> = [])
    /// A full-screen cover presentation style.
    case fullScreen
    /// A custom-screen (Implement if needed).
    case custom
}

public extension NavigationType {
    var presentationType: PresentationType? {
        guard case let .present(type) = self else { return nil }

        return type
    }
}

public extension PresentationType {
    // ignores detents for sheets
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.sheet, .sheet): true
        case (.fullScreen, .fullScreen): true
        case (.custom, .custom): true
        default: false
        }
    }
    
    var detents: Set<PresentationDetent> {
        guard case let .sheet(detents) = self else { return [] }

        return detents
    }
}
