# NavigationKit

A powerful SwiftUI navigation framework that provides a clean, coordinator-based architecture for managing complex navigation flows in iOS applications.

## Requirements

- iOS 16.0+
- Swift 5.10+
- Xcode 15.0+

## Installation

Add NavigationKit to your Swift Package Manager dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/dimzfresh/NavigationKit.git", from: "1.0.0")
]
```

## Architecture Overview

NavigationKit is built around a coordinator pattern that provides a clean separation of concerns between navigation logic and view presentation. The framework consists of several key components:

### Core Components

#### 1. Coordinator Protocol
The foundation of the navigation system. Every coordinator implements this protocol:

```swift
@MainActor
public protocol Coordinator: ObservableObject, CoordinatorFinishDelegate {
    associatedtype Content: View
    
    @MainActor @ViewBuilder var rootView: Content { get }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func finish()
}
```

#### 2. BaseCoordinator
Extends the basic coordinator with navigation capabilities:

```swift
@MainActor
public protocol BaseCoordinator: Coordinator {
    var childCoordinator: (any Coordinator)? { get set }
    var navigationRouters: [NavigationRouter] { get set }
}
```

#### 3. NavigationRouter
Manages the navigation stack and presentation state:

```swift
@MainActor
public final class NavigationRouter: ObservableObject {
    @Published var path: [NavigableView] = []
    @Published var presentedView: NavigableView?
}
```

#### 4. NavigableView
Represents a view that can be navigated to:

```swift
public struct NavigableView: Navigable {
    public let view: any View
    public let navigationType: NavigationType
}
```

### Navigation Types

NavigationKit supports multiple navigation patterns:

- **Push Navigation**: Standard stack-based navigation
- **Sheet Presentation**: Modal presentation with customizable detents
- **Full Screen Cover**: Full-screen modal presentation
- **Custom Presentation**: Custom presentation styles

```swift
public enum NavigationType: Equatable {
    case push
    case present(PresentationType)
}

public enum PresentationType: Equatable {
    case sheet(Set<PresentationDetent> = [])
    case fullScreen
    case custom
}
```

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    NavigationKit Architecture               │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────┐    ┌─────────────────┐               │
│  │   Coordinator   │    │ BaseCoordinator │               │
│  │   (Protocol)    │◄───┤   (Protocol)    │               │
│  └─────────────────┘    └─────────────────┘               │
│           │                       │                        │
│           │                       ▼                        │
│           │              ┌─────────────────┐               │
│           │              │NavigationRouter │               │
│           │              │   (Class)       │               │
│           │              └─────────────────┘               │
│           │                       │                        │
│           │                       ▼                        │
│           │              ┌─────────────────┐               │
│           │              │  NavigableView  │               │
│           │              │   (Struct)      │               │
│           │              └─────────────────┘               │
│           │                       │                        │
│           │                       ▼                        │
│           │              ┌─────────────────┐               │
│           │              │  NavigationType │               │
│           │              │   (Enum)        │               │
│           │              └─────────────────┘               │
│           │                       │                        │
│           │                       ▼                        │
│           │              ┌─────────────────┐               │
│           │              │PresentationType │               │
│           │              │   (Enum)        │               │
│           │              └─────────────────┘               │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│                    Deep Link Support                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────┐    ┌─────────────────┐               │
│  │   DeepLink      │    │DeepLinkCoordinator│              │
│  │  (Protocol)     │◄───┤   (Class)       │               │
│  └─────────────────┘    └─────────────────┘               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Usage Examples

### Basic Coordinator Setup

```swift
@MainActor
final class MainCoordinator: BaseCoordinator {
    @Published var childCoordinator: (any Coordinator)?
    @Published var navigationRouters: [NavigationRouter] = []
    
    var rootView: some View {
        NavigationStack(path: rootNavigationRouter.pathBinding) {
            HomeView()
                .navigationDestination(for: NavigableView.self) { navigableView in
                    navigableView.view
                }
        }
        .sheet(isPresented: shouldPresentChild(from: rootNavigationRouter)) {
            if let childCoordinator {
                childCoordinator.rootView
            }
        }
        .onAppear {
            setupNavigationRouter()
        }
    }
}
```

### Navigation Operations

```swift
// Push to a new view
let detailView = NavigableView(
    view: DetailView(),
    navigationType: .push
)
push(detailView)

// Present a sheet
let settingsView = NavigableView(
    view: SettingsView(),
    navigationType: .present(.sheet())
)
push(settingsView)

// Present full screen
let loginView = NavigableView(
    view: LoginView(),
    navigationType: .present(.fullScreen)
)
push(loginView)
```

### Deep Link Integration

```swift
struct ProductDeepLink: DeepLink {
    func canOpenURL(_ url: URL) -> Bool {
        return url.scheme == "myapp" && url.host == "product"
    }
    
    func openURL(_ url: URL) {
        // Handle product deep link
        let productId = url.queryParameters?["id"] ?? ""
        // Navigate to product detail
    }
}

let deepLinkCoordinator = DeepLinkCoordinator(deepLinks: [
    ProductDeepLink()
])

// Handle incoming URLs
func application(_ app: UIApplication, open url: URL) -> Bool {
    return deepLinkCoordinator.handleURL(url)
}
```

## Key Features

- **Coordinator Pattern**: Clean separation of navigation logic
- **Type-Safe Navigation**: Compile-time safety for navigation operations
- **Multiple Presentation Styles**: Support for push, sheet, and full-screen presentations
- **Deep Link Support**: Built-in deep link handling
- **SwiftUI Native**: Designed specifically for SwiftUI
- **iOS 16+ Support**: Leverages the latest SwiftUI features
- **MainActor Compliance**: Thread-safe navigation operations

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
