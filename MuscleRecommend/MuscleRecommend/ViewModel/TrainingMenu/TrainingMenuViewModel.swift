//
//  TrainingMenuViewModel.swift
//  MuscleRecommend
//
//  Created by 多喜和弘 on 2021/08/15.
//

import Foundation

// 筋トレメニューのビューモデル
class TrainingMenuViewModel: ObservableObject {
    // 筋トレメニューの一覧取得結果
    @Published private(set) var trainingMenus: [TrainingMenuModel] = Array(TrainingMenuModel().selectTrainingMenuList())
    
    // 筋トレメニューを追加
    func insertTrainingMenuModel(trainingMenuName: String) {
        // 追加する筋トレメニューの設定
        let trainingMenuModel = TrainingMenuModel()
        trainingMenuModel.trainingMenuName = trainingMenuName
        // 筋トレメニューの追加
        
    }
}
