//
//  DetailTedTalkViewController.swift
//  TedTalkMVP
//
//  Created by Gonzalo Romero on 02/12/2021.
//

import UIKit
import WebKit

class DetailedTedTalkViewController: UIViewController{
    
    @IBOutlet weak var labelTitleDetail: UILabel!
    @IBOutlet weak var labelOfViewDetail: UILabel!
    @IBOutlet weak var labelNameDetail: UILabel!
    @IBOutlet weak var labelDescrptionDetail: UILabel!
    @IBOutlet weak var labelTagDetail: UILabel!
    @IBOutlet weak var tedTalkWeb: WKWebView!
    
    var tedTalk: TedTalk? = nil
    var tagString: String = "Tags: "
    
    func setTedTalk(talk: TedTalk){
        self.tedTalk = talk
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let displayTedTalk = tedTalk{
            
            labelTitleDetail.text = displayTedTalk.title
            tedTalkWeb.load(URLRequest(url: URL(string: displayTedTalk.url)!))
            tagString = tagString + (displayTedTalk.tags[0])
            
            for tag in 1..<tedTalk!.tags.count {
                tagString = tagString + ", \(displayTedTalk.tags[tag])"
            }
            
            labelTagDetail.text = tagString
            let viewString = displayTedTalk.views as NSNumber
            labelOfViewDetail.text = "#of views: \(viewString.stringValue)"
            labelNameDetail.text = displayTedTalk.name
            labelDescrptionDetail.text = displayTedTalk.description
        }
    }
}
