//
//  HomeViewController.swift
//  TedTalkMVP
//
//  Created by Gonzalo Romero on 01/12/2021.
//

import UIKit
import Lottie


class HomeViewController: UIViewController, TedTalkViewProtocol {
    
    @IBOutlet weak var TableTedTalk: UITableView!
    @IBOutlet weak var pickerTedTalk: UIPickerView!
    @IBOutlet weak var SearchTedTalk: UISearchBar!
    
    let animationLoader = AnimationView(name: "35718-loader")
    private var pickerSelectedRow = ""
    lazy var presenter: TedTalkPresenterProtocol = TedTalkPresenter(view: self as TedTalkViewProtocol)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimationLoader()
    }
    
    func reloadData() {
        TableTedTalk.reloadData()
        stopAnimationLoader()
    }
    
    func setupAnimationLoader(){
        animationLoader.frame = CGRect(x: 0, y: 0, width: 125, height: 125)
        animationLoader.center = self.view.center
        animationLoader.contentMode = .scaleAspectFit
        view.addSubview(animationLoader)
        animationLoader.play()
        animationLoader.loopMode = .loop
    }
    func stopAnimationLoader(){
        animationLoader.isHidden = true
    }
}

extension HomeViewController: UITableViewDataSource, UISearchBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate{
    
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
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetail", sender: presenter.getFilteredTalk(for: indexPath.row))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
           let destinationViewController = segue.destination as? DetailedTedTalkViewController,
           let selectedTedTalk = sender as? TedTalk {
            destinationViewController.setTedTalk(talk: selectedTedTalk)
        }
    }
}

