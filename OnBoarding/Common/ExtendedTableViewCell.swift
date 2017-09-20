//
//  ExtendedTableViewCell.swift
//  OnBoarding
//
//  Created by mmaalej on 19/09/2017.
//  Copyright © 2017 mmaalej. All rights reserved.
//

import UIKit

class ExtendedTableViewCell: UITableViewCell, TableViewCellProtocols {
    static var staticMetrics: CellMetrics = CellMetrics(topAnchor: 15.0, leftAnchor: 15.0, bottomAnchor: 15.0, rightAnchor: 15.0)
    static let height: CGFloat =  ExtendedCellContentView.dummy.view.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height + staticMetrics.topAnchor + staticMetrics.bottomAnchor
    
    var cellView: CellViewProtocol = ExtendedCellContentView()
    
    var data: (title: String?, description: String?, details: String?, icon: UIImage?)? {
        didSet {
            (cellView as! ExtendedCellContentView).data = (title: data?.title, description: data?.description, details: data?.details, icon: data?.icon)
        }
    }

    //MARK:- Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Layout
    func layout() {
        cellView.view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(cellView.view)
        cellView.view.topAnchor.constraint(equalTo:self.topAnchor, constant: metrics.topAnchor).isActive = true
        cellView.view.leftAnchor.constraint(equalTo:self.leftAnchor, constant: metrics.leftAnchor).isActive = true
        cellView.view.rightAnchor.constraint(equalTo:self.rightAnchor, constant: -metrics.rightAnchor).isActive = true
        cellView.view.bottomAnchor.constraint(equalTo:self.bottomAnchor, constant: -metrics.rightAnchor).isActive = true
    }
    
}

class ExtendedCellContentView: UIView, CellViewProtocol {
    //MARK:- Properties
    static var dummy: CellViewProtocol = {
        let view = ExtendedCellContentView()
        view.data = (title: "title", description: "description", details: "details", icon: nil)
        return view
    }()
    
    var data: (title: String?, description: String?, details: String?, icon: UIImage?)? {
        didSet {
            titleLbl.text = data?.title
            descriptionLbl.text = data?.description
            detailsLbl.text = data?.details
            iconImgV.image = data?.icon
        }
    }
    
    let titleLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let descriptionLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let detailsLbl: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    let iconImgV: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK:- Layout
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    //MARK:- Inits
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Layout
    func layout() {
        let views: [String: UIView] = ["title": titleLbl, "description": descriptionLbl, "details": detailsLbl, "icon": iconImgV]
        for (_, view) in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
        
        var layoutConstraints: [NSLayoutConstraint] = []
        
        layoutConstraints +=  NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[icon(40)]-(10)-[title]-(10)-[details]-(0)-|", options: [], metrics: nil, views: views)
        layoutConstraints +=  NSLayoutConstraint.constraints(withVisualFormat: "H:[description]-(0)-|", options: [], metrics: nil, views: views)
        layoutConstraints +=  NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[icon(40)]", options: [], metrics: nil, views: views)
        layoutConstraints +=  NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[title]-(5)-[description]-(0)-|", options: [], metrics: nil, views: views)
        layoutConstraints += [
            descriptionLbl.leftAnchor.constraint(equalTo: titleLbl.leftAnchor),
            detailsLbl.topAnchor.constraint(equalTo: titleLbl.topAnchor)
        ]
        NSLayoutConstraint.activate(layoutConstraints)

    }
}
