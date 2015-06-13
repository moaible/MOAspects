PROJECT = MOAspectsDemo/MOAspectsDemo.xcodeproj
SCHEME=MOAspectsDemo
TEST_SDK=iphonesimulator
CONFIGURATION_DEBUG=Debug
DESTINATION="platform=iOS Simulator,name=iPhone 5,OS=8.1"

test:
	xcodebuild \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-sdk $(TEST_SDK) \
		-configuration $(CONFIGURATION_DEBUG) \
		-destination $(DESTINATION) \
		clean build test
