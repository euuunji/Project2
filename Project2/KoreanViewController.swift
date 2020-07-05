//
//  KoreanViewController.swift
//  Project2
//
//  Created by SWUCOMPUTER on 2020/07/05.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class KoreanViewController: UIViewController {

    @IBOutlet var displayLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var resultView: UIView!
    @IBOutlet var resultLabel: UILabel!
    var index : Int!
    var cnt = 1
    var cntResult = 0
    
    typealias Question = (correct:String, wrong:String, info:String)
    let questionList : [Question] = [("띠앗","씨앗","형제나 자매 사이의 우애심"),("빼빼거리다","쨍긋거리다","어린아이가 듣기 싫게 자꾸 울다"),("소록소록","노근노근","아이가 곱게 자는 모양"),("구순하다","교순하다","사이가 좋아 화목하다")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        displayLabel.text = appDelegate.userName! + "님, 설명에 맞는 순우리말을 골라보세요!"
        resultView.isHidden = true
        let randomIndex : Int = Int(arc4random_uniform(UInt32(questionList.count-1)))
            index = randomIndex
        leftButton.setTitle(questionList[index].correct, for: .normal)
        rightButton.setTitle(questionList[index].wrong, for: .normal)
        explainLabel.text = questionList[index].info

    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
          resultView.isHidden = false
           if sender.titleLabel?.text == questionList[index].correct{
              resultLabel.text = "(๑>◡<๑) 정답입니다!"
            cntResult = cntResult + 1
           } else {
               resultLabel.text = "(c ತ,_ತ) 오답입니다!"
           }
      }
      
    @IBAction func nextButton() {
        resultView.isHidden = true
        index += 2
        index = (index + 1) % questionList.count
        leftButton.setTitle(questionList[index].wrong, for: .normal)
        rightButton.setTitle(questionList[index].correct, for: .normal)
        explainLabel.text = questionList[index].info
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
        object.setValue("순우리말", forKey: "title")
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
