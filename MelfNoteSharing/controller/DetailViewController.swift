//
//  DetailViewController.swift
//  MelfNoteSharing
//
//  Created by 范志勇 on 2022/9/26.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: 隐藏状态栏
    override var prefersStatusBarHidden: Bool { return true }
    
    // 入参：subject
    var subject: Subject?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black

        // Do any additional setup after loading the view.
        // 加载数据
        self.loadData()

        // 导航栏
        self.createNavigatorBar()
        
        // subject info
        self.createSubjectView()
        
        // tableview feedback
        self.createTableView()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // 新增按钮
        self.createFeedBackButton()
        
        // 接收通知
//        NotificationCenter.default.addObserver(self, selector: #selector(updateInfo), name: .hasPostNewSubject, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(updateInfo), name: .hasPostNewFeedBack, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backgroundColor = .black
    }

    
    @objc func updateInfo() {
        // 加载数据：feedback
        self.loadData()
        
        // 刷新
        self.tableView.reloadData()
    }
    
    /// 新增按钮
    func createFeedBackButton() {
        let aRect = CGRect(x: 0, y: 0, width: 414, height: 342)
        let newButton = UIButton(frame: aRect)
        newButton.setImage(UIImage(named: "feedback"), for: .normal)
        self.view.addSubview(newButton)
        
        newButton.addTarget(self, action: #selector(newFeedBack), for: .touchUpInside)
        
        newButton.translatesAutoresizingMaskIntoConstraints = false
        // 1.1 heightAnchor可以再优化
        let safe = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            newButton.widthAnchor.constraint(equalToConstant: 100),
            newButton.heightAnchor.constraint(equalToConstant: 100),
            newButton.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -100),
            newButton.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -30),
        ])
    }
    
    @objc func newFeedBack() {
        let vc = NewFeedBackViewController()
        vc.title = "New FeedBack"
        vc.subject = self.subject
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // search type: New, Hot
    var searchCatalogView: SearchCatalogView?

    /// 导航栏
    ///
    /// 分两个部分
    /// 1. 左侧：排序方式
    /// 2. 右侧：搜索，用户
    /// 导航栏菜单
    func createNavigatorBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationItem.title = ""
        
        /*
        var image = UIImage(systemName: "person.fill")
        
        let aRect = CGRect(x: 0, y: 0, width: 150, height: 30)
        let searchCatalogView =  SearchCatalogView(frame: aRect, name: "New")
        searchCatalogView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapSearchType))
        searchCatalogView.addGestureRecognizer(tap)
        self.searchCatalogView = searchCatalogView
        
        let searchType_item = UIBarButtonItem(customView: searchCatalogView)
        self.navigationItem.leftBarButtonItem = searchType_item
        
        // ===== 右侧
        image = UIImage(systemName: "person.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        let user_item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(toUser))
        
        image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        let search_item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(toSearch))
        
        // 加大间距
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 20 // adjust as needed

        self.navigationItem.rightBarButtonItems = [space, user_item, space, search_item]
        */
    }
    
    @objc func tapSearchType() {
        DispatchQueue.main.async {
            self.searchCatalogView?.isHidden = true
            if self.searchCatalogView?.name == "New" {
                self.searchCatalogView?.name = "Hot"
            } else {
                self.searchCatalogView?.name = "New"
            }
            self.searchCatalogView?.isHidden = false
        }
    }
    
    @objc func toUser() {
        
    }
    
    @objc func toSearch() {
        
    }
    
    var allFeedBacks = [FeedBack]()
    /// 加载数据
    ///
    /// 策略
    /// 1. 临时加载：数据类中人工生成
    /// 2. 数据库
    func loadData() {
//        self.allFeedBacks = FeedBack.createData()
        
        self.allFeedBacks = [FeedBack]()

        if let feedbacks = DAOOfMelfNote.searchAllMelfFeedBacks(id_subject: (self.subject?.id_subject)!) {
            self.allFeedBacks = feedbacks
        }
        
    }
    
    let leading = CGFloat(20) // 37
    let trailing = CGFloat(-20) // -40
    /// subject
    ///
    /// 包括3个部分
    /// 1. 行业
    /// 2. title
    /// 3. description
    func createSubjectView() {
        let font = UIFont.systemFont(ofSize: 19)
        var aRect = CGRect(x: 8, y: 15, width: 120, height: 30)

        aRect.size.width = 300
        aRect.size.height = 30
        let lab1 = UILabel(frame: aRect)
        lab1.tag = 101
        lab1.font = font
        lab1.backgroundColor = .clear
        var str = "# "
        if let catalog = self.subject?.catalog {
            str += catalog
        }
        lab1.text = str
        lab1.textColor = UIColor.white
        self.view.addSubview(lab1)
        
        let safe = self.view.safeAreaLayoutGuide
        
        do {
            lab1.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                lab1.heightAnchor.constraint(equalToConstant: 19),
                lab1.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: leading),
                lab1.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: trailing),
                lab1.topAnchor.constraint(equalTo: safe.topAnchor, constant: 12),
            ])
        }
        
        aRect.origin.y += 20
        aRect.size.width = 300
        aRect.size.height = 30
        let lab2 = UILabel(frame: aRect)
        lab2.tag = 102
        lab2.font = font
        lab2.backgroundColor = .clear
        str = "Title"
        if let title = self.subject?.title {
            str = title
        }
        lab2.text = str
        lab2.textColor = UIColor.white
        lab2.font = UIFont.systemFont(ofSize: 24)
        lab2.numberOfLines = 2
        lab2.textAlignment = .left
        self.view.addSubview(lab2)
        
