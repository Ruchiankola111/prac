
import UIKit

class NewNoteVC: UIViewController {

    var note:Notes?
    let noteTitle:UITextField = {
        var txtuname = UITextField()
        txtuname.placeholder = "enter title"
        txtuname.layer.borderWidth = 1
        txtuname.layer.borderColor = UIColor.red.cgColor
        return txtuname
    }()
    let pickerview = UIPickerView()
    let pickerData = ["Home","Work","College"]
    
    let add :UIButton = {
        var btnlgn = UIButton()
        btnlgn.setTitle("Add", for: .normal)
        btnlgn.addTarget(self, action: #selector(btnClick), for:.touchUpInside)
        btnlgn.layer.borderWidth = 2
        btnlgn.backgroundColor = .red
        return btnlgn
    }()
    @objc func btnClick()
    {
        let type = pickerData[pickerview.selectedRow(inComponent: 0)]

        if let  n = note{
            CoreDataHandler.shared.updateNote(n: n, title: noteTitle.text!, type: type)
        }else
        {
            CoreDataHandler.shared.noteInsert(title: noteTitle.text!, type: type)
        }
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        view.addSubview(noteTitle)
        view.addSubview(pickerview)
        view.addSubview(add)
        pickerview.delegate = self
        pickerview.dataSource = self
        if let n = note {
            noteTitle.text = n.title
            for i in 0...pickerData.count - 1 
            {
                if(n.type == pickerData[i])
                {
                    pickerview.selectRow(i, inComponent: 0, animated: true)
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noteTitle.frame = CGRect(x: 30, y: 300, width: view.width - 60, height: 40)
        pickerview.frame = CGRect(x: 30, y: noteTitle.bottom + 30, width: view.width - 60, height: 40)
        add.frame = CGRect(x: 30, y: pickerview.bottom + 30, width: view.width - 60, height: 40)

    }

}

extension NewNoteVC : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
