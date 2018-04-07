//
//  FinishVC.swift
//  BookingDate
//
//  Created by Andrew on 4/7/18.
//  Copyright © 2018 Andrii Halabuda. All rights reserved.
//

import UIKit

class FinishVC: UIViewController {

    @IBOutlet weak var statusLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statusLbl.text = """
        Booked from \(dateFrom) to \(dateTo)
        Period of stay \(lengthStay)
        """
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
