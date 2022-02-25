import UIKit

class LoginVC: UIViewController {
   
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
    
    let login:UIButton = {
        var btnlgn = UIButton()
        btnlgn.setTitle("Login", for: .normal)
        btnlgn.addTarget(self, action: #selector(btnClick), for:.touchUpInside)
        btnlgn.layer.borderWidth = 2
        btnlgn.backgroundColor = .red
        return btnlgn
    }()
    @objc func btnClick(){
        let u = CoreDataHandler.shared.chkLogin(username: UserName.text!, password: Password.text!)
        if u.username != ""
        {
            UserDefaults.standard.setValue(u.username, forKey: "username")
            let vc = HomeVC()
            //vc.title = UserDefaults.standard.string(forKey: "username")
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    let newUser:UIButton = {
        var btnlgn = UIButton()
        btnlgn.setTitle("Create a new user? Click Here!", for: .normal)
        btnlgn.addTarget(self, action: #selector(btnNewClick), for:.touchUpInside)
        btnlgn.backgroundColor = .white
        btnlgn.tintColor = .black
        btnlgn.setTitleColor(.red, for: .normal)
        return btnlgn
    }()
    @objc func btnNewClick(){
        let vc = RegVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        navigationItem.setHidesBackButton(true, animated: true)
        super.viewDidLoad()
        //ßnavigationController?.isNavigationBarHidden = true
            view.addSubview(UserName)
        view.addSubview(Password)
        view.addSubview(login)
        view.addSubview(newUser)
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UserName.frame = CGRect(x: 30, y: 100, width: view.width - 60, height: 40)
        Password.frame = CGRect(x: 30, y: UserName.bottom + 40, width: view.width - 60, height: 40)
        login.frame = CGRect(x: 30, y: Password.bottom + 40, width: view.width - 60, height: 40)
        newUser.frame = CGRect(x: 30, y: login.bottom + 40, width: view.width - 60, height: 40)

    }
}
