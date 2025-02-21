import SwiftUI

@MainActor
public final class NavigationRouter: ObservableObject {
    @Published var path: [NavigableView] = []
    @Published var presentedView: NavigableView?

    private let onDismiss: (NavigationRouter) -> Void

    public init(onDismiss: @escaping (NavigationRouter) -> Void) {
        self.onDismiss = onDismiss
    }
    
    func isPresented(with type: PresentationType) -> Binding<Bool> {
        .init { [weak self] in
            guard let currentType = self?.presentedView?.navigationType.presentationType else { return false }

            return type == currentType
        } set: { [weak self] newValue in
            guard let self, !newValue else { return }

            presentedView = nil
            onDismiss(self)
        }
    }
}
