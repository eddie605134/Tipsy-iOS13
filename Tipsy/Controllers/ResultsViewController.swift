//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by eddie chang on 2024/11/18.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
	var totalResult: Double?
	var splitNumber: String?
	var tipTitle: String?

	@IBOutlet weak var totalLabel: UILabel!
	@IBOutlet weak var settingsLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
				totalLabel.text = "\(totalResult ?? 0.0)"
				settingsLabel.text = "Split: \(splitNumber ?? "N/A") | \(tipTitle ?? "N/A")"
        // Do any additional setup after loading the view.
    }
    

	@IBAction func recalculatePressed(_ sender: UIButton) {
		NotificationCenter.default.post(name: NSNotification.Name("ClearBillTextField"), object: nil)
		dismiss(animated: true, completion: nil)
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
