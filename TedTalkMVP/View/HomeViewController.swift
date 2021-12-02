//
//  HomeViewController.swift
//  TedTalkMVP
//
//  Created by Gonzalo Romero on 01/12/2021.
//

import UIKit

class HomeViewController: UIViewController, TedTalkViewProtocol {
    
    @IBOutlet weak var TableTedTalk: UITableView!
    @IBOutlet weak var pickerTedTalk: UIPickerView!
    @IBOutlet weak var SearchTedTalk: UISearchBar!
    
    private var pickerSelectedRow = ""
    lazy var presenter: TedTalkPresenterProtocol = TedTalkPresenter(view: self as TedTalkViewProtocol)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func reloadData() {
        TableTedTalk.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource, UISearchBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter.getPickerRowsCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presenter.getPickerRow(index: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerSelectedRow = presenter.getPickerRow(index: row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getFilteredTalkCount()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let talk = presenter.getFilteredTalk(for: indexPath.row)
        var cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableCellTedTalk
        if cell == nil {
            cell = CustomTableCellTedTalk()
        }
        cell?.configureCell(talk)
        return cell ?? UITableViewCell()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.filterTalk(filter: pickerSelectedRow, text: searchText)
    }
    
}
