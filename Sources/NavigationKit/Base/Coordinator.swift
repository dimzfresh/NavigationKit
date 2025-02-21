import SwiftUI

@MainActor
public protocol Coordinator: ObservableObject, CoordinatorFinishDelegate {
    associatedtype Content: View
    
    @MainActor @ViewBuilder var rootView: Content { get }
    
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func finish()
}

public extension Coordinator {
    func finish() {
        finishDelegate?.didFinish(self)
    }
}
