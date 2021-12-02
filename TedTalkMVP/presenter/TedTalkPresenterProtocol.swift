//
//  TedTalkPresenterProtocol.swift
//  TedTalkMVP
//
//  Created by Gonzalo Romero on 30/11/2021.
//

import Foundation

protocol TedTalkPresenterProtocol {
    
    //var view: {get set}
    var tedTalks: [TedTalk]? {get set}
    var filteredTalk: [TedTalk] {get set}
    var view: TedTalkViewProtocol? {get set}
    
    func getFilteredTalkCount() -> Int
    func getFilteredTalk(for tedTalk: Int) -> TedTalk
    func filterTalk(filter: String, text: String)
    func getPickerRowsCount() -> Int
    func getPickerRow(index: Int) -> String
}
