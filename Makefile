PROJECT = MOAspectsDemo/MOAspectsDemo.xcodeproj
TEST_TARGET = Tests

clean:
  xcodebuild \
      -project $(PROJECT) \
      clean

travistest:
  xcodebuild \
      -project $(PROJECT) \
      -target $(TEST_TARGET) \
      -sdk iphonesimulator \
      -configuration Debug \
      TEST_AFTER_BUILD=YES \
      TEST_HOST=
