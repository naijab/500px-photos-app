import XCTest
@testable import Photos500px

class PhotosListViewModelTests: XCTestCase {

    func testFetch() throws {
        let expectation = self.expectation(description: #function)

        let viewModel = PhotosListViewModel(photosService: MockPhotosAPIService())

        let photosRecorder = TestRecorder<PhotosEntity>()
        let loadingRecorder = TestRecorder<Bool>()

        photosRecorder.on(arraySubject: viewModel.photos)
        loadingRecorder.on(valueSubject: viewModel.isLoading)

        viewModel.fetch()

        XCTAssertEqual(loadingRecorder.items[0], true)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 2)

        XCTAssertEqual(photosRecorder.items.count, 2)
        XCTAssertEqual(loadingRecorder.items[1], false)
    }

}
