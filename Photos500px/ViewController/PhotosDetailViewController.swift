import UIKit
import WebKit

final class PhotosDetailViewController: UIViewController {

    static let identifier = "PhotosDetailViewController"

    private var webView: WKWebView!

    private var photosUrl: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupWebView()
        showWebView()
    }

    private func setupNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setupWebView() {
        let webView = WKWebView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: self.view.frame.size.width,
                height: self.view.frame.size.height
            )
        )
        self.webView = webView
        self.view.addSubview(webView)
    }

    func setPhotosUrl(_ url: String) {
        self.photosUrl = url
    }

    func showWebView() {
        if self.photosUrl != "" {
            let url = URL(string: photosUrl)
            webView?.load(URLRequest(url: url!))
        }
    }

}
