import UIKit

class RegVC: UIViewController {
    
    let UserName:UITextField = {
        var txtuname = UITextField()
        txtuname.placeholder = "enter username"
        txtuname.layer.borderWidth = 1
        txtuname.layer.borderColor = UIColor.red.cgColor
        return txtuname
    }()
    
    let Password:UITextField = {
        var txtpass = UITextField()
        txtpass.placeholder = "enter password"
        txtpass.layer.borderWidth = 1
        txtpass.layer.borderColor = UIColor.red.cgColor
        txtpass.isSecureTextEntry = true
        return txtpass
    }()
    
    let Reg:UIButton = {
        var btnlgn = UIButton()
        btnlgn.setTitle("Reg", for: .normal)
        btnlgn.addTarget(self, action: #selector(btnClick), for:.touchUpInside)
        btnlgn.layer.borderWidth = 2
        btnlgn.backgroundColor = .red
        return btnlgn
    }()
    
    @objc func btnClick(){
        CoreDataHandler.shared.loginInsert(username: UserName.text!, password: Password.text!)
        navigationController?.popViewController(animated: true)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.addSubview(UserName)
        view.addSubview(Password)
        view.addSubview(Reg)
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UserName.frame = CGRect(x: 30, y: 100, width: view.width - 60, height: 40)
        Password.frame = CGRect(x: 30, y: UserName.bottom + 40, width: view.width - 60, height: 40)
        Reg.frame = CGRect(x: 30, y: Password.bottom + 40, width: view.width - 60, height: 40)        
    }
}
