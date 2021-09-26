//
//  UIApplication.swift
//  MuscleRecommend
//
//  Created by 多喜和弘 on 2021/09/26.
//

import Foundation
import SwiftUI

extension UIApplication {
    // キーボードを閉じる処理
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
