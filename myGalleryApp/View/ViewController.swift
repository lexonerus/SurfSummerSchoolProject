//
//  ViewController.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 02.08.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: View lifecycle
    
    // 1
    override func loadView() {
        super.loadView()
        print("Load view")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View loaded")
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    // 2
    override func viewWillAppear(_ animated: Bool) {
        print("View will appear")
    }
    // 3
    override func viewDidAppear(_ animated: Bool) {
        print("View did appear")
    }
    // 4
    override func viewWillDisappear(_ animated: Bool) {
        print("View will disappear")
    }
    // 5
    override func viewDidDisappear(_ animated: Bool) {
        print("View did disappear")
    }
    // 6
    override func didReceiveMemoryWarning() {
        print("iOS memory is not enough!")
    }
    


}

