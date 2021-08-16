//
//  TrainingMenuViewModel.swift
//  MuscleRecommend
//
//  Created by 多喜和弘 on 2021/08/15.
//

import Foundation
import Combine
import RealmSwift

// 筋トレメニューのビューモデル
class TrainingMenuViewModel: ObservableObject {
    // 筋トレメニューの一覧取得結果
    @Published private(set) var trainingMenus: [TrainingMenuModel] = Array(TrainingMenuModel().selectTrainingMenuList())
    // 筋トレメニュー名
    @Published var trainingMenuName = ""
    
    private var addTrainingMenuTask: AnyCancellable?
    
    init() {
        
        addTrainingMenuTask = self.$trainingMenuName
            .sink(receiveValue: {
                trainingMenuName in
                // init()内の処理のでため、アプリ起動時にも「trainingMenuName=""」として呼ばれる
                if trainingMenuName.isEmpty { return }
                
                // 追加する筋トレメニューの設定
                let trainingMenuModel = TrainingMenuModel()
                trainingMenuModel.trainingMenuName = trainingMenuName
                
                // 筋トレメニューの追加
                self.trainingMenus.append(trainingMenuModel)
                TrainingMenuModel().insertTrainingMenuModel(trainingMenuModel: trainingMenuModel)
            })

    }
}
