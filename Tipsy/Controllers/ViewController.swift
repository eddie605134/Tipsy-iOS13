//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var billTextField: UITextField!
	@IBOutlet weak var tenPctBtn: UIButton!
	@IBOutlet weak var zeroPctBtn: UIButton!
	@IBOutlet weak var twentyPctBtn: UIButton!
	@IBOutlet weak var spiltNumberText: UILabel!
	var pctButtonArray: [UIButton] = []
	var tipPercentage = 0.1
	var tipTitle = "10%"
	var result = 0.0
	
	override func viewDidLoad() {
			super.viewDidLoad()
			// 在 viewDidLoad 初始化
			pctButtonArray = [tenPctBtn, zeroPctBtn, twentyPctBtn]
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
				view.addGestureRecognizer(tapGesture)
		
		NotificationCenter.default.addObserver(self, selector: #selector(clearBillTextField), name: NSNotification.Name("ClearBillTextField"), object: nil)
	}
	
	deinit {
			NotificationCenter.default.removeObserver(self)
	}
	
	// 手勢觸發的動作
	@objc func dismissKeyboard() {
			billTextField.endEditing(true) // 讓 TextField 結束編輯模式
	}
	
	
	@IBAction func tipChange(_ sender: UIButton) {
		dismissKeyboard()
		if sender.isSelected { return }
		for button in pctButtonArray {
			button.isSelected = false
		}
		sender.isSelected = true
		switch sender.tag {
				case 0:
					tipPercentage = 0.0
					tipTitle = "0%"
				case 10:
					tipPercentage = 0.1
					tipTitle = "10%"
				case 20:
					tipPercentage = 0.2
					tipTitle = "20%"
				default:
					tipPercentage = 0.0
					tipTitle = "0%"
		}
	}
	
	@IBAction func stepperValueChange(_ sender: UIStepper) {
		dismissKeyboard()
		let formattedValue = String(format: "%.0f", sender.value)
				print(formattedValue)  // 輸出整數形式的字串
		spiltNumberText.text = formattedValue  // 更新到 Label
	}
	
	@IBAction func calculatePressed(_ sender: UIButton) {
		// 確保鍵盤隱藏
		view.endEditing(true)
		
		// 取得金額
		guard let billText = billTextField.text, let billAmount = Double(billText) else {
				return
		}
		
		// 取得人數
		guard let splitText = spiltNumberText.text, let numberOfPeople = Int(splitText), numberOfPeople > 0 else {
				return
		}
		
		// 計算每人金額
		let totalAmount = billAmount * (1 + tipPercentage) // 加上百分比
		result = totalAmount / Double(numberOfPeople) // 除以人數
		performSegue(withIdentifier: "gotoResult", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "gotoResult" {
			let destinationVC = segue.destination as! ResultsViewController
			destinationVC.totalResult = result
			destinationVC.splitNumber = spiltNumberText.text
			destinationVC.tipTitle = tipTitle
		}
	}
	
	@objc func clearBillTextField() {
			billTextField.text = ""
	}
}

