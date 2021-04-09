import UIKit
import SwiftUI


public enum ContentDefaultState: ContentState {
    case loading
    case error(message: String)
    case empty
    
    public var view: some View {
        switch self {
        case .loading:
            return Text("Loading")
        case let .error(message):
            return Text("Error \(message)")
        case .empty:
            return Text("Empty")
            
        }
    }
}

public enum ContentBaseState<ContentStateType: ContentState> {
    case content
    case other(state: ContentStateType)
}

public protocol ContentState {
    associatedtype ViewType: View
    var view: ViewType { get }
}

private enum ContentMode {
    case predefined
}

public struct DynamicContent<ContentStateType: ContentState, ContentViewType: View>: View {
    @Binding public var state: ContentBaseState<ContentStateType>
    
    private var contentView: () -> ContentViewType
    
//    private mode: ContentMode
    
    public var body: some View {
        switch state {
        case .content:
            return AnyView(contentView())
        case let .other(state):
            return AnyView(state.view)
        }
    }
}

//public extension DynamicContent where ContentStateType == ContentDefaultState {
//    init(stateBainding: ContentBaseState<ContentDefaultState>, contentView: @escaping (() -> ContentViewType)) {
//        self.init(state: stateBainding, contentView: contentView)
//    }
//}

public extension DynamicContent {
//    init(stateType: ContentStateType.Type, contentView: @escaping (() -> ContentViewType)) {
//        self.contentView = contentView
//    }
    
    init(stateBinding: Binding<ContentBaseState<ContentStateType>>, contentView: @escaping (() -> ContentViewType)) {
        self.init(state: stateBinding, contentView: contentView)
//        self.contentView = contentView
//        self.state = .other(state: initialState)
    }
}





