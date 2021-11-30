//
//  TedTalkPresenter.swift
//  TedTalkMVP
//
//  Created by Gonzalo Romero on 30/11/2021.
//

import Foundation

class TedTalkPresenter: TedTalkPresenterProtocol{
    
    var view: TedTalkViewProtocol?
    var parseError: ParseErrors? = nil
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
        
        TedTalkManager().parseFromJson( fileName: "tedtalks") {
            result in
            DispatchQueue.main.async {
                switch result {
                case .success(let talks):
                    self.tedTalks = talks
                case .failure(let error):
                    switch error {
                    case .decodingProblem:
                        self.parseError = error
                    case .fileNotFound:
                        self.parseError = error
                    case .invalidData:
                        self.parseError = error
                        self.tedTalks = []
                    }
                }
            }
        }
    }
    
    func getFilteredTalkCount() -> Int {
        return self.filteredTalk.count
    }
    
    func getFilteredTalk(for tedTalk: Int) -> TedTalk {
        return self.filteredTalk[tedTalk]
    }
    
    func filterTalk(filters: String, text: String) {
        self.filteredTalk = []
        tedTalks?.forEach({
            (talk) in
            if talk.isFiltered(filters, input: text){
                self.filteredTalk.append(talk)
            }
        })
    }
    
}

