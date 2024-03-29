//
//  InfoWebViewController.swift
//  QuadPaySDK
//
//  Created by Lai Tang on 30/06/2022.
//

import Foundation
import UIKit
import WebKit

final class InfoWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

  private let infoURL: URL
    @IBOutlet weak var webViewHeight: NSLayoutConstraint!
  private let contentHTML : String
    
  private var webView: WKWebView { view as! WKWebView }
    init(infoURL: URL, contentHtml: String) {
    self.infoURL = infoURL
    self.contentHTML = contentHtml
    super.init(nibName: nil, bundle: nil)
  }

  override func loadView() {
    let webView = WKWebView()

    webView.allowsLinkPreview = false
    webView.scrollView.isScrollEnabled = true
    webView.navigationDelegate = self

    webView.uiDelegate = self
    view = webView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.extendedLayoutIncludesOpaqueBars = true

    if #available(iOS 13.0, *) {
      overrideUserInterfaceStyle = .light
      navigationItem.rightBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .close,
        target: self,
        action: #selector(dismissViewController)
      )
    } else {
      navigationItem.rightBarButtonItem = UIBarButtonItem(
        title: "Close",
        style: .plain,
        target: self,
        action: #selector(dismissViewController)
      )
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
      webView.loadHTMLString(contentHTML, baseURL: infoURL)
  }

  @objc private func dismissViewController() {
    dismiss(animated: true)
  }

  // MARK: WKNavigationDelegate

  func webView(
    _ webView: WKWebView,
 
    didFailProvisionalNavigation navigation: WKNavigation!,
    withError error: Error
  ) {
           
    let alert = UIAlertController(
      title: "Error",
      message: "Failed to load url",
      preferredStyle: .alert
    )

    alert.addAction(
      UIAlertAction(title: "Retry", style: .default) { [infoURL] _ in
        webView.load(URLRequest(url: infoURL))
      }
    )
    alert.addAction(
      UIAlertAction(title: "Cancel", style: .destructive) { _ in
        self.dismiss(animated: true)
      }
    )

    present(alert, animated: true, completion: nil)
  }

  func webView(
    _ webView: WKWebView,
    decidePolicyFor navigationAction: WKNavigationAction,
    decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
  ) {
    if let url = navigationAction.request.url, url != infoURL {
      decisionHandler(.cancel)
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(url)
        }
    } else {
      decisionHandler(.allow)
    }
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
