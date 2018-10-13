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
    @IBOutlet var columnOneLabels: [UILabel]!
    @IBOutlet var columnTwoLabels: UILabel!
    @IBOutlet var tipLabels: [UILabel]!
    @IBOutlet var totalLabels: [UILabel]!
    @IBOutlet var movableNamesCollection: [UILabel]!
    @IBOutlet weak var nameRowLabel: UILabel!
    
    var labelViewOrigin: CGPoint!
    var labelData: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBorder(label: quantityNumberLabels)
        addBorder(label: tipLabels)
        addBorder(label: totalLabels)
        
        for label in movableNamesCollection {
            
            labelData = label.text
            addPanGesture(view: label)
            labelViewOrigin = label.frame.origin
            view.bringSubviewToFront(label)
            
        }
    }
    
    func addPanGesture(view: UIView) {

        let pan = UIPanGestureRecognizer(target: self, action: #selector(BaseClassViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        let labelView = sender.view!
        
        switch sender.state {
            
        case .began, .changed:
            print("Moving")
            moveViewWithPan(view: labelView, sender: sender)
            
        case .ended:
            if labelView.frame.intersects(nameRowLabel.frame) {
                nameRowLabel.text = labelData
                deleteView(view: labelView)
            } else {
                returnViewToOrigin(view: labelView)
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
            view.frame.origin = self.labelViewOrigin
        })
    }
    
    func deleteView(view: UIView) {
        
        UIView.animate(withDuration: 0.0, animations: {
            view.alpha = 0.0
        })
    }
    
    func addBorder(label: [UILabel]) {
        
        label.forEach { (label) in
            label.layer.borderColor = UIColor.black.cgColor
            label.layer.borderWidth = 1.0
        }
    }
    
}
