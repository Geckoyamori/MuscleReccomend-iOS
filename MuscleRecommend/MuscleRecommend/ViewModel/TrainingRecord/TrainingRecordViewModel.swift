//
//  TrainingRecordViewModel.swift
//  MuscleRecommend
//
//  Created by 多喜和弘 on 2021/09/05.
//

import Foundation
import Combine
import RealmSwift

// 筋トレ記録のビューモデル
class TrainingRecordViewModel: ObservableObject {
    // 筋トレメニューidと筋トレ強度に紐づく筋トレ記録のリスト（作成日時が新しい順）の取得結果
    private var trainingMenuResults: Results<TrainingRecordModel>
    // 筋トレメニューの一覧取得結果を格納するViewModel
    @Published private(set) var trainingMenus: [TrainingRecordModel] = []
 
    private var notificationTokens: [NotificationToken] = []
    
    // D-001からのパラメータ
    // 筋トレメニューID
    let trainingMenuId: String = ""
    
    init(trainingMenuId: String) {
        trainingMenuResults = TrainingRecordModel().selectTrainingRecordList(trainingMenuId: trainingMenuId)
        
        // DBに変更があったタイミングで変数trainingMenusに値を再格納する
        notificationTokens.append(trainingMenuResults.observe { change in
            switch change {
            case let .initial(results):
                self.trainingMenus = Array(results)
            case let .update(results, deletions: _, insertions: _, modifications: _):
                self.trainingMenus = Array(results)
            case let .error(error):
                print(error.localizedDescription)
            }
        })

    }
    
    deinit {
        notificationTokens.forEach { $0.invalidate() }
    }
    
    func selectA(trainingMenuId: String) -> Results<TrainingRecordModel> {
        let a = TrainingRecordModel()
        return a.selectTrainingRecordList(trainingMenuId: trainingMenuId)
    }
    
//    // 筋トレメニューの追加
//    func addTrainingMenu(trainingMenuName: String) {
//        // 追加する筋トレメニューの設定
//        let trainingMenuModel = TrainingMenuModel()
//        trainingMenuModel.trainingMenuName = trainingMenuName
//
//        // 筋トレメニューの追加
//        TrainingMenuModel().insertTrainingMenuModel(trainingMenuModel: trainingMenuModel)
//    }
//
//    // 筋トレメニューの削除
//    func deleteTrainingMenu(trainingMenuModel: TrainingMenuModel) {
//        // 筋トレメニューの削除
//        TrainingMenuModel().deleteTrainingMenuModel(trainingMenuModel: trainingMenuModel)
//    }
}

