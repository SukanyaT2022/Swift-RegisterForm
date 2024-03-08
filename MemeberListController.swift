//
//  MemeberListController.swift
//  feb21SimplePage
//
//  Created by Tiparpron Sukanya on 2/29/24.
//

import Foundation
import UIKit
class MemeberListController:UIViewController, UITableViewDataSource, UITableViewDelegate{
   
    @IBOutlet weak var memberListTableView: UITableView!
    var memberList : [Member]?
    override func viewDidLoad() {
      super.viewDidLoad()
        //if we have tableview always have delegate and datasauce
        memberListTableView.dataSource = self
        memberListTableView.delegate = self
     
    }
    //refresh page--after delete detail of member -it update the pae
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        fetchMember()
        memberListTableView.reloadData()
    }
    func fetchMember(){
        let fetchRequest = Member.fetchRequest()
        memberList = try? (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.fetch(fetchRequest)
    }
}
extension MemeberListController{
    //how many row we need
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    //create cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"memberCell" , for: indexPath) as? MemberTableViewCell else{
            return UITableViewCell()
        }
        //each row get member list to each row -then  display on cell
        let memeber = memberList?[indexPath.row]
        cell.memberData = memeber
        cell.nameLabel.text = memeber?.name
        cell.phoneLabel.text = memeber?.phone
        cell.addressLabel.text = memeber?.address
        return cell
    }
    //purpose enable the row for edit
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
        
    }
    //edititng style kis delete - which row for delete
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let cell = tableView.cellForRow(at: indexPath) as? MemberTableViewCell
            if let member = cell?.memberData,
               let appDelegate = UIApplication.shared.delegate as? AppDelegate{
                appDelegate.persistentContainer.viewContext.delete(member)
                appDelegate.saveContext()
                self.fetchMember()
                self.memberListTableView.reloadData()
                
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? MemberTableViewCell
        self.performSegue(withIdentifier: "detailConnect", sender: cell?.memberData)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? ViewController
        detailVC?.memberData = sender as? Member
        
    }
}
