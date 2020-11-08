//
//  ViewController.swift
//  WebBrowser
//
//  Created by Alexander Kononok on 11/8/20.
//

import UIKit
import WebKit

class ViewController: UIViewController {

  @IBOutlet weak var navigationView: UIView!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var reloadButton: UIButton!
  @IBOutlet weak var forwardButton: UIButton!
  @IBOutlet weak var webView: WKWebView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let urlGoogle = "https://www.google.com"
    
    webView.alpha = 0
    
    if let url = URL(string: urlGoogle) {
      let urlRequest = URLRequest(url: url)
      webView.load(urlRequest)
    }
    
    webView.navigationDelegate = self
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    backButton.layer.cornerRadius = backButton.frame.height / 2
    reloadButton.layer.cornerRadius = reloadButton.frame.height / 2
    forwardButton.layer.cornerRadius = forwardButton.frame.height / 2
  }
  
  @IBAction func reloadButtonPressed(_ sender: Any) {
    webView.reload()
  }
  
  @IBAction func backButtonPressed(_ sender: Any) {
    webView.goBack()
  }
  
  @IBAction func forwardButtonPressed(_ sender: Any) {
    webView.goForward()
  }
  
}

extension ViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    if webView.isHidden {
      webView.isHidden = false
      UIView.animate(withDuration: 1, delay: 0, animations: {
        self.webView.alpha = 1
        self.activityIndicator.alpha = 0
      }) { _ in
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
      }
    }
  }
}
