//
//  ViewController.swift
//  AnimationsPractice
//
//  Created by Benjamin Stone on 10/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Lazy Objects
    lazy var blueSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var buttonStackView: UIStackView = {
       let buttonStack = UIStackView(arrangedSubviews: [upButton, downButton, leftButton])
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 10
        return buttonStack
    }()
    
    lazy var upButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareUp(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var downButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square down", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareDown(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var leftButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square left", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareLeft(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var animationDurationStepper: UIStepper = {
       let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.addTarget(self, action: #selector(stepperAnimationDurationChanged), for: .valueChanged)
        return stepper
    }()
    
    // MARK: - UI Lazy Constraints
    
    lazy var blueSquareHeightConstaint: NSLayoutConstraint = {
        blueSquare.heightAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareWidthConstraint: NSLayoutConstraint = {
        blueSquare.widthAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareCenterXConstraint: NSLayoutConstraint = {
        blueSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }()
    
    lazy var blueSquareCenterYConstraint: NSLayoutConstraint = {
        blueSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }()
    
    // MARK: - Private Properties
    private var animationDuration: TimeInterval = 2
    
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
    }

    // MARK: - UI Action Methods
    @objc func animateSquareUp(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffset - 150
        UIView.animate(withDuration: animationDuration) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func animateSquareDown(sender: UIButton) {
        let oldOffet = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffet + 150
        UIView.animate(withDuration: animationDuration) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func animateSquareLeft(sender: UIButton) {
        let oldOffset = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffset - 100
        UIView.animate(withDuration: animationDuration) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func stepperAnimationDurationChanged(sender: UIStepper) {
        let stepperValue = sender.value
        animationDuration += stepperValue
    }
    
    // MARK: - UI Constraint Methods
    private func addSubviews() {
        view.addSubview(blueSquare)
        addStackViewSubviews()
        view.addSubview(buttonStackView)
        view.addSubview(animationDurationStepper)
    }
    
    private func addStackViewSubviews() {
        buttonStackView.addSubview(upButton)
        buttonStackView.addSubview(downButton)
        buttonStackView.addSubview(leftButton)
    }
    
    private func configureConstraints() {
        constrainBlueSquare()
//        constrainUpButton()
//        constrainDownButton()
//        constrainLeftButton()
        constrainButtonStackView()
        constrainAnimationDurationStepper()
    }
    
//    private func constrainUpButton() {
//        upButton.translatesAutoresizingMaskIntoConstraints = false
//        upButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        upButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor).isActive = true
//    }
//
//    private func constrainDownButton() {
//        downButton.translatesAutoresizingMaskIntoConstraints = false
//        downButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
//
//    private func constrainLeftButton() {
//        leftButton.translatesAutoresizingMaskIntoConstraints = false
//        downButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
    
    private func constrainBlueSquare() {
        blueSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueSquareHeightConstaint,
            blueSquareWidthConstraint,
            blueSquareCenterXConstraint,
            blueSquareCenterYConstraint
        ])
    }
    
    private func constrainButtonStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func constrainAnimationDurationStepper() {
        animationDurationStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationDurationStepper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationDurationStepper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            animationDurationStepper.heightAnchor.constraint(equalToConstant: 50),
            animationDurationStepper.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}


