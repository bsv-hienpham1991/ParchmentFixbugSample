//
//  SampleViewController.swift
//  ParchmentFixbugSample
//
//  Created by Hien Pham on 4/29/20.
//  Copyright © 2020 Hien Pham. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {
    let index: Int
    @IBOutlet private weak var label: UILabel!
    
    init(index: Int) {
        self.index = index
        super.init(nibName: String(describing: SampleViewController.self), bundle: nil)
        self.title = String(index)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.text = String(index)
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
