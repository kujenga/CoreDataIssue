//
//  ViewController.swift
//  Entity
//
//  Created by Aaron Taylor on 3/27/15.
//  Copyright (c) 2015 Aaron Taylor. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.update()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func update() {
        self.textView.string = ""
        for f in Persistence.getAllFiles(nil)! {
            self.textView.textStorage!.appendAttributedString(NSAttributedString(string: "\(f.name)\n"))
        }
    }

    @IBAction func createFile(sender: AnyObject) {
        Persistence.createFile(nil, name: "file-\(arc4random()%90000 + 10000)")
        
        self.update()
    }

}

