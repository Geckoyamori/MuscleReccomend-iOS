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
    // 追加する筋トレメニュー名
    @Published var addTrainingMenuName = ""
    // 削除する筋トレメニュー
    @Published var deleteTrainingMenuModel: TrainingMenuModel?
    
    private var addTrainingMenuTask: AnyCancellable?
    private var deleteTrainingMenuTask: AnyCancellable?
    
    init() {
        
        addTrainingMenuTask = self.$addTrainingMenuName
            .sink(receiveValue: {
                addTrainingMenuName in
                // init()内の処理のでため、アプリ起動時にも「trainingMenuName=""」として呼ばれる
                if addTrainingMenuName.isEmpty { return }
                
                // 追加する筋トレメニューの設定
                let trainingMenuModel = TrainingMenuModel()
                trainingMenuModel.trainingMenuName = addTrainingMenuName
                
                // 筋トレメニューの追加
                self.trainingMenus.append(trainingMenuModel)
                TrainingMenuModel().insertTrainingMenuModel(trainingMenuModel: trainingMenuModel)
            })
        
        deleteTrainingMenuTask = self.$deleteTrainingMenuModel
            .sink(receiveValue: {
                deleteTrainingMenuModel in
                if let deleteTrainingMenuModel = deleteTrainingMenuModel {
                    TrainingMenuModel().deleteTrainingMenuModel(trainingMenuModel: deleteTrainingMenuModel)
                }
            })


    }
}
