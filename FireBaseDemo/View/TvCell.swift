//
//  TvCell.swift
//  FireBaseDemo
//
//  Created by Atik Hasan on 1/30/25.
//

import UIKit

class TvCell: UITableViewCell {

    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    
    static let identifire = "TvCell"
    static func nib() -> UINib {
        return UINib(nibName: "TvCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
