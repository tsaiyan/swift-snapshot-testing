#if compiler(>=6) && canImport(Testing)
  import Testing
  @_spi(Internals) import SnapshotTesting

  extension BaseSuite {
    struct SnapshotsTraitTests {
      @Test(.snapshots(diffTool: "ksdiff"))
      func testDiffTool() {
        #expect(
          _diffTool(currentFilePath: "old.heic", failedFilePath: "new.heic")
            == "ksdiff old.heic new.heic"
        )
      }

      @Suite(.snapshots(diffTool: "ksdiff"))
      struct OverrideDiffTool {
        @Test(.snapshots(diffTool: "difftool"))
        func testDiffToolOverride() {
          #expect(
            _diffTool(currentFilePath: "old.heic", failedFilePath: "new.heic")
              == "difftool old.heic new.heic"
          )
        }

        @Suite(.snapshots(record: .all))
        struct OverrideRecord {
          @Test
          func config() {
            #expect(
              _diffTool(currentFilePath: "old.heic", failedFilePath: "new.heic")
                == "ksdiff old.heic new.heic"
            )
            #expect(_record == .all)
          }

          @Suite(.snapshots(record: .failed, diffTool: "diff"))
          struct OverrideDiffToolAndRecord {
            @Test
            func config() {
              #expect(
                _diffTool(currentFilePath: "old.heic", failedFilePath: "new.heic")
                  == "diff old.heic new.heic"
              )
              #expect(_record == .failed)
            }
          }
        }
      }
    }
  }
#endif
