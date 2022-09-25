//
//  SearchCatalogView.swift
//  MelfNoteSharing
//
//  Created by 范志勇 on 2022/9/25.
//

import UIKit

class SearchCatalogView: UIView {

    var name: String? {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    private var label: UILabel?
    private var imageView: UIImageView?

    init(frame: CGRect, name: String) {
        super.init(frame: frame)
        self.name = name
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        self.label?.isHidden = true
        self.label?.removeFromSuperview()
        self.imageView?.isHidden = true
        self.imageView?.removeFromSuperview()

        // Drawing code
        let aRect = CGRect(x: 0, y: 0, width: 40, height: 31)
        let label = UILabel(frame: aRect)
        label.text = self.name
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(label)
        self.label = label
        self.label?.isHidden = false
        
        let image = UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.frame.origin.x = label.bounds.width + 10
        imageView.center.y = label.center.y
        self.addSubview(imageView)
        self.imageView = imageView
        self.imageView?.isHidden = false
    }
    

}
