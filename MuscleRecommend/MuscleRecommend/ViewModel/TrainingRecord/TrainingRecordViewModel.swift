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
    // 筋トレメニューidに紐づく筋トレ記録のリスト（作成日時が新しい順）の取得結果
    private var trainingRecordResults: Results<TrainingRecordModel>
    // 筋トレ記録の一覧取得結果を格納するViewModel
    @Published private(set) var trainingRecords: [TrainingRecordModel] = []
 
    private var notificationTokens: [NotificationToken] = []
    
    private let SET_TYPE = ["ウォームアップ", "メイン"]
    
    init(trainingMenuId: String) {
        // 筋トレメニューidに紐づく筋トレ記録のリスト（作成日時が新しい順）の取得
        trainingRecordResults = TrainingRecordModel().selectTrainingRecordList(trainingMenuId: trainingMenuId)
        // 筋トレ記録の一覧取得結果を格納するViewModelの初期化
        trainingRecords = Array(trainingRecordResults)
        
        // DBに変更があったタイミングで変数trainingMenusに値を再格納する
        notificationTokens.append(trainingRecordResults.observe { change in
            switch change {
            case let .initial(results):
                self.trainingRecords = Array(results)
            case let .update(results, deletions: _, insertions: _, modifications: _):
                self.trainingRecords = Array(results)
            case let .error(error):
                print(error.localizedDescription)
            }
        })
    }
    
    deinit {
        notificationTokens.forEach { $0.invalidate() }
    }
    
    // 筋トレ強度に紐づく筋トレ記録のリストを最新順で取得
    func sortTrainingRecordViewModel(strengthLayout: StrengthLayout) -> [TrainingRecordModel] {
        // 筋トレ強度に紐づく筋トレ記録のリストを取得
        var trainingRecordsByStrength = trainingRecords.filter { $0.trainingStrength == strengthLayout.strength }
        // 最新順に並び替え
        trainingRecordsByStrength.sort(by: { $0.createdDate > $1.createdDate })
        return trainingRecordsByStrength
    }
    
    // 筋トレ記録の追加
    func addTrainingRecord(trainingMenuId: String, initialStrength: String, trainingLoadModelList: [TrainingLoadModel]) -> String {
        // 追加する筋トレ記録の設定
        let trainingRecordModel = TrainingRecordModel()
        // 筋トレメニューid
        trainingRecordModel.trainingMenuId = trainingMenuId
        // 筋トレ強度
        trainingRecordModel.trainingStrength = initialStrength
        // ウォームアップ筋トレ総負荷量
        for trainingLoadModel in trainingLoadModelList.filter({ $0.trainingSetType == SET_TYPE[0] }) {
            trainingRecordModel.totalWarmUpTrainingLoad += trainingLoadModel.weight * Double(trainingLoadModel.rep)
        }
        // メイン筋トレ総負荷量
        for trainingLoadModel in trainingLoadModelList.filter({ $0.trainingSetType == SET_TYPE[1] }) {
            trainingRecordModel.totalMainTrainingLoad += trainingLoadModel.weight * Double(trainingLoadModel.rep)
        }
        
        // 筋トレ記録の追加
        TrainingRecordModel().insertTrainingRecordModel(trainingRecordModel: trainingRecordModel)
        
        // 新規追加した筋トレ記録の筋トレ記録idを返却
        return trainingRecordModel.trainingRecordId
    }
//
//    // 筋トレメニューの削除
//    func deleteTrainingMenu(trainingMenuModel: TrainingMenuModel) {
//        // 筋トレメニューの削除
//        TrainingMenuModel().deleteTrainingMenuModel(trainingMenuModel: trainingMenuModel)
//    }
}

