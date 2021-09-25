//
//  TrainingLoadViewModel.swift
//  MuscleRecommend
//
//  Created by 多喜和弘 on 2021/09/25.
//

import Foundation
import Combine
import RealmSwift

// 筋トレ負荷量のビューモデル
class TrainingLoadViewModel: ObservableObject {
    // 筋トレ記録idに紐づく筋トレ負荷量のリスト（作成日時が古い順）の取得結果
    private var trainingLoadResults: Results<TrainingLoadModel>
    // 筋トレ負荷量の一覧取得結果を格納するViewModel
    @Published private(set) var trainingLoads: [TrainingLoadModel] = []
 
    private var notificationTokens: [NotificationToken] = []
    
    init(trainingRecordId: String) {
        // 筋トレ記録idに紐づく筋トレ負荷量のリスト（作成日時が古い順）の取得
        trainingLoadResults = TrainingLoadModel().selectTrainingLoadList(trainingRecordId: trainingRecordId)
        // 筋トレメニューの一覧取得結果を格納するViewModelの初期化
        trainingLoads = Array(trainingLoadResults)
        
        // DBに変更があったタイミングで変数trainingMenusに値を再格納する
        notificationTokens.append(trainingLoadResults.observe { change in
            switch change {
            case let .initial(results):
                self.trainingLoads = Array(results)
            case let .update(results, deletions: _, insertions: _, modifications: _):
                self.trainingLoads = Array(results)
            case let .error(error):
                print(error.localizedDescription)
            }
        })
    }
    
    deinit {
        notificationTokens.forEach { $0.invalidate() }
    }
    
//    // 筋トレ強度に紐づく筋トレ記録のリストを最新順で取得
//    func sortTrainingRecordViewModel(strengthLayout: StrengthLayout) -> [TrainingRecordModel] {
//        // 筋トレ強度に紐づく筋トレ記録のリストを取得
//        var trainingMenusByStrength = trainingMenus.filter { $0.trainingStrength == strengthLayout.strength }
//        // 最新順に並び替え
//        trainingMenusByStrength.sort(by: { $0.createdDate > $1.createdDate })
//        return trainingMenusByStrength
//    }
    
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

