import XCTest

final class fitnessAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testTabShellNavigatesAcrossScreens() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.otherElements["screen.home"].waitForExistence(timeout: 2))

        app.buttons["tab.workouts"].tap()
        XCTAssertTrue(app.otherElements["screen.workouts"].waitForExistence(timeout: 2))

        app.buttons["tab.insights"].tap()
        XCTAssertTrue(app.otherElements["screen.insights"].waitForExistence(timeout: 2))

        app.buttons["tab.profile"].tap()
        XCTAssertTrue(app.otherElements["screen.profile"].waitForExistence(timeout: 2))
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
