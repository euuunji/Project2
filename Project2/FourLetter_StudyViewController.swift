//
//  FourLetter_StudyViewController.swift
//  Project2
//
//  Created by SWUCOMPUTER on 2020/07/04.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit

class FourLetter_StudyViewController: UIViewController {

    @IBOutlet var displayLabel: UILabel!
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    let wordArray : [String] = ["십시일반", "문전성시", "가렴주구", "일목요연"]
    let explainArray : [String] = ["여러 사람이 힘을 합하면 한 사람을 돕기는 쉬움", "찾아오는 이가 많아 집 앞이 시장을 이루다시피 함",
                                      "세금을 가혹하게 거두고 무리하게 재물을 뺴앗음",
                                      "한 번 보고도 알 수 있을만큼 분명함"]
    var index : Int!
       
    override func viewDidLoad() {
       super.viewDidLoad()
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
        displayLabel.text = appDelegate.userName! + "님의 사자성어 공부를 응원합니다!"
       let randomIndex : Int = Int(arc4random_uniform(UInt32(wordArray.count-1)))
       index = randomIndex
       index = (index + 1) % wordArray.count
       wordLabel.text = wordArray[index]
       explainLabel.text = explainArray[index]
           
       }
       
    @IBAction func nextButton() {
           index += 2
           index = (index + 1) % wordArray.count
           wordLabel.text = wordArray[index]
           explainLabel.text = explainArray[index]
    }
       
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           let destination = segue.destination as! FourLetter_TestViewController
//           destination.name = name
//       }
       
}
