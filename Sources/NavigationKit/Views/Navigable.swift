import SwiftUI

public protocol Navigable: IdentifiableType {
    var view: any View { get }
    var navigationType: NavigationType { get }
}
