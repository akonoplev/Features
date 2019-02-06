//
//  StacksViewController.swift
//  aStackView
//
//  Created by Коноплев Андрей on 05/02/2019.
//  Copyright © 2019 Коноплев Андрей. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class StacksViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        setupUI()
    }
    
    func setupUI()-> Void {
        setupStackView()
    }
    
    func setupStackView() {
        
        //init main stack
        let mainStack = UIStackView()
        mainStack.backgroundColor = UIColor.red
        mainStack.axis = .vertical
        mainStack.distribution = .fill
        mainStack.spacing = 10
        
        //init question view with Label
        let view = UIView()
        let label = UILabel()
        label.text = "В каком году был открыт первый порнотеатр в Амстердаме?"
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = .center
        view.addSubview(label)
        label.autoPinEdgesToSuperviewMargins(with: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        view.backgroundColor = UIColor.red
        
        mainStack.addArrangedSubview(view)
        
        self.view.addSubview(mainStack)
        //mainStack.autoPinEdgesToSuperviewMargins(with: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        mainStack.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        mainStack.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        mainStack.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        
        //bottom stack view
        let bottomStack = UIStackView()
        bottomStack.axis = .vertical
        bottomStack.distribution = .fill
        mainStack.addArrangedSubview(bottomStack)
        
        let answer1 = AnswerView(frame: .zero, text: "Амстердам")
        let answer2 = AnswerView(frame: .zero, text: "Москва")
        let answer3 = AnswerView(frame: .zero, text: "Какой нибудь другой город с огромным количеством текста и все такое  dfa dsaf dsaf sfdf sdfgh dh fj trjrfhg dfsdg fsdg sfg wdfh gfdh gdsf gdsfdf erfadsf dasf sdaf ewqfasdf dsaf sdafesadf asdf sadf sadg dsaf sdaf dsaf sdaf dsaf erwfggchdfsaf dsaf adsfasdf")
        
        bottomStack.addArrangedSubview(answer1)
        bottomStack.addArrangedSubview(answer2)
        bottomStack.addArrangedSubview(answer3)
        
    }
}

class AnswerView: UIView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(frame: CGRect, text: String) {
        super.init(frame: frame)
        commonInit(text: text)
    }
    
    override func layoutSubviews() {
        self.layoutSubviews()
    }
    
    func commonInit(text: String)-> Void {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        
        //label
        self.label.text = text
        self.label.textAlignment = .left
        self.label.textColor = UIColor.black
        self.label.numberOfLines = 0
        self.addSubview(label)
        
        self.label.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        self.label.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        self.label.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        self.label.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
    }
}
