//
//  BotomSheet.swift
//  MeteoritesSwiftUI
//
//  Created by Adam Salih on 28.04.2021.
//

import UIKit
import SwiftUI

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
