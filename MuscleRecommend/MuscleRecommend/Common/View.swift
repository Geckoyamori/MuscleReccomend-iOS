//
//  View.swift
//  MuscleRecommend
//
//  Created by 多喜和弘 on 2021/09/20.
//

import Foundation
import SwiftUI

// NavigationLinkのdestinationにViewのinit()を設定すると、NavigationLinkを押下しないでも、Viewのinit()がコールされてしまう
// NavigationLink押下時のみ、Viewのinit()をコールするためには、当NavigationLazyViewを使用する
public struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    public var body: Content {
        build()
    }
}

