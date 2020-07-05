//
//  FourLetter_TestViewController.swift
//  Project2
//
//  Created by SWUCOMPUTER on 2020/07/04.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class FourLetter_TestViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var displayLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    @IBOutlet var wordPicker: UIPickerView!
    @IBOutlet var checkLabel: UILabel!
    @IBOutlet var resultView: UIView!
    
    var cnt : Int = 1
    var cntResult = 0
    var wordArray : [String] = ["십시일반", "문전성시", "가렴주구", "일목요연"]
     let explainArray : [String] = ["여러 사람이 힘을 합하면 한 사람을 돕기는 쉬움", "찾아오는 이가 많아 집 앞이 시장을 이루다시피 함", "세금을 가혹하게 거두고 무리하게 재물을 뺴앗음", "한 번 보고도 알 수 있을만큼 분명함"]
    var index : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        displayLabel.text = appDelegate.userName! + "님, 설명에 맞는 사자성어를 골라보세요!"
        resultView.isHidden = true
        let randomIndex : Int = Int(arc4random_uniform(UInt32(wordArray.count-1)))
        index = randomIndex
        
        explainLabel.text = explainArray[index]
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    
    @IBAction func checkAnswer() {
        resultView.isHidden = false
        let answer : String = wordArray[self.wordPicker.selectedRow(inComponent: 0)]
        if answer == wordArray[index] {
            checkLabel.text = "(๑>◡<๑) 정답입니다!"
            cntResult = cntResult + 1
        } else {
            checkLabel.text = "(c ತ,_ತ) 오답입니다!"
        }
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let context = self.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Result", in: context)
        
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(cnt, forKey: "cnt")
        object.setValue(cntResult, forKey: "cntResult")
        object.setValue(Date(), forKey: "testDate")
        object.setValue("사자성어", forKey: "title")
        do {
        try context.save()
            print("saved!")
        } catch let error as NSError {
        print("Could not save \(error), \(error.userInfo)") }
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButton() {
        resultView.isHidden = true
        index += 2
        index = (index + 1) % wordArray.count
        explainLabel.text = explainArray[index]
        cnt = cnt + 1
    }
    
    func numberOfComponents(in PickerView: UIPickerView)->Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component :Int) -> Int {
            return wordArray.count
    }
    
    func pickerView(_ pickerView : UIPickerView, titleForRow row : Int, forComponent component: Int) -> String? {
            return wordArray[row]
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
