//
//  QuestionCell.swift
//  aStackView
//
//  Created by Коноплев Андрей on 06/02/2019.
//  Copyright © 2019 Коноплев Андрей. All rights reserved.
//

import UIKit

protocol QuestionResolveDelegate {
    func didResolve(question: String, answer: String, indexPath: IndexPath)-> Void
}

class QuestionCell: UICollectionViewCell {
    
    var delegate: QuestionResolveDelegate!
    var indexCell: IndexPath!
    
    func configure(question: String, answer: String, indexPath: IndexPath, delegate: QuestionResolveDelegate) {
        self.delegate = delegate
        self.indexCell = indexPath
        setupStackView()
        self.backgroundColor = UIColor.green
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
        
        self.contentView.addSubview(mainStack)
        //mainStack.autoPinEdgesToSuperviewMargins(with: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        mainStack.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        mainStack.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        mainStack.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        
        //bottom stack view
        let bottomStack = UIStackView()
        bottomStack.axis = .vertical
        bottomStack.distribution = .fill
        bottomStack.spacing = 10
        mainStack.addArrangedSubview(bottomStack)
        
        let answer1 = AnswerView(frame: .zero, text: "Амстердам", delegate: self)
        let answer2 = AnswerView(frame: .zero, text: "Москва", delegate: self)
        let answer3 = AnswerView(frame: .zero, text: "Какой нибудь другой город с огромным количеством текста и все такое  dfa dsaf dsaf sfdf sdfgh dh fj trjrfhg dfsdg fsdg sfg wdfh gfdh gdsf gdsfdf erfadsf dasf sdaf ewqfasdf dsaf sdafesadf asdf sadf sadg dsaf sdaf dsaf sdaf dsaf erwfggchdfsaf dsaf adsfasdf", delegate: self)
        
        bottomStack.addArrangedSubview(answer1)
        bottomStack.addArrangedSubview(answer2)
        bottomStack.addArrangedSubview(answer3)
    }
}

extension QuestionCell: AnswerViewDelegate {
    func didSelect(answer: String, question: String) {
        print("Ответ- \(answer)")
        print("Вопрос - \(question)")
        self.delegate.didResolve(question: question, answer: answer, indexPath: self.indexCell)
    }
}
