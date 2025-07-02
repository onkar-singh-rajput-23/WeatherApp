//
//  SearchResultViewTableViewCell.swift
//  WeatherApp
//
//  Created by onkar.rajput on 01/07/25.
//

import UIKit
import SwiftUI

class SearchTableViewCell: UITableViewCell {
    static let identifier = "cell"
    
    private var hostingController: UIHostingController<ListCellView>!

    
    func setUI(cityName: String, parentVC: UIViewController) {
        let view = ListCellView(cityName: cityName)
        
        if let hostingController = hostingController {
            hostingController.rootView = view
        } else {
            let controller = UIHostingController(rootView: view)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            self.hostingController = controller
            
            parentVC.addChild(controller)
            contentView.addSubview(controller.view)
            
            NSLayoutConstraint.activate([
                controller.view.topAnchor.constraint(equalTo: contentView.topAnchor),
                controller.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                controller.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                controller.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
            
            controller.didMove(toParent: parentVC)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