//        let safe = self.view.safeAreaLayoutGuide
        
        do {
            lab2.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                lab2.heightAnchor.constraint(equalToConstant: 24),
                lab2.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: leading),
                lab2.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: trailing),
                lab2.topAnchor.constraint(equalTo: lab1.bottomAnchor, constant: 14),
            ])
        }
        
        aRect.origin.y += 20
        aRect.size.width = 300
        aRect.size.height = 30
        let lab3 = UITextView(frame: aRect)
        lab3.tag = 102
        lab3.font = UIFont.systemFont(ofSize: 12)
        lab3.backgroundColor = .clear
        str = "Description"
        if let description = self.subject?.description {
            str = description
        }
        lab3.text = str
        lab3.textColor = UIColor.white
        lab3.textAlignment = .left
        self.view.addSubview(lab3)
        
        lab3.isEditable = false
        
        do {
            lab3.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                lab3.heightAnchor.constraint(equalToConstant: 75),
                lab3.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: leading),
                lab3.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: trailing),
                lab3.topAnchor.constraint(equalTo: lab2.bottomAnchor, constant: 17),
            ])
        }
        
        self.descriptionTV = lab3
    }
    
    var descriptionTV: UITextView?
    
    var tableView: UITableView!
    
    /// 左侧区域：创建表单
    ///
    /// 宽度：0.3
    func createTableView() {
        let aRect = CGRect(x: 0, y: 0, width: 414, height: 342)
        self.tableView = UITableView(frame: aRect)
        self.tableView.backgroundColor = .black
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        // 1.1 heightAnchor可以再优化
        let safe = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.descriptionTV!.bottomAnchor, constant: 16),
            self.tableView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -8),
            self.tableView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: 0),
//            self.tableView.widthAnchor.constraint(equalTo: safe.widthAnchor, multiplier: 0.3),
        ])
        
        // 去掉行线
        self.tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 行高动态变化
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allFeedBacks.count
    }
    
    let cellID = "cellID"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath)
        
        cell.accessoryType = .none
        
        let y_center = CGFloat(25)
        if cell.viewWithTag(101) == nil {
            let font = UIFont.systemFont(ofSize: 12)
            var aRect = CGRect(x: 8, y: 15, width: 120, height: 30)
            
            let backView = UIView(frame: aRect)
            backView.backgroundColor = .black
            backView.tag = 100
            backView.layer.borderWidth = 1
            backView.layer.borderColor = UIColor.white.cgColor
            backView.layer.cornerRadius = 15
            cell.contentView.addSubview(backView)
            
            do {
                let safe = cell.contentView.safeAreaLayoutGuide
                backView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    backView.heightAnchor.constraint(equalToConstant: 178),
                    backView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: leading),
                    backView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: trailing),
                    backView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
                ])
            }
            
            let gap: CGFloat = 8
            
            aRect.size.width = 300
            aRect.size.height = 30
            let image1 = UIImage(named: "positiveIcon")
            let imageView1 = UIImageView(image: image1)
            imageView1.tag = 1010
            backView.addSubview(imageView1)
            
            let safe = backView.safeAreaLayoutGuide
            
            do {
                imageView1.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
//                    lab1.heightAnchor.constraint(equalToConstant: 19),
                    imageView1.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 19),
//                    lab1.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -26),
                    imageView1.topAnchor.constraint(equalTo: safe.topAnchor, constant: 32),
                ])
            }
            
            aRect.size.width = 300
            aRect.size.height = 30
            let lab1 = UITextView(frame: aRect)
            lab1.tag = 101
            lab1.font = font
            lab1.backgroundColor = .clear
            lab1.text = "Refrigerated car trunks with a freezer section in bigger vehicles like SUVs."
            lab1.textColor = UIColor.white
            backView.addSubview(lab1)
            lab1.isEditable = false
            
            do {
                lab1.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    lab1.heightAnchor.constraint(equalToConstant: 60),
                    lab1.leadingAnchor.constraint(equalTo: imageView1.trailingAnchor, constant: 10),
                    lab1.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -20),
                    lab1.centerYAnchor.constraint(equalTo: imageView1.centerYAnchor, constant: 0),
                ])
            }
            
            aRect.size.width = 300
            aRect.size.height = 30
            let image2 = UIImage(named: "negetiveIcon")
            let imageView2 = UIImageView(image: image2)
            imageView2.tag = 1020
            backView.addSubview(imageView2)
            
            do {
                imageView2.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
//                    lab1.heightAnchor.constraint(equalToConstant: 19),
                    imageView2.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 19),
//                    lab1.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -26),
                    imageView2.topAnchor.constraint(equalTo: imageView1.bottomAnchor, constant: 40),
                ])
            }
            
            aRect.size.width = 300
            aRect.size.height = 30
            let lab2 = UITextView(frame: aRect)
            lab2.tag = 102
            lab2.font = font
            lab2.backgroundColor = .clear
            lab2.text = "Ideal for transportation of groceries requiring refrigeration, while in transit from supermarket to home."
            lab2.textColor = UIColor.white
            backView.addSubview(lab2)
            lab2.isEditable = false
            
            do {
                lab2.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    lab2.heightAnchor.constraint(equalToConstant: 60),
                    lab2.leadingAnchor.constraint(equalTo: imageView2.trailingAnchor, constant: 10),
                    lab2.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -20),
                    lab2.centerYAnchor.constraint(equalTo: imageView2.centerYAnchor, constant: 0),
                ])
            }
            
        }
        
        let feedBack = self.allFeedBacks[indexPath.row]
        
//        let safe = cell.contentView.safeAreaLayoutGuide
        
        do {
            let lab = cell.contentView.viewWithTag(101) as! UITextView
            lab.text = String(feedBack.positive!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(102) as! UITextView
            lab.text = String(feedBack.negative!)
        }
        
        cell.contentView.backgroundColor = .black
        
        return cell
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
