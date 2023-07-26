//
//  ViewController.swift
//  volleyBallCount
//
//  Created by 郭家宇 on 2023/7/26.
//

import UIKit

class ViewController: UIViewController {
    // 顯示隊伍名稱
    @IBOutlet weak var NameA: UITextField!
    @IBOutlet weak var NameB: UITextField!
    // 顯示分數
    @IBOutlet weak var ScoreA: UILabel!
    @IBOutlet weak var ScoreB: UILabel!
    //顯示獲勝局數
    @IBOutlet weak var RoundA: UILabel!
    @IBOutlet weak var RoundB: UILabel!
    //顯示發球權提示
    @IBOutlet weak var leftBall: UIImageView!
    @IBOutlet weak var rightBall: UIImageView!
    
    @IBOutlet weak var chooseButton: UIButton!
    //宣告一個 Array 用以記錄發球順序
    var records = [String]()
    
    func uiSet(){
        ScoreA.layer.cornerRadius = 25
        ScoreB.layer.cornerRadius = 25
        RoundA.layer.cornerRadius = 15
        RoundB.layer.cornerRadius = 15
        NameA.layer.cornerRadius = 10
        NameB.layer.cornerRadius = 10
        leftBall.isHidden = true
        rightBall.isHidden = true
        
        ScoreA.layer.borderWidth = 2
        ScoreA.layer.backgroundColor = UIColor.white.cgColor
 
        ScoreB.layer.borderWidth = 2
        ScoreB.layer.backgroundColor = UIColor.white.cgColor

        NameA.layer.borderWidth = 2
        NameA.layer.backgroundColor = UIColor.white.cgColor
        NameB.layer.borderWidth = 2
        NameB.layer.backgroundColor = UIColor.white.cgColor
        RoundA.layer.borderWidth = 2
        RoundA.layer.backgroundColor = UIColor.white.cgColor

        RoundB.layer.borderWidth = 2
        RoundB.layer.backgroundColor = UIColor.white.cgColor
    }
    func resetGAME(){
        ScoreA.text = "0"
        ScoreB.text = "0"
        RoundA.text = "0"
        RoundB.text = "0"
        NameA.text = "TeamA"
        NameB.text = "TeamB"
        records.removeAll()
        chooseButton.isHidden = false
        leftBall.isHidden = true
        rightBall.isHidden = true
    }
    func newGame(){
        ScoreA.text = "0"
        ScoreB.text = "0"
        NameA.text = NameA.self.text
        NameB.text = NameB.self.text
        records.removeAll()
        chooseButton.isHidden = false
        leftBall.isHidden = true
        rightBall.isHidden = true
    }
    
    func changeServer() {
        if leftBall.isHidden == false {
            leftBall.isHidden = true
            rightBall.isHidden = false
        }
        else if rightBall.isHidden == false {
            leftBall.isHidden = false
            rightBall.isHidden = true
        }
    }
    
    func changeHistory() {
        for i in records.indices {
            if records[i] == "A" {
                records[i] = "B"
            }
            else if records[i] == "B" {
                records[i] = "A"
            }
        }
    }
    
