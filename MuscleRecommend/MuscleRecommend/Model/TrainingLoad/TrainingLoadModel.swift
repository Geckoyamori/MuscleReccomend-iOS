//
//  TrainingLoadModel.swift
//  MuscleRecommend
//
//  Created by 多喜和弘 on 2021/09/25.
//

import Foundation
import RealmSwift

// T-003:筋トレ負荷量のモデル
class TrainingLoadModel: Object {
    
    // 筋トレ負荷量id
    @objc dynamic var trainingLoadId: String = NSUUID().uuidString
    // 筋トレ記録id
    @objc dynamic var trainingRecordId: String = NSUUID().uuidString
    // 筋トレセット種類
    @objc dynamic var trainingSetType: String = ""
    // セット
    @objc dynamic var noOfSet: Int = 0
    // 重量
    @objc dynamic var weight: Double = 0
    // 回数
    @objc dynamic var rep: Int = 0
    // 作成日時
    @objc dynamic var createdDate: Date = Date().toJapaneseDeviceDate()
    // 更新日時
    @objc dynamic var updatedDate: Date = Date().toJapaneseDeviceDate()
    
    // 筋トレ負荷量idをプライマリーキーに設定
    override class func primaryKey() -> String? {
        return "trainingLoadId"
    }

}

extension TrainingLoadModel {
    
    // Realm
    private static let realm = try! Realm()
    
    // 筋トレ記録idに紐づく筋トレ負荷量リストを取得
    func selectTrainingLoadList(trainingRecordId: String) -> Results<TrainingLoadModel> {
        return TrainingLoadModel.realm.objects(TrainingLoadModel.self).filter("trainingRecordId == '\(trainingRecordId)'").sorted(byKeyPath: "noOfSet", ascending: true)
    }
        
    // 入力した負荷量データを追加
    func insertTrainingLoadData(trainingLoadModel: TrainingLoadModel) {
        try! TrainingLoadModel.realm.write {
            TrainingLoadModel.realm.add(trainingLoadModel)
        }
    }
    
}
