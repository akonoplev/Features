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
    
    var scrollView: UIScrollView?
    var mainStack: UIStackView?
    
    func configure(question: String, answer: String, indexPath: IndexPath, delegate: QuestionResolveDelegate) {
        self.scrollView = nil
        self.mainStack = nil
        self.delegate = delegate
        self.indexCell = indexPath
        setupStackView()
        self.backgroundColor = UIColor.green
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let scrollView = self.scrollView, let mainStack = self.mainStack else { return }
        scrollView.contentSize = CGSize(width: mainStack.frame.width, height: mainStack.frame.height + 30)
        scrollView.scrollsToTop = true
       // print(scrollView.contentSize)
    }

    
    func setupStackView()-> Void {
        self.scrollView = UIScrollView()
        self.mainStack = UIStackView()
        
        guard let scrollView = self.scrollView, let mainStack = self.mainStack else { return }
        scrollView.delegate = self
        
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //scrollView.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    
        
        //init main stack
        mainStack.backgroundColor = UIColor.red
        mainStack.axis = .vertical
        mainStack.distribution = .fill
        mainStack.spacing = 10
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        //bottom stack view
        let bottomStack = UIStackView()
        bottomStack.axis = .vertical
        bottomStack.distribution = .fill
        bottomStack.spacing = 10
        mainStack.addArrangedSubview(bottomStack)
        
        let answer1 = AnswerView(frame: .zero, text: "Амстердам авып авып авып ваып авып авып авыпавып авып ваып ваып ваыпаып ваып авыпаып авып ывапаып выапавып ыавп ывап ывап ыавп выапваы", delegate: self)
        let answer2 = AnswerView(frame: .zero, text: "Москва ыапвы авпавып ваы павып ваып ыавп авып авып авып авып авып авып авып аывп авып аып выап выап авып аып  выап авып аывп аывп авып авып авы паыв паывп авып апыав пыавп ав", delegate: self)
        let answer3 = AnswerView(frame: .zero, text: "Какой нибудь другой город с огромным количеством текста и все такое  dfa dsaf dsaf sfdf sdfgh dh fj trjrfhg dfsdg fsdg sfg wdfh gfdh gdsf gdsfdf erfadsf dasf sdaf ewqfasdf dsaf sdafesadf asdf sadf sadg dsaf sdaf dsaf sdaf dsaf erwfkjggff f ddd d dd d d dfh hkgr   g ggg gg  g  g ggg ggg g g g gg  g gg  g g g h hgg g j jk gf fggchdfsaf dsaf adsfasdf", delegate: self)
        
        bottomStack.addArrangedSubview(answer1)
        bottomStack.addArrangedSubview(answer2)
        bottomStack.addArrangedSubview(answer3)
        // stack height
        

        scrollView.addSubview(mainStack)
        
        scrollView.backgroundColor = UIColor.brown
        self.contentView.addSubview(scrollView)
        
        scrollView.autoPinEdge(toSuperviewEdge: .leading, withInset: 5)
        scrollView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 5)
        scrollView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        scrollView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        
        mainStack.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        mainStack.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        mainStack.autoPinEdge(toSuperviewEdge: .top, withInset: 20)

        
        mainStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        self.layoutIfNeeded()
        self.layoutSubviews()
        
    }
}

extension QuestionCell: AnswerViewDelegate {
    func didSelect(answer: String, question: String) {
        print("Ответ- \(answer)")
        print("Вопрос - \(question)")
        self.delegate.didResolve(question: question, answer: answer, indexPath: self.indexCell)
    }
}

extension QuestionCell: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
}
