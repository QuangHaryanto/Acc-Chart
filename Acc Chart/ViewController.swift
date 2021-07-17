//
//  ViewController.swift
//  Acc Chart
//
//  Created by Haryanto Salim on 14/07/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //self.pieChartView = PieChartView()
        
        let segments = [
            Segment(color: .systemRed, value: 20, name: "red"),
            Segment(color: .systemBlue, value: 30, name: "blue"),
            Segment(color: .systemGreen, value: 10, name: "green"),
            Segment(color: .systemYellow, value: 40, name: "yellow")
        ]
        pieChartView?.segments = segments

        guard let pieChartView = pieChartView else {
            return
        }
        
        pieChartView.isAccessibilityElement = true

//        view.addSubview(pieChartView)
        
//        accessibilityElements = [pieChartView] + [pieChartView.accessibilityElements].compactMap { $0 }
        
//        let margins = view.layoutMarginsGuide
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            pieChartView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            pieChartView.topAnchor.constraint(equalTo: guide.topAnchor),
            pieChartView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.5),
            pieChartView.heightAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.5)
        ])
    }
    
}

