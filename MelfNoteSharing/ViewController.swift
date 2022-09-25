//
//  ViewController.swift
//  MelfNoteSharing
//
//  Created by 范志勇 on 2022/9/25.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    //MARK: 隐藏状态栏
    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.adjustUI()
    }
    
    func adjustUI() {
        self.googleSignInButton.style = .wide
        self.googleSignInButton.colorScheme = .light
        self.googleSignInButton.layer.borderColor = UIColor.black.cgColor
        self.googleSignInButton.layer.borderWidth = 1
        self.googleSignInButton.layer.cornerRadius = 15
        self.googleSignInButton.layer.shadowOffset = CGSize()
        self.googleSignInButton.layer.shadowColor = UIColor.clear.cgColor
        self.googleSignInButton.layer.shadowRadius = 15
        self.googleSignInButton.layer.shadowPath = nil
//        self.googleSignInButton.layer.style = 1
    }

    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    @IBAction func signIn(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
          guard error == nil else {
              print("google account sign in : failure")
              return
              
          }

          // If sign in succeeded, display the app's main content View.
            print("google account sign in : success")
            
            // jump to home page
            let vc = MainViewController()
            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

