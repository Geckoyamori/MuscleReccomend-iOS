//
//  TrainingRecordHistoryView.swift
//  MuscleRecommend
//
//  Created by 多喜和弘 on 2021/09/05.
//

import SwiftUI

// D-002:筋トレ履歴のビュー
struct TrainingRecordHistoryView: View {
    
    // 筋トレメニューid（画面間パラメータ）
    let trainingMenuId: String

    // 筋トレ記録のビューモデル
    @ObservedObject private var trainingRecordViewModel: TrainingRecordViewModel
 
    // 初回筋トレメニューViewのレイアウト
    private let INITIAL_DESCRIPTION = "初回の%@トレーニングを記録後に、\n次回以降の推奨メニューが表示されます。"
    private let INITIAL_COLOR = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 0.3034032534)
    // 推奨筋トレメニューViewのレイアウト
    private var recommendLayoutArray = [StrengthLayout(strength: "高強度", color: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.3043396832)), StrengthLayout(strength: "中強度", color: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 0.2987478596)), StrengthLayout(strength: "低強度", color: #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 0.3016641695))]
    
    init(trainingMenuId: String) {
        self.trainingMenuId = trainingMenuId
        
        // 筋トレ記録のビューモデル
        trainingRecordViewModel = TrainingRecordViewModel(trainingMenuId: trainingMenuId)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 20)
            // 筋トレメニューViewの生成
            ForEach(recommendLayoutArray, id: \.self) { strengthLayout in
                // 筋トレメニューView押下時に、D-003に遷移（引数：筋トレメニューid、筋トレ記録id、初回強度）
                NavigationLink(destination: NavigationLazyView(TrainingRecordNoteView(trainingMenuId: trainingMenuId, trainigRecordId: "", initialStrength: strengthLayout.strength))) {
                    // 筋トレ強度に紐づく筋トレ記録のリストを最新順で取得した結果より、表示する筋トレメニュービューを設定
                    if trainingRecordViewModel.sortTrainingRecordViewModel(strengthLayout: strengthLayout).isEmpty {
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
            Divider()
            // 筋トレ履歴Viewの作成
            ForEach(trainingRecordViewModel.trainingRecords, id: \.self) { trainingRecord in
                // 筋トレ履歴View押下時に、D-003に遷移（引数：筋トレメニューid、筋トレ記録id、初回強度）
                NavigationLink(destination: NavigationLazyView(TrainingRecordNoteView(trainingMenuId: trainingMenuId, trainigRecordId: trainingRecord.trainingRecordId, initialStrength: trainingRecord.trainingStrength))) {
                    TrainingRecordHistoryRow(trainingRecord: trainingRecord)
                }
            }
            Spacer()
        }
        
        // ナビゲーションバーの設定
        .navigationBarTitle("筋トレ記録履歴", displayMode: .inline)
    }
}

// 筋トレ履歴ビューの１行を表すView
struct TrainingRecordHistoryRow: View {
    
    // 筋トレ記録モデル
    var trainingRecord: TrainingRecordModel
    
    init(trainingRecord: TrainingRecordModel) {
        self.trainingRecord = trainingRecord
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Text("\(Date().toStringType(date: trainingRecord.createdDate))")
            Text("\(trainingRecord.trainingStrength)")
        }
    }
    
}

// 各強度のレイアウト定義
struct StrengthLayout: Hashable {
  
    // 筋トレ強度
    let strength: String
    // 推奨筋トレメニューViewの色
    let color: UIColor
    
}

struct TrainingRecordHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingRecordHistoryView(trainingMenuId: "previews")
    }
}
