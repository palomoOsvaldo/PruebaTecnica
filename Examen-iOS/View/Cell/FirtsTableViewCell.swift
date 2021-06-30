//
//  FirtsTableViewCell.swift
//  Examen-iOS
//
//  Created by Osvaldo Salas on 28/06/21.
//

import UIKit

class FirtsTableViewCell: UITableViewCell {
    
    static let identifier = "FirtsCell"
    var textFieldUser: UITextField!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        isEditing = true
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        textFieldUser = UITextField()
        textFieldUser.placeholder = "Ingresar Nombre"
        textFieldUser.font = UIFont.systemFont(ofSize: 15)
        textFieldUser.borderStyle = .roundedRect
        textFieldUser.keyboardType = .default
        textFieldUser.returnKeyType = .done
        textFieldUser.translatesAutoresizingMaskIntoConstraints = false
        textFieldUser.delegate = self
        
        addSubview(textFieldUser!)
        
        NSLayoutConstraint.activate([
            textFieldUser!.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textFieldUser!.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textFieldUser!.heightAnchor.constraint(equalToConstant: 30),
            textFieldUser!.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }

}

extension FirtsTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                return false
            }
        }
        catch {
            print("ERROR")
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 50
    }
}
