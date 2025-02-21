import Foundation

@MainActor
public protocol CoordinatorFinishDelegate: AnyObject {
    func didFinish(_ coordinator: any Coordinator)
}
