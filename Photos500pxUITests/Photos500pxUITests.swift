import XCTest

class Photos500pxUITests: XCTestCase {

    func testLaunchPerformance() throws {
        if #available(iOS 12.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
