//
//  TrainingRecordNoteView.swift
//  MuscleRecommend
//
//  Created by 多喜和弘 on 2021/09/20.
//

import SwiftUI

// D-003:筋トレ記録のビュー
struct TrainingRecordNoteView: View {
    
    // 筋トレ負荷量のビューモデル
    @ObservedObject private var trainingLoadViewModel: TrainingLoadViewModel
    
    // 筋トレ記録Viewのレイアウト
    private let SET_TYPE = ["ウォームアップ", "メイン"]
    
    // 初回筋トレ記録Viewのレイアウト
    private let INITIAL_WARMUP_SET = 5
    private let INITIAL_MAIN_SET = 5
    
    init(trainigRecordId: String, initialStrength: String) {
        // 筋トレ負荷量のビューモデル
        trainingLoadViewModel = TrainingLoadViewModel(trainingRecordId: trainigRecordId)
        
    }
    
    var body: some View {
        

            List {
                Section(header: Text(SET_TYPE[0])) {
                    ForEach(1..<(INITIAL_WARMUP_SET + 1)) { index in
                        TrainingRecordNoteRow(index: index)
                    }
                }
                Section(header: Text(SET_TYPE[1])) {
                    ForEach(1..<(INITIAL_MAIN_SET + 1)) { index in
                        TrainingRecordNoteRow(index: index)
                    }
                }
            }
            .listStyle(GroupedListStyle())

        
        
        
        // ナビゲーションバーの設定
        .navigationBarTitle("筋トレ記録", displayMode: .inline)
        .navigationBarItems(
            trailing: Button(action: {
                addTrainingRecordNote()
            }) {
                Text("保存")
            })
    }
    
    // 筋トレ記録追加処理
    func addTrainingRecordNote() {
      
    }
}

// 筋トレ記録ビューの１行を表すView
struct TrainingRecordNoteRow: View {
    
    // 筋トレ負荷量の重量
    @State private var weight: String = String(0)
    // 筋トレ負荷量のレップ数
    @State private var rep: String = String(0)
    // セット目
    var index: Int
    
    var body: some View {
        HStack(spacing: 20) {
            Text("\(index)セット目")
            TextField("", text: $weight)
            Text("kg")
            Text("×")
            TextField("", text: $rep)
            Text("reps")
        }
    }
}

struct TrainingRecordNote_Previews: PreviewProvider {
    static var previews: some View {
        TrainingRecordNoteView(trainigRecordId: "", initialStrength: "")
    }
}
