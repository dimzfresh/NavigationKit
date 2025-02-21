import SwiftUI

public struct NavigableView: Navigable {
    public let view: any View
    public let navigationType: NavigationType

    public init(
        view: any View,
        navigationType: NavigationType
    ) {
        self.view = view
        self.navigationType = navigationType
    }
}
