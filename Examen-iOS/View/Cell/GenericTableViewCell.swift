//
//  GenericTableViewCell.swift
//  Examen-iOS
//
//  Created by Osvaldo Salas on 29/06/21.
//

import UIKit

class GenericTableViewCell: UITableViewCell {

    static let identifier = "GenericCell"
    var lblGeneric: UILabel!
    var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        isEditing = true
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        lblGeneric = UILabel()
        lblGeneric.numberOfLines = 0
        lblGeneric.font = UIFont.systemFont(ofSize: 15)
        lblGeneric.textAlignment = .justified
        lblGeneric.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(lblGeneric)
        
        imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.isHidden = true
        imgView.backgroundColor = .red
        
        addSubview(imgView)
        
        NSLayoutConstraint.activate([
            imgView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imgView.heightAnchor.constraint(equalToConstant: 30),
            imgView.widthAnchor.constraint(equalToConstant: 30),
            
            
            lblGeneric.leadingAnchor.constraint(equalTo: imgView.trailingAnchor),
            lblGeneric.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            lblGeneric.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            lblGeneric.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

}
