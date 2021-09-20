//
//  TrainingRecordHistoryView.swift
//  MuscleRecommend
//
//  Created by 多喜和弘 on 2021/09/05.
//

import SwiftUI

// D-002:筋トレ履歴のビュー
struct TrainingRecordHistoryView: View {

    // 筋トレ記録のビューモデル
    @ObservedObject private var trainingRecordViewModel: TrainingRecordViewModel
 
    // 初回筋トレメニューViewのレイアウト
    private let INITIAL_DESCRIPTION = "初回の%@トレーニングを記録後に、\n次回以降の推奨メニューが表示されます。"
    private let INITIAL_COLOR = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 0.3034032534)
    // 推奨筋トレメニューViewのレイアウト
    private var recommendLayoutArray = [StrengthLayout(strength: "高強度", color: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.3043396832)), StrengthLayout(strength: "中強度", color: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 0.2987478596)), StrengthLayout(strength: "低強度", color: #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 0.3016641695))]
    
    init(trainingMenuId: String) {
        // 筋トレ記録のビューモデル
        trainingRecordViewModel = TrainingRecordViewModel(trainingMenuId: trainingMenuId)
      
        // 各強度のレイアウト定義に初回フラグを設定
        for (index, strengthLayout) in recommendLayoutArray.enumerated() {
            // 筋トレ強度に紐づく筋トレ記録のリストを最新順で取得
            let trainingMenusByStrength = trainingRecordViewModel.sortTrainingRecordViewModel(strengthLayout: strengthLayout)
            // 取得した筋トレ記録のリストから初回フラグを決定
            recommendLayoutArray[index].setInitialFlag(initialFlag: trainingMenusByStrength.isEmpty)
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // 筋トレメニューViewの生成
            ForEach(recommendLayoutArray, id: \.self) { strengthLayout in
                NavigationLink(destination: NavigationLazyView(TrainingRecordNoteView(trainigRecordId: "", initialStrength: strengthLayout.strength))) {
                    // 各強度のレイアウト定義の初回フラグより、表示する筋トレメニュービューを設定
                    if strengthLayout.initialFlag {
                        // 初回筋トレメニューViewの生成
                        HStack {
                            Spacer().frame(width: 20)
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(INITIAL_COLOR))
                                .frame(height: 100)
                            Spacer().frame(width: 20)
                        }.overlay(Text(String(format: NSLocalizedString(INITIAL_DESCRIPTION, comment: ""), strengthLayout.strength)).foregroundColor(.primary))
                    } else {
                        // 推奨筋トレメニューViewの生成
                        HStack {
                            Spacer().frame(width: 20)
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(strengthLayout.color))
                                .frame(height: 100)
                            Spacer().frame(width: 20)
                        }
                    }
                }
            }
        }
        
        // ナビゲーションバーの設定
        .navigationBarTitle("筋トレ記録履歴", displayMode: .inline)
    }
}

// 各強度のレイアウト定義
struct StrengthLayout: Hashable {
  
    // 筋トレ強度
    let strength: String
    // 推奨筋トレメニューViewの色
    let color: UIColor
    // 初回フラグ（対象筋トレ強度の筋トレメニューが未実施であればtrue）
    var initialFlag: Bool = true
    
    // structであるため、mutatingをつけてプロパティの変更を可能とするメソッドを定義
    mutating func setInitialFlag(initialFlag: Bool) {
        self.initialFlag = initialFlag
    }
    
}

struct TrainingRecordHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingRecordHistoryView(trainingMenuId: "previews")
    }
}
