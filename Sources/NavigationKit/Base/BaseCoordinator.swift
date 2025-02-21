import SwiftUI

@MainActor
public protocol BaseCoordinator: Coordinator {
    var childCoordinator: (any Coordinator)? { get set }
    var navigationRouters: [NavigationRouter] { get set }
}

extension BaseCoordinator {
    var rootNavigationRouter: NavigationRouter {
        guard let router = navigationRouters.first else {
            fatalError("Root navigation router not found")
        }

        return router
    }

    var topNavigationRouter: NavigationRouter {
        guard let router = navigationRouters.last else {
            fatalError("Top navigation router not found")
        }

        return router
    }

    func shouldPresentChild(from router: NavigationRouter) -> Binding<Bool> {
        .init { [weak self] in
            guard let self else { return false }

            return childCoordinator != nil && topNavigationRouter === router
        } set: { [weak self] isShown in
            guard !isShown else { return }

            self?.dismissChild()
        }
    }
}

public extension BaseCoordinator {
    func presentChild(_ coordinator: any Coordinator) {
        childCoordinator = coordinator
        coordinator.finishDelegate = self
    }
    
    func dismissChild() {
        childCoordinator = nil
    }

    func didFinish(_ coordinator: any Coordinator) {
        dismissChild()
    }
}

public extension BaseCoordinator {
    func setupNavigationRouter() {
        navigationRouters.append(
            .init { [weak self] router in
                self?.dismissNavigationRouter(router)
            }
        )
    }

    func push(_ view: NavigableView) {
        switch view.navigationType {
        case .push:
            topNavigationRouter.path.append(view)
        case .present:
            topNavigationRouter.presentedView = view
            let router = NavigationRouter { [weak self] router in
                self?.dismissNavigationRouter(router)
            }
            navigationRouters.append(router)
        }
    }

    func popLast() {
        guard topNavigationRouter.path.count > 0 else { return }

        navigationRouters.last?.path.removeLast()
    }
    
    func popToRoot() {
        guard topNavigationRouter.path.count > 0 else { return }

        navigationRouters.last?.path.removeLast(topNavigationRouter.path.count)
    }
    
    func dismissTop() {
        guard navigationRouters.count > 1 else { return }

        navigationRouters.removeLast()
        topNavigationRouter.presentedView = nil
    }
    
    func dismissToRoot() {
        childCoordinator?.finish()
        
        guard navigationRouters.count > 1 else { return }

        navigationRouters.removeLast(navigationRouters.count - 1)
        rootNavigationRouter.presentedView = nil
    }
    
    func dismissNavigationRouter(_ router: NavigationRouter) {
        guard let index = navigationRouters.firstIndex(where: { $0 === router }) else { return }

        navigationRouters.removeLast(navigationRouters.count - 1 - index)
    }
}
