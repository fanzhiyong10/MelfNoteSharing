//
//  MainViewController.swift
//  MelfNoteSharing
//
//  Created by 范志勇 on 2022/9/25.
//

import UIKit



class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: 隐藏状态栏
    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        // Do any additional setup after loading the view.
        // 加载数据
        self.loadData()

        // 导航栏
        self.createNavigatorBar()
        
        // 表单
        self.createTableView()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // 新增按钮
        self.createPlusButton()
    }
    
    /// 新增按钮
    func createPlusButton() {
        let aRect = CGRect(x: 0, y: 0, width: 414, height: 342)
        let newButton = UIButton(frame: aRect)
        newButton.setImage(UIImage(named: "plus"), for: .normal)
        self.view.addSubview(newButton)
        
        newButton.addTarget(self, action: #selector(newSubject), for: .touchUpInside)
        
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
    
    @objc func newSubject() {
        let vc = NewSubjectViewController()
        vc.title = "New Subject"
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
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.title = ""
        
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
    
    var allSubjects = [Subject]()
    /// 加载数据
    ///
    /// 策略
    /// 1. 临时加载：数据类中人工生成
    /// 2. 数据库
    func loadData() {
        self.allSubjects = Subject.createData()
    }
    
    var tableView: UITableView!
    
    /// 左侧区域：创建表单
    ///
    /// 宽度：0.3
    func createTableView() {
        let aRect = CGRect(x: 0, y: 0, width: 414, height: 342)
        self.tableView = UITableView(frame: aRect)
        self.tableView.backgroundColor = .white
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        // 1.1 heightAnchor可以再优化
        let safe = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
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
        return 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allSubjects.count
    }
    
    let cellID = "cellID"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath)
//        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//
//        cell.separatorInset = UIEdgeInsets.zero
        
//        cell.textLabel!.text = self.allProducts[indexPath.row].localizedTitle
        
        cell.accessoryType = .none
        
        let y_center = CGFloat(25)
        if cell.viewWithTag(101) == nil {
            let font = UIFont.systemFont(ofSize: 19)
            var aRect = CGRect(x: 8, y: 15, width: 120, height: 30)
            
            let backView = UIView(frame: aRect)
            backView.backgroundColor = .black
            backView.tag = 100
            backView.layer.cornerRadius = 15
            cell.contentView.addSubview(backView)
            
            do {
                let safe = cell.contentView.safeAreaLayoutGuide
                backView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    backView.heightAnchor.constraint(equalToConstant: 160),
                    backView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 20),
                    backView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -20),
                    backView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
                ])
            }
            
            let gap: CGFloat = 8
            
            aRect.size.width = 300
            aRect.size.height = 30
            let lab1 = UILabel(frame: aRect)
            lab1.tag = 101
            lab1.font = font
            lab1.backgroundColor = .clear
            lab1.text = "# automotive"
            lab1.textColor = UIColor.white
            backView.addSubview(lab1)
            
            let safe = backView.safeAreaLayoutGuide
            
            do {
                lab1.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    lab1.heightAnchor.constraint(equalToConstant: 19),
                    lab1.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 28),
                    lab1.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -26),
                    lab1.topAnchor.constraint(equalTo: safe.topAnchor, constant: 17),
                ])
            }
            
            do {
                aRect.origin.y += 20
                aRect.size.width = 300
                aRect.size.height = 30
                let lab = UILabel(frame: aRect)
                lab.tag = 102
                lab.font = font
                lab.backgroundColor = .clear
                lab.text = "Refrigerated car trunks"
                lab.textColor = UIColor.white
                lab.font = UIFont.systemFont(ofSize: 24)
                lab.numberOfLines = 2
                lab.textAlignment = .left
                backView.addSubview(lab)
                
                let safe = backView.safeAreaLayoutGuide
                
                do {
                    lab.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        lab.heightAnchor.constraint(equalToConstant: 24),
                        lab.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 28),
                        lab.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -26),
                        lab.topAnchor.constraint(equalTo: lab1.bottomAnchor, constant: 13),
                    ])
                }
            }
            
            aRect.origin.y += 20
            aRect.size.width = 300
            aRect.size.height = 30
            let image = UIImage(systemName: "person.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 15)))?.withTintColor(UIColor.lightGray, renderingMode: .alwaysOriginal)
            let imageView = UIImageView(image: image)
            imageView.tag = 1030
            backView.addSubview(imageView)
            
//            let safe = backView.safeAreaLayoutGuide
            
            do {
                imageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imageView.heightAnchor.constraint(equalToConstant: 15),
                    imageView.widthAnchor.constraint(equalToConstant: 15),
                    imageView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 30),
                    imageView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -20),
                ])
            }
            
            do {
                aRect.origin.y += 20
                aRect.size.width = 300
                aRect.size.height = 30
                let lab = UILabel(frame: aRect)
                lab.tag = 103
                lab.font = UIFont.systemFont(ofSize: 15)
                lab.backgroundColor = .clear
                lab.text = "JohnDoe"
                lab.textColor = UIColor.lightGray
                lab.textAlignment = .left
                backView.addSubview(lab)
                
                let safe = backView.safeAreaLayoutGuide
                
                do {
                    lab.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        lab.heightAnchor.constraint(equalToConstant: 15),
                        lab.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                        lab.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -24),
//                        lab.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -20),
                        lab.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
                    ])
                }
            }
            
            do {
                aRect.origin.x += aRect.width + gap
                aRect.size.width = 300
                aRect.size.height = 30
                let lab = UILabel(frame: aRect)
                lab.tag = 104
                lab.font = font
                lab.backgroundColor = .clear
                lab.text = "101 feedback"
                lab.textColor = UIColor.lightGray
                lab.textAlignment = .right
                backView.addSubview(lab)
                
                let safe = backView.safeAreaLayoutGuide
                
                do {
                    lab.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        lab.heightAnchor.constraint(equalToConstant: 19),
                        lab.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 58),
                        lab.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -26),
//                        lab.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -20),
                        lab.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
                    ])
                }
            }
        }
        
        let subject = self.allSubjects[indexPath.row]
        
//        let safe = cell.contentView.safeAreaLayoutGuide
        
        do {
            let lab = cell.contentView.viewWithTag(101) as! UILabel
            lab.text = "#" + String(subject.catalog!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(102) as! UILabel
            lab.text = String(subject.title!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(103) as! UILabel
            lab.text = String(subject.postMan!)
        }
        
        do {
            let lab = cell.contentView.viewWithTag(104) as! UILabel
            lab.text = String(subject.catalog!)
            if subject.count_feedback == 0 {
                lab.text = ""
            } else {
                lab.text = "\(subject.count_feedback!) feedback"
            }
        }
        
        cell.contentView.backgroundColor = .white
        
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
