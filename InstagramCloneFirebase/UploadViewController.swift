//
//  UploadViewController.swift
//  InstagramCloneFirebase
//
//  Created by Eren Küpeli on 29.08.2024.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var shareOutlet: UIButton! // Butonu gizleyip gösterebilmek için outlet oluşturdum.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageLabel.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageLabel.addGestureRecognizer(gestureRecognizer)
        shareOutlet.isHidden = false
        
    }
    
    @objc func chooseImage() {
        
        // PickerController ile kullanıcıya galeriden fotoğraf seçtirmek için.
        let picker = UIImagePickerController()
        picker.delegate = self // pickercontroller fonksiyonlarını kullanabilmek için delegate ettik.
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
        
    }
    
    // Medya seçme işlemi bittiğinde yapılacaklar için bu fonksiyonu yazdım.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageLabel.image = info[.originalImage] as? UIImage //Seçilen görseli imageLabel'a eşitledim.
        self.dismiss(animated: true)
        
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    @IBAction func shareButton(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference() // Hangi klasörle çalışacağımızı, nereye kaydedeceğimizi belirtmek için. Ana klasöre referans verdik.
        let mediaFolder = storageRef.child("media") // Oluşturduğumuz klasöre erişebilmek için. Eğer dizinde girilen isimli klasör yoksa otomatik oluşturur.
        
        // Görselin olup olmadığını kontrol edip, eğer görsel varsa 0.5 sıkıştırarak data variable'ına kaydetmesi için.
        if let data = imageLabel.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString //Hher kullandığımda benzersiz uydurma bir değer oluşturacak.
            
            let imageRef = mediaFolder.child("\(uuid).jpg") // Görselin kaydedileceği yer ve ismini ekledik.
            imageRef.putData(data) { metadata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error") // Hata gelirse yazdır.
                }
                else {
                    imageRef.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString // Eğer hiç bir sorun olmazsa ve görseli kayıt ederse, kaydettiği url'yi al.
                            
                            // Database
                            let firestoreDatabase = Firestore.firestore() // Initialize, fonksiyonları kullanabilmek için.
                            var firestoreRef : DocumentReference? = nil // Collection içinde documents için referans oluşturduk.
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as! [String : Any] // Kaydedilecek veriler için bir dictionary oluşturduk.
                            
                            // Collection içine kayıt (document) oluşturmak.
                            firestoreRef = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                }
                                else {
                                    // Hata yoksa fotoğraf yüklendikten sonra upload ekranını sıfırlanması ve kullanıcıyı feed'e götürmesi.
                                    self.imageLabel.image = UIImage(named: "select")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0 // TabBar içinde 0. index'e (feed) götürülmesi.
                                }
                            })
                        }
                    }
                }
            }
        }
    }
}
