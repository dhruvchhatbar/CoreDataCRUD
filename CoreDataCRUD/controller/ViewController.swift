//
//  ViewController.swift
//  CoreDataCRUD
//
//  Created by Dhruv Chhatbar on 15/10/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tblView: UITableView!
    var arrModel = [DataModel]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let user = Users(context: self.context)
    }
    override func viewWillAppear(_ animated: Bool) {
        CoreDataSingleton.shared.fetchUserData(userEmail: "") { data in
            arrModel = data
            tblView.reloadData()
        }
    }
    @IBAction func btnTapped(sender: UIButton){
        if sender.tag == 0{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "add-update")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "delete")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func deletePressed(sender: UIButton){
        if sender.tag < arrModel.count{
            CoreDataSingleton.shared.deleteUserData(username: arrModel[sender.tag].userName){
                CoreDataSingleton.shared.fetchUserData(userEmail: "") { data in
                    arrModel = data
                    tblView.reloadData()
                }
            }
        }
    }
    
}
//MARK: UITableViewDelegate, DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userTblViewCell", for: indexPath) as! userTblViewCell
        if arrModel.count > indexPath.row{
            cell.lblEmailId.text = "Email Id: \(arrModel[indexPath.row].emailId)"
            cell.lblUserName.text = "Username:  \(arrModel[indexPath.row].userName)"
            cell.btnDelete.tintColor = StringConstants.primaryColor
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(deletePressed(sender:)), for: .touchUpInside)
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
//MARK: UITableViewCell
class userTblViewCell: UITableViewCell{
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblEmailId: UILabel!
    @IBOutlet var btnDelete: UIButton!
}
