import XCTest

class PhotosListPageUITests: XCTestCase {

    func testIsCanShowPhotosListTable() {
        let app = XCUIApplication()
        app.launch()

        let photosListTable = app.tables.element.firstMatch

        XCTAssertTrue(photosListTable.exists)
        XCTAssertEqual(photosListTable.cells.count, 20)
    }

    func testIsCanShowAdsBetweenCellPhotosListTable() {
        let app = XCUIApplication()
        app.launch()

        let adsCell = app.tables.images["image-insertion"]
        XCTAssertTrue(adsCell.exists)
    }

}
