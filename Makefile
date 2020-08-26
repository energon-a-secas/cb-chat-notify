VERSION_FILE := 0.2.0

deploy:
	gem build notify-energon.gemspec
	gem install ./notify-energon-$(VERSION_FILE).gem

push:
	gem push notify-energon-$(VERSION_FILE).gem

clean:
	gem uninstall notify-energon

test: clean deploy