//
//  CellListOfRepository.swift
//  SaveRepo
//
//  Created by A1398 on 20/02/2023.
//

import UIKit

class CellListOfRepository: UITableViewCell {
    
    @IBOutlet private(set) weak var view: UIView!
    @IBOutlet weak var nameProjectLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = view.layer.frame.height / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
