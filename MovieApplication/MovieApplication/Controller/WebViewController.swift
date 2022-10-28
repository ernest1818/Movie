// WebViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Экран отображения страниц во всемирной поутине
final class WebViewController: UIViewController {
    private enum Constants {
        static let goBackItem = "chevron.left"
        static let goForvardItem = "chevron.right"
        static let refreshItem = "goforward"
        static let sharedItem = "square.and.arrow.up"
    }

    // MARK: - Public Properties

    var idForURL = ""

    // MARK: - Private Visual Components

    private var webView = WKWebView()
    private let toolBar = UIToolbar()
    private let topToolBar = UIToolbar()
    private var goBackItem = UIBarButtonItem()
    private var goForvardItem = UIBarButtonItem()
    private var spacerItem = UIBarButtonItem.flexibleSpace()
    private var smallspacer = UIBarButtonItem(systemItem: .fixedSpace)
    private var doneButton = UIBarButtonItem()
    private var refreshItem = UIBarButtonItem()
    private var activityIndicatorContainer = UIView()
    private var activityIndicator = UIActivityIndicatorView()

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        print(idForURL)
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        createTopToolBar()
        createWKWEbView()
        createActivityIndicator()
        createToolBar()
        createUrl()
    }

    private func createUrl() {
        guard let url = URL(string: idForURL) else { return }
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }

    private func createWKWEbView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        view.addSubview(webView)
        setupUIAnchors()
    }

    private func createActivityIndicator() {
        activityIndicatorContainer.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorContainer.backgroundColor = UIColor.black
        activityIndicatorContainer.alpha = 0.7
        activityIndicatorContainer.layer.cornerRadius = 5

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .systemOrange
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicatorContainer.addSubview(activityIndicator)
        webView.addSubview(activityIndicatorContainer)
        setupActivityIndicatorContainerAnchor()
        setupActivityIndicatorAnchor()
    }

    private func createToolBar() {
        toolBar.backgroundColor = .orange
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.tintColor = .black
        view.addSubview(toolBar)
        setupToolBarAnchor()
        createToolBarItems()
    }

    private func createTopToolBar() {
        topToolBar.backgroundColor = .orange
        topToolBar.tintColor = .black
        topToolBar.translatesAutoresizingMaskIntoConstraints = false
        createTopToolBarItems()
        view.addSubview(topToolBar)
        createTopToolBarAnchor()
    }

    private func createToolBarItems() {
        goBackItem = UIBarButtonItem(
            image: UIImage(systemName: Constants.goBackItem),
            style: .plain,
            target: self,
            action: #selector(goBackAction)
        )
        goForvardItem = UIBarButtonItem(
            image: UIImage(systemName: Constants.goForvardItem),
            style: .plain,
            target: self,
            action: #selector(goForwardAction)
        )

        smallspacer.width = 40
        toolBar.items = [goBackItem, smallspacer, goForvardItem]
    }

    private func createTopToolBarItems() {
        refreshItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshAction))
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        topToolBar.items = [doneButton, spacerItem, refreshItem]
    }

    private func setupUIAnchors() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topToolBar.bottomAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupActivityIndicatorContainerAnchor() {
        NSLayoutConstraint.activate([
            activityIndicatorContainer.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            activityIndicatorContainer.centerYAnchor.constraint(equalTo: webView.centerYAnchor),
            activityIndicatorContainer.widthAnchor.constraint(equalTo: webView.widthAnchor, multiplier: 0.09),
            activityIndicatorContainer.heightAnchor.constraint(equalTo: activityIndicatorContainer.widthAnchor)
        ])
    }

    private func setupActivityIndicatorAnchor() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainer.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainer.centerYAnchor)
        ])
    }

    private func setupToolBarAnchor() {
        NSLayoutConstraint.activate([
            toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            toolBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            toolBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            toolBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func createTopToolBarAnchor() {
        NSLayoutConstraint.activate([
            topToolBar.topAnchor.constraint(equalTo: view.topAnchor),
            topToolBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            topToolBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            topToolBar.heightAnchor.constraint(equalToConstant: 50)

        ])
    }

    private func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicatorContainer.isHidden = true
        }
    }

    @objc private func goForwardAction() {
        if webView.canGoForward {
            webView.goForward()
        }
    }

    @objc private func goBackAction() {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @objc private func refreshAction() {
        webView.reload()
    }

    @objc private func doneAction() {
        dismiss(animated: true)
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        createActivityIndicator()
        showActivityIndicator(show: true)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }
}
