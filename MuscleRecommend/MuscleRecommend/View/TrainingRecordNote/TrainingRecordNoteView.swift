//
//  TrainingRecordNoteView.swift
//  MuscleRecommend
//
//  Created by 多喜和弘 on 2021/09/20.
//

import SwiftUI

// D-003:筋トレ記録のビュー
struct TrainingRecordNoteView: View {
    
    // 前画面へ戻るために必要な変数
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    // 筋トレメニューid（画面間パラメータ）
    let trainingMenuId: String
    // 筋トレ記録id（画面間パラメータ）
    let trainigRecordId: String
    // 筋トレ強度（画面間パラメータ）
    let initialStrength: String
    
    // 筋トレ負荷量のビューモデル
    @ObservedObject private var trainingLoadViewModel: TrainingLoadViewModel
    
    // 画面から入力された筋トレ負荷量を保持しておくリスト
    @State private var warmupTrainingLoadModelList: [TrainingLoadModel] = []
    @State private var mainTrainingLoadModelList: [TrainingLoadModel] = []
    
    // 筋トレ記録Viewのレイアウト
    private let SET_TYPE = ["ウォームアップ", "メイン"]
    
    // 初回筋トレ記録Viewのレイアウト
    private let INITIAL_WARMUP_SET = 5
    private let INITIAL_MAIN_SET = 5
    
    init(trainingMenuId: String, trainigRecordId: String, initialStrength: String) {
        self.trainingMenuId = trainingMenuId
        self.trainigRecordId = trainigRecordId
        self.initialStrength = initialStrength
        
        // 筋トレ負荷量のビューモデル
        trainingLoadViewModel = TrainingLoadViewModel(trainingRecordId: trainigRecordId)
        
    }
    
    var body: some View {
        
        
        List {
            Section(header: Text(SET_TYPE[0])) {
                ForEach(1..<(INITIAL_WARMUP_SET + 1)) { index in
                    TrainingRecordNoteRow(trainingLoadModelList: $warmupTrainingLoadModelList, index: index, trainingSetType: SET_TYPE[0], trainigRecordId: trainigRecordId)
                }
            }
            Section(header: Text(SET_TYPE[1])) {
                ForEach(1..<(INITIAL_MAIN_SET + 1)) { index in
                    TrainingRecordNoteRow(trainingLoadModelList: $mainTrainingLoadModelList, index: index, trainingSetType: SET_TYPE[1], trainigRecordId: trainigRecordId)
                }
            }
        }
        .listStyle(GroupedListStyle())
        
        
        
        
        // ナビゲーションバーの設定
        .navigationBarTitle("筋トレ記録", displayMode: .inline)
        .navigationBarItems(
            trailing: Button(action: {
                saveTrainingRecordNote(warmupTrainingLoadModelList: self.warmupTrainingLoadModelList, mainTrainingLoadModelList: self.mainTrainingLoadModelList)
            }) {
                Text("保存")
            })
        // Viewの背景押下時にキーボードを閉じる処理
        .gesture(TapGesture().onEnded { _ in
            UIApplication.shared.closeKeyboard()
        })
    }
    
    // 筋トレ記録保存処理
    func saveTrainingRecordNote(warmupTrainingLoadModelList: [TrainingLoadModel], mainTrainingLoadModelList: [TrainingLoadModel]) {
        // 重量と回数が0ではない負荷量データを抽出して、格納するためのリスト
        var extractTrainingLoadModelList: [TrainingLoadModel] = []
        // 重量と回数が0ではない負荷量データを抽出
        for trainingLoadModel in warmupTrainingLoadModelList + mainTrainingLoadModelList {
            if trainingLoadModel.weight != 0 && trainingLoadModel.rep != 0 {
                extractTrainingLoadModelList.append(trainingLoadModel)
            }
        }
        
        // ウォームアップ、メイン含む筋トレ記録を保存して、保存した筋トレ記録の筋トレ記録idを取得
        let trainingRecordId = TrainingRecordViewModel(trainingMenuId: trainingMenuId).addTrainingRecord(trainingMenuId: self.trainingMenuId, initialStrength: self.initialStrength, trainingLoadModelList: extractTrainingLoadModelList)
        
        // ウォームアップ、メインの負荷量を保存
        trainingLoadViewModel.insertTrainingLoadData(trainingRecordId: trainingRecordId, trainingLoadModelList: extractTrainingLoadModelList)
        
        // 前画面に戻る
        self.presentationMode.wrappedValue.dismiss()
    }
}

// 筋トレ記録ビューの１行を表すView
struct TrainingRecordNoteRow: View {
    // 筋トレ記録ビュー内の筋トレ負荷量のリスト
    @Binding private var trainingLoadModelList: [TrainingLoadModel]
    // セット目
    var index: Int
    // 筋トレセット種類
    var trainingSetType: String
    // 筋トレ記録id
    var trainigRecordId: String
    
    // 筋トレ負荷量の重量
    @State private var weight: String = ""
    // 筋トレ負荷量のレップ数
    @State private var rep: String = ""
    
    init(trainingLoadModelList: Binding<[TrainingLoadModel]>, index: Int, trainingSetType: String, trainigRecordId: String) {
        self._trainingLoadModelList = trainingLoadModelList
        self.index = index
        self.trainingSetType = trainingSetType
        self.trainigRecordId = trainigRecordId
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Text("\(index)セット目")
            TextField("", text: $weight, onEditingChanged: { isBegin in
                if isBegin {
                    // 入力開始時の処理
                } else {
                    // 入力終了時の処理
                    inputRecordNote()
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.decimalPad)
            Text("kg")
            Text("×")
            TextField("", text: $rep, onEditingChanged: { isBegin in
                if isBegin {
                    // 入力開始時の処理
                } else {
                    // 入力終了時の処理
                    inputRecordNote()
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.decimalPad)
            Text("reps")
        }
    }
    
    // 入力した重量と回数などの負荷量データをDB登録用のリストに格納する
    func inputRecordNote() {
        
        if trainingLoadModelList.filter({ $0.noOfSet == index }).isEmpty {
            // 該当行の筋トレ負荷量がまだリストにinsertされてない場合、筋トレ負荷量モデルを作成してinsertする
            let trainingLoadModel = TrainingLoadModel()
            trainingLoadModel.noOfSet = index
            trainingLoadModel.trainingSetType = trainingSetType
            trainingLoadModel.trainingRecordId = trainigRecordId
            trainingLoadModel.weight = Double(weight) ?? 0
            trainingLoadModel.rep = Int(rep) ?? 0
            self.trainingLoadModelList.append(trainingLoadModel)
        } else {
            // 該当行の筋トレ負荷量がすでにリストにinsertされている場合、筋トレ負荷量モデルの重量と回数をupdateする
            self.trainingLoadModelList.filter({ $0.noOfSet == index })[0].weight = Double(weight) ?? 0
            self.trainingLoadModelList.filter({ $0.noOfSet == index })[0].rep = Int(rep) ?? 0
        }
    }
    
}

struct TrainingRecordNote_Previews: PreviewProvider {
    static var previews: some View {
        TrainingRecordNoteView(trainingMenuId: "", trainigRecordId: "", initialStrength: "")
    }
}
