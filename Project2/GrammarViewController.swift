//
//  GrammarViewController.swift
//  Project2
//
//  Created by SWUCOMPUTER on 2020/07/05.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class GrammarViewController: UIViewController {

     @IBOutlet var displayLabel: UILabel!
     @IBOutlet var leftQuestion: UIButton!
     @IBOutlet var rightQuestion: UIButton!
     @IBOutlet var resultView: UIView!
     @IBOutlet var resultLabel: UILabel!
     @IBOutlet var explainLabel: UILabel!
     var index : Int!
     var cnt = 1
     var cntResult = 0
    
     
     typealias Question = (correct:String, wrong:String, info:String)
     let questionList : [Question] = [("대가를 치루다","댓가를 치루다","일부 예외를 제외하고 한자어끼리의 결합에서는 사이시옷을 표기하지 않습니다."), ("익숙지 않다","익숙치 않다","'익숙하지'를 줄여 '익숙지'의 형태로 적습니다."), ("재작년","제작년","지난해의 바로 전 해는 '재작년'입니다.")]
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        displayLabel.text = appDelegate.userName! + "님, 올바른 맞춤법을 골라주세요!"
        resultView.isHidden = true
            
        let randomIndex : Int = Int(arc4random_uniform(UInt32(questionList.count-1)))
        index = randomIndex
        leftQuestion.setTitle(questionList[index].correct, for: .normal)
        rightQuestion.setTitle(questionList[index].wrong, for: .normal)
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
           resultView.isHidden = false
        if sender.titleLabel?.text == questionList[index].correct{
           resultLabel.text = "(๑>◡<๑) 정답입니다!"
            cntResult = cntResult + 1
        } else {
            resultLabel.text = "(c ತ,_ತ) 오답입니다!"
        }
            explainLabel.text = questionList[index].info
    }
    
    @IBAction func nextButton() {
        resultView.isHidden = true
        index += 1
        index = (index + 1) % questionList.count
        leftQuestion.setTitle(questionList[index].wrong, for: .normal)
        rightQuestion.setTitle(questionList[index].correct, for: .normal)
        cnt = cnt + 1
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let context = self.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Result", in: context)
        
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(cnt, forKey: "cnt")
        object.setValue(cntResult, forKey: "cntResult")
        object.setValue(Date(), forKey: "testDate")
        object.setValue("맞춤법", forKey: "title")
        do {
        try context.save()
            print("saved!")
        } catch let error as NSError {
        print("Could not save \(error), \(error.userInfo)") }
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
