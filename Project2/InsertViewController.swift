//
//  InsertViewController.swift
//  Project2
//
//  Created by SWUCOMPUTER on 2020/07/04.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit

class InsertViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var insertName: UITextField!
    @IBOutlet var insertID: UITextField!
    @IBOutlet var insertPW: UITextField!
    @IBOutlet var insertHelp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertHelp.text = ""
    }
    
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        if textField == self.insertName {
            textField.resignFirstResponder()
            self.insertID.becomeFirstResponder()
        }
        else if textField == self.insertID {
                textField.resignFirstResponder()
                self.insertPW.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func buttonInsert() {
        if insertName.text == "" {
            insertHelp.text = "이름을 입력하세요";
            return;
        }
        if insertID.text == "" {
            insertHelp.text = "아이디를 입력하세요";
            return;
        }
        if insertPW.text == "" {
            insertHelp.text = "비밀번호를 입력하세요";
            return;
        }
    
        let urlString: String = "http://condi.swu.ac.kr/student/M05/login/insertUser.php"
        
        guard let requestURL = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let restString: String = "id=" + insertID.text! + "&password=" + insertPW.text!
        + "&name=" + insertName.text!
        request.httpBody = restString.data(using: .utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else { print("Error: calling POST")
                return}
            guard let receivedData = responseData else { print("Error: not receiving Data")
                return }
            if let utf8Data = String(data: receivedData, encoding: .utf8) { DispatchQueue.main.async {
                self.insertHelp.text = utf8Data
                print(utf8Data)
                }
            }
        }
         task.resume()
    }
    
    @IBAction func buttonBack() {
        self.dismiss(animated: true, completion: nil)
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
