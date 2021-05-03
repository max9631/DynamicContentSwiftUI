import UIKit
import SwiftUI


public enum ContentDefaultState: ContentState {
    case content
    case loading
    case error(message: String)
    case empty
    
    public func viewForState(or content: AnyView) -> some View {
        switch self {
        case .content:
            content
        case .loading:
            Text("Loading")
        case let .error(message):
            Text("Error \(message)")
        case .empty:
            Text("Empty")
            
        }
    }
}

public enum ContentBaseState<ContentStateType: ContentState> {
    case content
    case other(state: ContentStateType)
}

public protocol ContentState {
    associatedtype ViewType: View
    
    @ViewBuilder
    func viewForState(or content: AnyView) -> ViewType
}

private enum ContentMode {
    case predefined
}

public struct DynamicContent<ContentStateType: ContentState, ContentViewType: View>: View {
    @Binding public var state: ContentStateType
    
    private var contentView: () -> ContentViewType
    
    public var body: some View {
        state.viewForState(or: AnyView(self.contentView()))
    }
}

public extension DynamicContent {
    init(stateBinding: Binding<ContentStateType>, contentView: @escaping (() -> ContentViewType)) {
        self.init(state: stateBinding, contentView: contentView)
    }
}
