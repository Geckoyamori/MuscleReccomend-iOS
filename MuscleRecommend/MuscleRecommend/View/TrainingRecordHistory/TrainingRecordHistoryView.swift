//
//  TrainingRecordHistoryView.swift
//  MuscleRecommend
//
//  Created by 多喜和弘 on 2021/09/05.
//

import SwiftUI

// D-002:筋トレ履歴のビュー
struct TrainingRecordHistoryView: View {
    
    // D-001からのパラメータ
    // 筋トレメニューID
    let trainingMenuId: String
    
    var body: some View {
        Text(trainingMenuId)
    }
}

struct TrainingRecordHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingRecordHistoryView(trainingMenuId: "previews")
    }
}
