//
//  AboutViewController.swift
//  EpubReader
//
//  Created by mac on 26/09/2022.
//

import UIKit
import WebKit
import SnapKit

class AboutViewController: BaseViewController {
    
    var frameHeight: CGFloat = UIScreen.main.bounds.height
    var frameWidth: CGFloat = UIScreen.main.bounds.width
    
    private lazy var swipeView: UIView = {
        let swipeView = UIView()
        swipeView.backgroundColor = UIColor(hex: "#CECECE")
        swipeView.layer.cornerRadius = 3
        return swipeView
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.scrollView.isScrollEnabled = true
        webView.contentMode = .scaleAspectFit
        webView.isOpaque = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.backgroundColor = UIColor(hex: "#f2f2f6")
        webView.scrollView.backgroundColor = UIColor(hex: "#f2f2f6")
        return webView
    }()
    
    private lazy var buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var sendEmailButton: UIButton = {
       let emailButton = UIButton()
        emailButton.backgroundColor = UIColor.color(with: .background)
        emailButton.tintColor = UIColor.color(with: .background)
        emailButton.setTitle("Gửi Email", for: .normal)
        emailButton.layer.borderWidth = 1
        emailButton.layer.cornerRadius = 24
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        return emailButton
    }()
    
    private lazy var versionLabel: UILabel = {
        let versionLabel = UILabel()
        versionLabel.textColor = UIColor.black
        versionLabel.backgroundColor = .clear
        versionLabel.numberOfLines = 1
        versionLabel.textAlignment = .center
        versionLabel.sizeToFit()
        versionLabel.font = UIFont.font(with: .h4)
        versionLabel.text = "Phiên bản 1.0.0"
        return versionLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraint()
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor(hex: "#f2f2f6")
        
        self.view.addSubview(swipeView)
        self.view.addSubview(webView)
        self.view.addSubview(buttonView)
        
        buttonView.addSubview(sendEmailButton)
        buttonView.addSubview(versionLabel)

        let htmlFile = Bundle.main.path(forResource: "aboutus", ofType: "html")
        let html = try! String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        self.webView.loadHTMLString(html, baseURL: nil)
    }
    
    private func setupConstraint() {
        let buttonViewHeight = frameHeight / 4 - 24
        let buttonViewTop = frameHeight - buttonViewHeight
        
        swipeView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(6)
            make.width.equalTo(192)
            make.centerX.equalToSuperview()
        }
        
        webView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(10)
            make.top.equalTo(swipeView.snp.bottom).offset(4)
            make.size.equalToSuperview()
        }
        
        buttonView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(buttonViewTop)
            make.size.equalTo(CGSize(width: frameWidth, height: buttonViewHeight))
        }
        
        sendEmailButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(48)
            make.size.equalTo(CGSize(width: frameWidth/2, height: 48))
        }
        
        versionLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(sendEmailButton.snp.bottom).offset(32)
            make.size.equalTo(CGSize(width: frameWidth/2, height: 32))
        }
    }
    
    @objc func emailButtonTapped() {
        print("send email click")
    }
}
