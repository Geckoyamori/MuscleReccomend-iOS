//
//  TrainingMenuModel.swift
//  MuscleRecommend
//
//  Created by 多喜和弘 on 2021/08/15.
//

import Foundation
import RealmSwift

// 筋トレメニューのモデル
class TrainingMenuModel: Object {
    
    // 筋トレメニューid
    @objc dynamic var trainingMenuId: String = NSUUID().uuidString
    // 筋トレメニュー名
    @objc dynamic var trainingMenuName: String = ""
    // 筋トレ部位
    @objc dynamic var trainingPart: String = ""
    // 作成日時
    @objc dynamic var createdDate: Date = Date().toJapaneseDeviceDate()
    // 更新日時
    @objc dynamic var updatedDate: Date = Date().toJapaneseDeviceDate()

    // 筋トレメニューidをプライマリーキーに設定
    override class func primaryKey() -> String? {
        return "trainingMenuId"
    }
    
}

extension TrainingMenuModel {

    // Realm
    private static let realm = try! Realm()

    // 一覧取得
    func selectTrainingMenuList() -> Results<TrainingMenuModel> {
        return TrainingMenuModel.realm.objects(TrainingMenuModel.self)
    }

    // 筋トレメニューを追加
    func insertTrainingMenuModel(trainingMenuModel: TrainingMenuModel) {
        try! TrainingMenuModel.realm.write {
            TrainingMenuModel.realm.add(trainingMenuModel)
        }
    }

    // 選択した筋トレメニューを削除
    func deleteTrainingMenuModel(trainingMenuModel: TrainingMenuModel) {
        try! TrainingMenuModel.realm.write {
            TrainingMenuModel.realm.delete(trainingMenuModel)
        }
    }

}
