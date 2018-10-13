//
//  BaseClassViewController.swift
//  NextTurn
//
//  Created by Vu Duong on 10/9/18.
//  Copyright © 2018 Vu Duong. All rights reserved.
//

import UIKit

class BaseClassViewController: UIViewController {
    
    @IBOutlet var quantityNumberLabels: [UILabel]!
    @IBOutlet var nameLabels: [UILabel]!
    @IBOutlet var columnOneLabels: [UILabel]!
    @IBOutlet weak var columnTwoLabels: UILabel!
    @IBOutlet var tipLabels: [UILabel]!
    @IBOutlet var totalLabels: [UILabel]!
    
    @IBOutlet weak var testPanLabel: UILabel!
    @IBOutlet var movableNamesCollection: [UILabel]!
    
    var fileViewOrigin: CGPoint!
    var fileViewOrigin2 : CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBorder(label: quantityNumberLabels)
        addBorder(label: nameLabels)
        addBorder(label: tipLabels)
        addBorder(label: totalLabels)
        
        addPanGesture(view: testPanLabel)
        fileViewOrigin = testPanLabel.frame.origin
        
        view.bringSubviewToFront(testPanLabel)
        
        for label in movableNamesCollection {
            
            addPanGesture(view: label)
            
            fileViewOrigin2 = label.frame.origin
            
        }
    }
    
    func addPanGesture(view: UIView) {

        let pan = UIPanGestureRecognizer(target: self, action: #selector(BaseClassViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        let fileView = sender.view!
        
        switch sender.state {
            
        case .began, .changed:
            
            print("Moving")
            moveViewWithPan(view: fileView, sender: sender)
            
        case .ended:
            
            if fileView.frame.intersects(nameLabels[0].frame) {
                deleteView(view: fileView)
                nameLabels[0].text = testPanLabel.text
                
            } else {
                
                returnViewToOrigin(view: fileView)
            }
        default:
            break
            
        }
    }
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    func returnViewToOrigin(view: UIView) {
        
        print("Snap back")
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin = self.fileViewOrigin
        })
    }
    
    func addBorder(label: [UILabel]) {
        
        label.forEach { (label) in
            label.layer.borderColor = UIColor.black.cgColor
            label.layer.borderWidth = 1.0
        }
    }
    
    func deleteView(view: UIView) {
        
        UIView.animate(withDuration: 0.0, animations: {
            view.alpha = 0.0
        })
    }
    
}
