ENV ?= default_value

test:
	@echo "Running test..."
	@$(MAKE) clean
	@flutter test

gen:
	@echo "Building Runner..."
	@flutter pub run build_runner build --delete-conflicting-outputs
	@$(MAKE) clean

clean:
	@echo "Cleaning up..."
	@flutter clean && flutter pub get

deploy-android:
	@echo "Sending Android Build for ${ENV} Release..."
	@cd android && bundle install
	@cd android/fastlane && bundle exec fastlane deploy-${ENV}

deploy-ios:
	@echo "Sending iOS Build for ${ENV} Release..."
	@cd ios/fastlane && bundle install
	@cd ios/fastlane && bundle exec fastlane deploy-${ENV}

deploy-web:
	@echo "Sending Web Build for ${ENV} Release..."
	@flutter build web --no-tree-shake-icons
	@firebase use ${ENV}
	@firebase deploy

deploy: test deploy-android deploy-ios deploy-web

.PHONY: test clean deploy-android deploy-ios deploy-web gen
