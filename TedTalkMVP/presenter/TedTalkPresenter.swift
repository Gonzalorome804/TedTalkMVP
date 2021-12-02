//
//  TedTalkPresenter.swift
//  TedTalkMVP
//
//  Created by Gonzalo Romero on 30/11/2021.
//

import Foundation

class TedTalkPresenter: TedTalkPresenterProtocol{
    
    let pickerRows: [String] = ["Event", "Main Speaker", "Title", "Name", "Description", "Any"]
    var view: TedTalkViewProtocol?
    var tedTalks: [TedTalk]? = []
    var filteredTalk: [TedTalk] = []{
        didSet{
            view?.reloadData()
        }
    }
    
    init(view: TedTalkViewProtocol) {
        self.view = view
        getTalks()
    }
    
    private func getTalks() {
        
        TedTalkManager().parseFromJson(fileName: "tedTalk") {
            result in
            DispatchQueue.main.async {
                switch result {
                case .success(let talks):
                    self.tedTalks = talks
                    self.filteredTalk = talks
                case .failure(_):
                    DispatchQueue.main.async {
                        self.tedTalks = []
                        print("there was an error")
                    }
                }
            }
        }
    }
    
    func getPickerRowsCount() -> Int {
        return self.pickerRows.count
    }
    
    func getPickerRow(index: Int) -> String {
        return self.pickerRows[index]
    }
    
    func getFilteredTalkCount() -> Int {
        return self.filteredTalk.count
    }
    
    func getFilteredTalk(for tedTalk: Int) -> TedTalk {
        return self.filteredTalk[tedTalk]
    }
    
    func filterTalk(filter: String, text: String) {
        self.filteredTalk = []
        tedTalks?.forEach({
            (talk) in
            if talk.isFiltered(filter, input: text){
                self.filteredTalk.append(talk)
            }
        })
    }
}