    //將隊伍名字、局數、分數、發球順序、發球權 換邊
    func changeSide() {
        let name = NameA.text
        NameA.text = NameB.text
        NameB.text = name
        
        let score = ScoreA.text
        ScoreA.text = ScoreB.text
        ScoreB.text = score
        
        let round = RoundA.text
        RoundA.text = RoundB.text
        RoundB.text = round
        changeHistory()
        changeServer()
    }
    //彈出獲勝視窗並提醒交換場地
    func scoreAlert() {
        let controller = UIAlertController(title: "恭喜獲得單局勝利！", message: "請雙方互換場地。", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "繼續", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true)
        //跳出視窗後運行 newGame function 開新局 (局數不會重置)
        newGame()
    }//彈出三戰兩勝獲勝晉級視窗
    func roundAlert() {
        let controller = UIAlertController(title: "恭喜勝利三局。", message: "Congratulations🏆", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "重新開始", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true)
        //跳出三戰兩勝獲勝視窗後，運行 resetGame function 重置所有資料
        resetGAME()
    }
    //檢查 TeamA round 是否有達到三戰兩勝的賽末點
    func checkRoundForTeamA() {
        //宣告2個常數將 String 轉為 Int 以利比較判斷
        let introundA = Int(RoundA.text!) ?? 0
        let introundB = Int(RoundB.text!) ?? 0
        //一般來說排球賽制以三戰二勝為主，因此當 TeamA 局數等於 0 且 TeamB 局數小於 2 時，TeamA 局數 +1 且 changeSide 並 執行 newGame
        if introundA == 0 && introundB < 2 {
            scoreAlert()
            let leftRound = Int(RoundA.text!) ?? 0
            let roundA = leftRound + 1
            RoundA.text = String(roundA)
            changeSide()
        //當 TeamA 局數等於 1 時，局數再 +1 便以三戰二勝勝出晉級，因此會跳出 roundAlert 視窗並執行 resetGame
        } else if introundA == 1 && introundB < 2 {
            let leftRound = Int(RoundA.text!) ?? 0
            let roundA = leftRound + 1
            RoundA.text = String(roundA)
            roundAlert()
        }
    }
    //檢查 TeamB round 是否有達到三戰兩勝的賽末點
    func checkRoundForTeamB() {
        //宣告2個常數將 String 轉為 Int 以利比較判斷
        let introundA = Int(RoundA.text!) ?? 0
        let introundB = Int(RoundB.text!) ?? 0
        //一般來說排球賽制以三戰二勝為主，因此當 TeamB 局數等於 0 且 TeamA 局數小於 2 時，TeamB 局數 +1 且 changeSide 並 執行 newGame
        if introundB == 0 && introundA < 2 {
            scoreAlert()
            let rightRound = Int(RoundB.text!) ?? 0
            let roundB = rightRound + 1
            RoundB.text = String(roundB)
            changeSide()
        //當 TeamB 局數等於 1 時，局數再 +1 便以三戰二勝勝出晉級，因此會跳出 roundAlert 視窗並執行 resetGame
        } else if introundB == 1 && introundA < 2 {
            let rightRound = Int(RoundB.text!) ?? 0
            let roundB = rightRound + 1
            RoundB.text = String(roundB)
            roundAlert()
        }
    }
    
    //檢查單局是否獲勝
    func checkWin() {
        //宣告2個常數將 String 轉為 Int 以利比較判斷
        let intscoreA = Int(ScoreA.text!) ?? 0
        let intscoreB = Int(ScoreB.text!) ?? 0
        //判斷 Team A 是否獲勝，依照排球規則先取得 25 分為且領先對手 2 分時獲勝
        if intscoreA == 25 && intscoreB <= 23 {
            checkRoundForTeamA()
        }
        //判斷 Team A 在 Duce（分數在 24 : 24 ） 的情況下需連得兩分才可獲勝，當 TeamA 分數減 2 等於 TeamB 分數時，即為 A 隊獲勝
        else if intscoreA > 25 && intscoreA - 2 == intscoreB{
            checkRoundForTeamA()
        }
        //判斷 Team B 在 Duce（分數在 24 : 24 ） 的情況下需連得兩分才可獲勝，當 TeamB 分數減 2 等於 TeamA 分數時，即為 B 隊獲勝
        else if intscoreB == 25 && intscoreA <= 23 {
            checkRoundForTeamB()
        }
        //判斷 Team B 在 Duce 的情況下需連得兩分才可獲勝
        else if intscoreB > 25 && intscoreB - 2 == intscoreA{
            checkRoundForTeamB()
        }
    }
    //建立使用資訊的 function，用於 info button，點選 button 後會跳 Alert 視窗供使用者參閱訊息
    func info() {
        let controller = UIAlertController(title: "Infomation", message: "\n點選 Team A 及 Team B 可輸入變更隊名\n\n請先點選 Choose Server 選擇發球方\n\nChange Side：兩隊資訊互換\n\nReduce Score：回上一動\n\nReset：重置所有隊伍名稱、分數、局數", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "我瞭解了", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true)
    }
    
