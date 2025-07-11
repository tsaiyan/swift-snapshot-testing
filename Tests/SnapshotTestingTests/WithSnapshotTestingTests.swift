@_spi(Internals) @testable import SnapshotTesting
import XCTest

class WithSnapshotTestingTests: XCTestCase {
  func testNesting() {
    withSnapshotTesting(record: .all) {
      XCTAssertEqual(
        SnapshotTestingConfiguration.current?
          .diffTool?(currentFilePath: "old.heic", failedFilePath: "new.heic"),
        """
        @−
        "file://old.heic"
        @+
        "file://new.heic"

        To configure output for a custom diff tool, use 'withSnapshotTesting'. For example:

            withSnapshotTesting(diffTool: .ksdiff) {
              // ...
            }
        """
      )
      XCTAssertEqual(SnapshotTestingConfiguration.current?.record, .all)
      withSnapshotTesting(diffTool: "ksdiff") {
        XCTAssertEqual(
          SnapshotTestingConfiguration.current?
            .diffTool?(currentFilePath: "old.heic", failedFilePath: "new.heic"),
          "ksdiff old.heic new.heic"
        )
        XCTAssertEqual(SnapshotTestingConfiguration.current?.record, .all)
      }
    }
  }
}
