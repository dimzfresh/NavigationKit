import SwiftUI

public struct NavigatingView<Coordinator: BaseCoordinator>: View {
    @StateObject private var router: NavigationRouter
    @StateObject private var coordinator: Coordinator

    private var content: () -> any View

    @ViewBuilder
    private var viewToPresent: some View {
        if let presentedView = router.presentedView {
            NavigatingView(
                router: coordinator.topNavigationRouter,
                coordinator: coordinator
            ) {
                presentedView.view
            }
        }
    }

    public var body: some View {
        NavigationStack(path: $router.path) {
            content()
                .eraseToAnyView()
                .navigationDestination(for: NavigableView.self) {
                    $0.view
                        .eraseToAnyView()
                }
        }
        .sheet(isPresented: router.isPresented(with: .sheet())) {
            let detents = router.presentedView?.navigationType.presentationType?.detents ?? []
            viewToPresent
                .presentationDetents(detents)
        }
        .fullScreenCover(isPresented: router.isPresented(with: .fullScreen)) {
            viewToPresent
        }
        .sheet(isPresented: coordinator.shouldPresentChild(from: router)) {
            if let childCoordinator = coordinator.childCoordinator {
                childCoordinator.rootView
                    .eraseToAnyView()
            }
        }
    }

    public init(
        router: NavigationRouter,
        coordinator: Coordinator,
        content: @escaping () -> any View
    ) {
        _router = .init(wrappedValue: router)
        _coordinator = .init(wrappedValue: coordinator)
        self.content = content
    }
}
