import Foundation

@MainActor
public protocol RootCoordinator: Coordinator {
    var childCoordinators: [any Coordinator] { get set }
}

public extension RootCoordinator {
    func didFinish(_ coordinator: any Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
