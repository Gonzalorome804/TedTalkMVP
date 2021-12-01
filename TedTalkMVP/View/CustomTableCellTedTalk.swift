//
//  CustomTableCellTedTalk.swift
//  TedTalkMVP
//
//  Created by Gonzalo Romero on 01/12/2021.
//

import UIKit

class CustomTableCellTedTalk: UITableViewCell {
    
    @IBOutlet weak var labelMainSpeakerCell: UILabel!
    @IBOutlet weak var labelDescriptionCell: UILabel!
    
    func configureCell(_ talk: TedTalk){
        labelMainSpeakerCell.text = "Main Speaker: \(talk.main_speaker)"
        labelDescriptionCell.text = talk.description
    }
}
