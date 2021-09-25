//
//  TrainingRecordNoteView.swift
//  MuscleRecommend
//
//  Created by 多喜和弘 on 2021/09/20.
//

import SwiftUI

// D-003:筋トレ記録のビュー
struct TrainingRecordNoteView: View {
    
    init(trainigRecordId: String, initialStrength: String) {
        
    }
    
    var body: some View {
        Text("::")
//        VSstack {
//            List {
//                // 筋トレメニューidを識別IDとしてリストを作成
//                ForEach(trainingMenuViewModel.trainingMenus, id: \.trainingMenuId) { trainingMenuModel in
//                    // 筋トレメニュー押下時に、D-002に遷移（引数：筋トレメニューID）
//                    NavigationLink(destination: NavigationLazyView(TrainingRecordHistoryView(trainingMenuId: trainingMenuModel.trainingMenuId))) {
//                        Text(trainingMenuModel.trainingMenuName)
//                    }
//                }
//            }
//            .listStyle(PlainListStyle())
//        }
        
        
        
//        // ナビゲーションバーの設定
//        .navigationBarTitle("筋トレ記録", displayMode: .inline)
        
    }
}

struct TrainingRecordNote_Previews: PreviewProvider {
    static var previews: some View {
        TrainingRecordNoteView(trainigRecordId: "", initialStrength: "")
    }
}
