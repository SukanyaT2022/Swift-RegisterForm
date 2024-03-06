//
//  MemberTableViewCell.swift
//  feb21SimplePage
//
//  Created by Tiparpron Sukanya on 2/29/24.
//

import Foundation
import UIKit

class MemberTableViewCell: UITableViewCell{
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    var memberData: Member?
    
    @IBOutlet weak var addressLabel: UILabel!
}
