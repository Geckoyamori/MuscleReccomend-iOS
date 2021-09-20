//
//  TrainingRecordNote.swift
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
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            // ナビゲーションバーの設定
            .navigationBarTitle("筋トレ記録", displayMode: .inline)
        
    }
}

struct TrainingRecordNote_Previews: PreviewProvider {
    static var previews: some View {
        TrainingRecordNoteView(trainigRecordId: "", initialStrength: "")
    }
}
