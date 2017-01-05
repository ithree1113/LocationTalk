//
//  LoginView.swift
//  LocationTalk
//
//  Created by 鄭宇翔 on 2017/1/5.
//  Copyright © 2017年 鄭宇翔. All rights reserved.
//

import UIKit

protocol LoginViewProtocol: class {
    func didLoginButtonPressed(email: String?, password: String?)
}

fileprivate extension Selector {
    static let loginButtonPressed = #selector(LoginView.loginButtonPressed)
}

@IBDesignable
class LoginView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.addTarget(self, action:.loginButtonPressed, for: .touchUpInside)
        }
    }
    weak var delegate: LoginViewProtocol?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib(){

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LoginView", bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.contentView.frame = bounds
        self.addSubview(contentView)
    }
    
    @objc fileprivate func loginButtonPressed() {
        let email = self.emailInput.text
        let password = self.passwordInput.text
        
        self.delegate?.didLoginButtonPressed(email: email, password: password)
    }
}
