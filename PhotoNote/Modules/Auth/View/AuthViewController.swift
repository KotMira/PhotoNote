//
//  AuthViewController.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 22/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    var presenter: AuthPresenterProtocol!
    var configurator: AuthConfiguratorProtocol = AuthConfigurator()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var signInButton = UIButton()
    var registerButton = UIButton()
    var signOutButton = UIButton()
    var deleteAccButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        setupInitialState()
    }
}

extension AuthViewController {
    
    private func setupInitialState() {
        view.backgroundColor = UIColor.systemTeal
        configureEmailTextField()
        configurePasswordTextField()
        buttonBuild(for: signInButton, with: "Sign in", underView: passwordTextField, action: #selector(signInAction))
        buttonBuild(for: registerButton, with: "Register", underView: signInButton, action: #selector(registerUserAction))
        buttonBuild(for: signOutButton, with: "Sign out", underView: registerButton, action: #selector(signOutAction))
        buttonBuild(for: deleteAccButton, with: "Delete account", underView: signOutButton, action: #selector(deleteAccountAction))
        hideKeyboardForView()
    }
    
    private func configureEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.constraintToParentWithHeight(left: 35, right: -35, top: 150, height: 45)
        emailTextField.backgroundColor = .lightGray
        emailTextField.font = UIFont.systemFont(ofSize: 25)
        emailTextField.placeholder = "Email"
    }
    
    private func configurePasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.constraintUnderParent(view: emailTextField, left: 35, right: -35, top: 45, height: 45)
        passwordTextField.backgroundColor = .lightGray
        passwordTextField.font = UIFont.systemFont(ofSize: 25)
        passwordTextField.placeholder = "Password"
    }
    
    private func buttonBuild(for button: UIButton, with title: String, underView: UIView, action: Selector) {
        view.addSubview(button)
        button.constraintUnderParent(view: underView, left: 85, right: -85, top: 30, height: 45)
        button.backgroundColor = .darkGray
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.clipsToBounds = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    @objc func signInAction() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        presenter.authUser(email: email, password: password)
    }
    
    @objc func registerUserAction() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        presenter.createUser(email: email, password: password)
    }
    
    @objc func signOutAction() {
        presenter.singOutUser()
    }
    
    @objc func deleteAccountAction() {}
    
    
    func hideKeyboardForView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
}
