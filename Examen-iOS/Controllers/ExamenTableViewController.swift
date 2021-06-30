//
//  ExamenTableViewController.swift
//  Examen-iOS
//
//  Created by Osvaldo Salas on 28/06/21.
//

import UIKit
import FirebaseStorage

class ExamenTableViewController: UITableViewController, UITextFieldDelegate {

    private let storage = Storage.storage().reference()
    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Examen"
        tableView.register(FirtsTableViewCell.self, forCellReuseIdentifier: FirtsTableViewCell.identifier)
        tableView.register(GenericTableViewCell.self, forCellReuseIdentifier: GenericTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FirtsTableViewCell.identifier, for: indexPath) as! FirtsTableViewCell
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableViewCell.identifier, for: indexPath) as! GenericTableViewCell
            cell.lblGeneric.text = "Seleccionar foto"
            cell.imgView.isHidden = true
            cell.accessoryType = .disclosureIndicator
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableViewCell.identifier, for: indexPath) as! GenericTableViewCell
            cell.lblGeneric.text = Constants.description
            return cell
        }
        return UITableViewCell.init(style: .default, reuseIdentifier: "cell")
    }
    
// MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ndx = IndexPath(row:0, section: 0)
        let cell = tableView.cellForRow(at:ndx) as! FirtsTableViewCell
        userName = cell.textFieldUser.text
        
        if indexPath.row == 1 {
            if userName.isEmpty {
                showAlert(title: "Alerta", message: "Debes ingresar tu nombre")
            }else {
                showActionSheetWithCameraAndLibrary(vc: self)
            }
        } else if indexPath.row == 2 {
            let vc = GraficaTableViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - ImagePicker

extension ExamenTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showActionSheetWithCameraAndLibrary(vc: UITableViewController) {
        
        vc.showActionSheetWithCancel(titleAndAction: [
            (ActionSheetTitle.camera, { [weak self] in self?.openCamera() }),
            (ActionSheetTitle.photoLibrary, { [weak self] in self?.openGallery() })
        ])
    }
    
    func openCamera()
    {
        let imagePicker = UIImagePickerController()
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            showAlert(title: "Alerta", message: "No tienes acceso a la cámara.")
        }
    }
    
    func openGallery()
    {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            showAlert(title: "Alerta", message: "No tienes acceso a la libreria.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        //let imageName = UUID().uuidString
        
        guard let imageData = image.pngData() else { return }
        
        let imageName = userName.replacingOccurrences(of: " ", with: "")
        print(imageName)
        
        storage.child("images/\(imageName).png").putData(imageData,
                                                         metadata: nil,
                                                         completion: { _, error in
                                                            guard error == nil else {
                                                                print("Failed to upload")
                                                                return
                                                            }
                                                            
                                                            self.storage.child("images/\(imageName).png").downloadURL(completion: { url, error in
                                                                guard let url = url, error == nil else { return }
                                                                
                                                                let urlString = url.absoluteString
                                                                print("Download url: \(urlString)")
                                                                
                                                                DispatchQueue.main.async {
                                                                    self.tableView.reloadData()
                                                                    self.showAlert(title: "Alerta", message: "La imagen se guardo satisfactoriamente.")
                                                                }
                                                            })
                                                            })
        
        dismiss(animated: true)
    }
}
