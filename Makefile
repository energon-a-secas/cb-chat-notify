VERSION_FILE := 0.2.1

deploy:
	gem build energon-notify.gemspec
	gem install ./energon-notify-$(VERSION_FILE).gem

push:
	gem push energon-notify-$(VERSION_FILE).gem

clean:
	gem uninstall energon-notify

test: clean deploy