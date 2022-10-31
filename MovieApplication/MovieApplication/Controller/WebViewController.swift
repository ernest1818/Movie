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

    var idForURLString = ""

    // MARK: - Private Visual Components

    private var webView = WKWebView()
    private let toolBar = UIToolbar()
    private let topToolBar = UIToolbar()
    private var goBackBarButtonItem = UIBarButtonItem()
    private var goForvardBarItem = UIBarButtonItem()
    private var spacerBarItem = UIBarButtonItem.flexibleSpace()
    private var smallspacerBarItem = UIBarButtonItem(systemItem: .fixedSpace)
    private var doneBarButtonItem = UIBarButtonItem()
    private var refreshBarItem = UIBarButtonItem()
    private var activityIndicatorContainerView = UIView()
    private var activityIndicator = UIActivityIndicatorView()

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        createTopToolBar()
        createWKWEbView()
        createActivityIndicator()
        createToolBar()
        createURL()
    }

    private func createURL() {
        guard let url = URL(string: idForURLString) else { return }
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
        activityIndicatorContainerView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorContainerView.backgroundColor = UIColor.black
        activityIndicatorContainerView.alpha = 0.7
        activityIndicatorContainerView.layer.cornerRadius = 5

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .systemOrange
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicatorContainerView.addSubview(activityIndicator)
        webView.addSubview(activityIndicatorContainerView)
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
        goBackBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Constants.goBackItem),
            style: .plain,
            target: self,
            action: #selector(goBackAction)
        )
        goForvardBarItem = UIBarButtonItem(
            image: UIImage(systemName: Constants.goForvardItem),
            style: .plain,
            target: self,
            action: #selector(goForwardAction)
        )

        smallspacerBarItem.width = 40
        toolBar.items = [goBackBarButtonItem, smallspacerBarItem, goForvardBarItem]
    }

    private func createTopToolBarItems() {
        refreshBarItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshAction))
        doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        topToolBar.items = [doneBarButtonItem, spacerBarItem, refreshBarItem]
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
            activityIndicatorContainerView.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            activityIndicatorContainerView.centerYAnchor.constraint(equalTo: webView.centerYAnchor),
            activityIndicatorContainerView.widthAnchor.constraint(equalTo: webView.widthAnchor, multiplier: 0.09),
            activityIndicatorContainerView.heightAnchor.constraint(equalTo: activityIndicatorContainerView.widthAnchor)
        ])
    }

    private func setupActivityIndicatorAnchor() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainerView.centerYAnchor)
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
            activityIndicatorContainerView.isHidden = true
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
