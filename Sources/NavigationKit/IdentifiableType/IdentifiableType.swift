import Foundation

public protocol IdentifiableType: Identifiable, Hashable {}

public extension IdentifiableType {
    /// The default identifier based on the type name
    var id: String {
        String(describing: self.self)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