    // viewDidLoad 中進行重置資料、隱藏兩邊的球權圖示提醒
    override func viewDidLoad() {
        resetGAME()
        leftBall.isHidden = true
        rightBall.isHidden = true
        uiSet()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func ScoreATap(_ sender: Any) {
        let leftScore = Int(ScoreA.text!) ?? 0
        let scoreA = leftScore + 1
        ScoreA.text = String(scoreA)
        leftBall.isHidden = false
        rightBall.isHidden = true
        checkWin()
        records.append("A")
        print(records)
    }
    
    @IBAction func ScoreBTap(_ sender: Any) {
        let rightScore = Int(ScoreB.text!) ?? 0
        let scoreB = rightScore + 1
        ScoreB.text = String(scoreB)
        leftBall.isHidden = true
        rightBall.isHidden = false
        checkWin()
        //同時每點一下 History Array 都會記錄一筆 String 為 "B" 的資料，以作為後續球權變更的依據
        records.append("B")
        //這邊取出 Array 值僅是要確認球權是否有正確增加
        print(records)
    }
    
    @IBAction func chooseServer(_ sender: Any) {
        let nameA = String(NameA.text!)
        let nameB = String(NameB.text!)
        //以 actionSheet 的方式呈現
        let controller = UIAlertController(title: "請選擇發球方", message: "", preferredStyle: .actionSheet)
        //由 TeamA 優先發球的選項內容
        let leftServerAction = UIAlertAction(title: "由 \(nameA) 先發球", style: .default) { _ in
            //不隱藏 TeamA 的球權圖示提醒
            self.leftBall.isHidden = false
            //隱藏 TeamB 的球權圖示提醒
            self.rightBall.isHidden = true
            //此按鈕一場只會使用一次，因此選取完後讓此 button 隱藏
            self.chooseButton.isHidden = true
        }
        //新增 TeamA 優先發球的選項至 actionSheet 上
        controller.addAction(leftServerAction)
        //由 TeamB 優先發球的選項內容
        let rightServerAction = UIAlertAction(title: "由 \(nameB) 先發球", style: .default) { _ in
            //隱藏 TeamA 的球權圖示提醒
            self.leftBall.isHidden = true
            //隱藏 TeamB 的球權圖示提醒
            self.rightBall.isHidden = false
            //此按鈕一場只會使用一次，因此選取完後讓此 button 隱藏
            self.chooseButton.isHidden = true
        }
        //新增 TeamB 優先發球的選項至 actionSheet 上
        controller.addAction(rightServerAction)
        present(controller, animated: true)
        
    }
    @IBAction func reduce(_ sender: Any) {
        //宣告2個變數將 String 轉為 Int 以利比較判斷
        var leftScore = Int(ScoreA.text!) ?? 0
        var rightScore = Int(ScoreB.text!) ?? 0
        //球權 Array 最後一筆資料若為 "A" 則代表 TeamA 剛加分，因此獲得球權
        if records.last == "A" && leftScore > 0 {
            //因此要將 TeamA 分數減 1
            leftScore = leftScore - 1
            ScoreA.text = String(leftScore)
            //同時要將 Array 最後一筆資料移除
            records.removeLast()
            //這邊取出 Array 值僅是要確認球權是否有正確移除
            print(records)
            //除了考慮到 Array 外還要將球權圖示提醒同步變換
            if  records.last == "A"{
                leftBall.isHidden = false
                rightBall.isHidden = true
            }
            else if records.last == "B" {
                leftBall.isHidden = true
                rightBall.isHidden = false
            }
        //球權 Array 最後一筆資料若為 "B" 則代表 TeamB 剛加分，因此獲得球權
        } else if records.last == "B" && rightScore > 0 {
            //因此要將 TeamB 分數減 1
            rightScore = rightScore - 1
            ScoreB.text = String(rightScore)
            //同時要將 Array 最後一筆資料移除
            records.removeLast()
            //這邊取出 Array 值僅是要確認球權是否有正確移除
            print(records)
            //除了考慮到 Array 外還要將球權圖示提醒同步變換
            if records.last == "A" {
                print(records)
                leftBall.isHidden = false
                rightBall.isHidden = true
            }
            else if records.last == "B" {
                leftBall.isHidden = true
                rightBall.isHidden = false
            }
        }
    }
    @IBAction func ChangeSide(_ sender: Any) {
        changeSide()
    }
    @IBAction func finishTyping(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func restartGame(_ sender: Any) {
        resetGAME()
    
    }
    @IBAction func info(_ sender: Any) {
        info()
    }
    
    
}


