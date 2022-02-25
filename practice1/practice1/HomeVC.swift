import UIKit

class HomeVC: UIViewController {
    var Notearray:[Notes]?
    

    func chkAuth()
    {
        if  UserDefaults.standard.string(forKey: "username") == nil{
            let vc = LoginVC()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    let Back:UIButton = {
        var btnlgn = UIButton()
        btnlgn.setTitle("logout", for: .normal)
        btnlgn.addTarget(self, action: #selector(btnClick), for:.touchUpInside)
        btnlgn.layer.borderWidth = 2
        btnlgn.backgroundColor = .red
        return btnlgn
    }()
    @objc func btnClick(){
        UserDefaults.standard.setValue(nil, forKey: "username")
            chkAuth()
    }
    let AddNew:UIButton = {
        var btnlgn = UIButton()
        btnlgn.setTitle("Create New Notes", for: .normal)
        btnlgn.addTarget(self, action: #selector(btnAddClick), for:.touchUpInside)
        btnlgn.layer.borderWidth = 2
        btnlgn.backgroundColor = .red
        return btnlgn
    }()
    @objc func btnAddClick(){
        let vc = NewNoteVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    let notesView = UITableView()
    let data = ["asd","hgf"]
    
    
    
    override func viewDidLoad() {
        navigationItem.setHidesBackButton(true, animated: true)
        chkAuth()
        view.backgroundColor = .white
        super.viewDidLoad()
        title = UserDefaults.standard.string(forKey: "username")
        view.addSubview(Back)
        view.addSubview(AddNew)
       view.addSubview(notesView)
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Notearray = CoreDataHandler.shared.fetch()
        notesView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Back.frame = CGRect(x: 30, y: 100, width: view.width - 60, height: 40)
        AddNew.frame = CGRect(x: 30, y: Back.bottom + 30, width: view.width - 60, height: 40)
        notesView.frame = CGRect(x: 10, y: AddNew.bottom + 10, width: view.width - 20, height: view.height - notesView.top - 10)
    }
}
extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    func setupView()
    {
        notesView.dataSource = self
        notesView.delegate = self
        notesView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notearray!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = Notearray![indexPath.row].title
        return cell
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        CoreDataHandler.shared.deleteNote(n: Notearray![indexPath.row])
        Notearray?.remove(at: indexPath.row)
        notesView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewNoteVC()
        vc.note = Notearray![indexPath.row]
        vc.add.setTitle("update", for: .normal)
        navigationController?.pushViewController(vc, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        let vc = NewNoteVC()
        return vc.pickerData.count
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0{
//         return "Home"
//        }
//        else if section == 1{
//         return "Work"
//        }
//        else{
//            return "College"
//        }
//    }
}
