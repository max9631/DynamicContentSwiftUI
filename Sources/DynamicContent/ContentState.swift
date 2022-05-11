//
//  File.swift
//  
//
//  Created by Adam Salih on 09.05.2022.
//

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

public protocol ContentState {
    associatedtype ViewType: View

    @ViewBuilder
    func viewForState(or content: AnyView) -> ViewType
}
