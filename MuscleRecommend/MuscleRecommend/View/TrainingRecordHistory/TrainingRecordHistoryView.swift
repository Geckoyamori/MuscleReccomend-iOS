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
    private let RECOMMEND_LAYOUT_ARRAY = [StrengthLayout(strength: "高強度", color: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.3043396832)), StrengthLayout(strength: "中強度", color: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 0.2987478596)), StrengthLayout(strength: "低強度", color: #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 0.3016641695))]
    // 推奨筋トレメニューViewの表示フラグ
    @State private var isRecommendedHighStrengthMenuPresented = false
    
    init(trainingMenuId: String) {
        trainingRecordViewModel = TrainingRecordViewModel(trainingMenuId: trainingMenuId)
        print("@@@@@@@@@@@@@@@@@@@@@")
        print(trainingRecordViewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 筋トレメニューViewの生成
                ForEach(RECOMMEND_LAYOUT_ARRAY, id: \.self) { strengthLayout in
                    ZStack {
                        // 初回筋トレメニューViewの生成
                        HStack {
                            Spacer().frame(width: 20)
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(INITIAL_COLOR))
                                .frame(height: 100)
                            Spacer().frame(width: 20)
                        }.overlay( Text(String(format: NSLocalizedString(INITIAL_DESCRIPTION, comment: ""), strengthLayout.strength)))
                        // 推奨筋トレメニューViewの生成
                        HStack {
                            Spacer().frame(width: 20)
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(strengthLayout.color))
                                .frame(height: 100)
                            Spacer().frame(width: 20)
                        }.overlay( Text(String(format: NSLocalizedString(INITIAL_DESCRIPTION, comment: ""), strengthLayout.strength)))
                    }
                }
            }
        }
    }
}

// 各強度のレイアウト定義
struct StrengthLayout: Hashable {
    let strength: String
    let color: UIColor
}

struct TrainingRecordHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingRecordHistoryView(trainingMenuId: "previews")
    }
}
