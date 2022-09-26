//
//  NewSubjectViewController.swift
//  MelfNoteSharing
//
//  Created by 范志勇 on 2022/9/25.
//

import UIKit

class NewSubjectViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        self.createContent()
        
        self.createPostButton()
    }
    
    var catalogTF: UITextField?
    var titleTF: UITextField?
    var descriptionTV: UITextView?
    
    /// 新话题
    ///
    /// 内容，分三个部分
    /// 1. catalog
    /// 2. title
    /// 3. description
    func createContent() {
        // catalog
        let aRect = CGRect(x: 0, y: 0, width: 414, height: 342)
        let label = UILabel(frame: aRect)
        label.text = "#"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 19)
        self.view.addSubview(label)
        
        let safe = self.view.safeAreaLayoutGuide
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 20),
            label.heightAnchor.constraint(equalToConstant: 20),
            label.topAnchor.constraint(equalTo: safe.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 37),
        ])
        
        let catalog = UITextField(frame: aRect)
        catalog.placeholder = "industry"
        catalog.font = UIFont.systemFont(ofSize: 19)
        catalog.textColor = .black
        self.view.addSubview(catalog)
        
        catalog.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            catalog.heightAnchor.constraint(equalToConstant: 20),
            catalog.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0),
            catalog.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5),
            catalog.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -40),
        ])
        self.catalogTF = catalog
        
        // title
        let titleTF = UITextField(frame: aRect)
        titleTF.placeholder = "Title"
        titleTF.font = UIFont.systemFont(ofSize: 24)
        titleTF.textColor = .black
        self.view.addSubview(titleTF)
        
        titleTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTF.heightAnchor.constraint(equalToConstant: 30),
            titleTF.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 36),
            titleTF.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 37),
            titleTF.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -40),
        ])
        self.titleTF = titleTF
        
        // description
        let descriptionTV = UITextView(frame: aRect)
        descriptionTV.text = "Type something ..." // Placeholder
        descriptionTV.textColor = UIColor.lightGray
        descriptionTV.font = UIFont.systemFont(ofSize: 19)
        descriptionTV.backgroundColor = .lightGray.withAlphaComponent(0.2)
        self.view.addSubview(descriptionTV)
        
        descriptionTV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTV.heightAnchor.constraint(equalToConstant: 300),
            descriptionTV.topAnchor.constraint(equalTo: titleTF.bottomAnchor, constant: 20),
            descriptionTV.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 37),
            descriptionTV.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -40),
        ])
        descriptionTV.delegate = self
        
        self.descriptionTV = descriptionTV
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type something ..." // Placeholder
            textView.textColor = UIColor.lightGray
        }
    }
    
    /// 发送按钮
    ///
    /// 位置
    /// - 位置与主页面保持一致
    func createPostButton() {
        let aRect = CGRect(x: 0, y: 0, width: 414, height: 342)
        let postButton = UIButton(frame: aRect)
        postButton.setImage(UIImage(named: "paperplane"), for: .normal)
        self.view.addSubview(postButton)
        
        postButton.addTarget(self, action: #selector(postSubject), for: .touchUpInside)
        
        postButton.translatesAutoresizingMaskIntoConstraints = false
        // 1.1 heightAnchor可以再优化
        let safe = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            postButton.widthAnchor.constraint(equalToConstant: 100),
            postButton.heightAnchor.constraint(equalToConstant: 100),
            postButton.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -100),
            postButton.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -30),
        ])
    }
    
    /// 发送
    ///
    /// 保护条件
    /// - 不能为空
    @objc func postSubject() {
        var subject = Subject()
        let id_subject = DAOOfMelfNote.searchMaxID() + 1
        subject.id_subject = id_subject
        subject.postTime = Int(Date().timeIntervalSince1970)
        
        subject.catalog = self.catalogTF?.text
        subject.title = self.titleTF?.text
        subject.description = self.descriptionTV?.text
        
        if DAOOfMelfNote.insertNewMelfSubject(melfSubject: subject) == true {
            print("postSubject 数据库存储成功")
            
            // 发送通知，更新
            NotificationCenter.default.post(name: .hasPostNewSubject, object: self)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
