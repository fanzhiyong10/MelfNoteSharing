//
//  NewFeedBackViewController.swift
//  MelfNoteSharing
//
//  Created by 范志勇 on 2022/9/26.
//

import UIKit

class NewFeedBackViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        self.createContent()
        
        self.createPostButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backgroundColor = .white
    }

    
    var positiveTV: UITextView?
    var negativeTV: UITextView?

    /// 新话题
    ///
    /// 内容，分三个部分
    /// 1. catalog
    /// 2. title
    /// 3. description
    func createContent() {
        // catalog
        var aRect = CGRect(x: 0, y: 0, width: 414, height: 342)
        let image1 = UIImage(named: "positiveIcon")
        let imageView1 = UIImageView(image: image1)
        imageView1.tag = 1010
        self.view.addSubview(imageView1)
        
        let safe = self.view.safeAreaLayoutGuide
        
        do {
            imageView1.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
//                    lab1.heightAnchor.constraint(equalToConstant: 19),
                imageView1.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 19),
//                    lab1.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -26),
                imageView1.topAnchor.constraint(equalTo: safe.topAnchor, constant: 50),
            ])
        }
        
        let font = UIFont.systemFont(ofSize: 15)
        
        aRect.size.width = 300
        aRect.size.height = 30
        let lab1 = UITextView(frame: aRect)
        lab1.tag = 101
        lab1.font = font
        lab1.backgroundColor = .clear
        lab1.text = "It's great because ..."
        lab1.textColor = UIColor.lightGray
        lab1.delegate = self
        self.view.addSubview(lab1)
//        lab1.isEditable = false
        self.positiveTV = lab1
        
        do {
            lab1.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                lab1.heightAnchor.constraint(equalToConstant: 100),
                lab1.leadingAnchor.constraint(equalTo: imageView1.trailingAnchor, constant: 10),
                lab1.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -20),
                lab1.topAnchor.constraint(equalTo: imageView1.topAnchor, constant: -10),
            ])
        }
        
        aRect.size.width = 300
        aRect.size.height = 30
        let image2 = UIImage(named: "negetiveIcon")
        let imageView2 = UIImageView(image: image2)
        imageView2.tag = 1020
        self.view.addSubview(imageView2)
        
        do {
            imageView2.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
//                    lab1.heightAnchor.constraint(equalToConstant: 19),
                imageView2.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 19),
//                    lab1.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -26),
                imageView2.topAnchor.constraint(equalTo: imageView1.bottomAnchor, constant: 120),
            ])
        }
        
        aRect.size.width = 300
        aRect.size.height = 30
        let lab2 = UITextView(frame: aRect)
        lab2.tag = 102
        lab2.font = font
        lab2.backgroundColor = .clear
        lab2.text = "It could be better if ..."
        lab2.textColor = UIColor.lightGray
        lab2.delegate = self
        
        self.view.addSubview(lab2)
//        lab2.isEditable = false
        self.negativeTV = lab2
        
        do {
            lab2.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                lab2.heightAnchor.constraint(equalToConstant: 100),
                lab2.leadingAnchor.constraint(equalTo: imageView2.trailingAnchor, constant: 10),
                lab2.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -20),
                lab2.topAnchor.constraint(equalTo: imageView2.topAnchor, constant: -10),
            ])
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let isEmpty = self.positiveTV?.text.isEmpty, isEmpty == true {
            self.positiveTV?.text = "It's great because ..." // Placeholder
            self.positiveTV?.textColor = UIColor.lightGray
        }
        
        if let isEmpty = self.negativeTV?.text.isEmpty, isEmpty == true {
            self.negativeTV?.text = "It could be better if ..." // Placeholder
            self.negativeTV?.textColor = UIColor.lightGray
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
        
        postButton.addTarget(self, action: #selector(postFeedBack), for: .touchUpInside)
        
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
    
    var subject: Subject?
    
    /// 发送
    ///
    /// 保护条件
    /// - 不能为空
    @objc func postFeedBack() {
        var feedback = FeedBack()
        feedback.id_subject = self.subject?.id_subject
        feedback.postTime = Int(Date().timeIntervalSince1970)
        
        feedback.positive = self.positiveTV?.text
        feedback.negative = self.negativeTV?.text
        
        feedback.postTime = Int(Date().timeIntervalSince1970)

        if DAOOfMelfNote.insertNewFeedback(feedback) == true {
            print("postFeedBack 数据库存储成功")
            
            // 发送通知，更新
            NotificationCenter.default.post(name: .hasPostNewFeedBack, object: self)
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
