home_configs:
	ln -s $(PWD)/profile $(HOME)/.profile
	ln -s $(PWD)/config $(HOME)/.config
clean_configs:
	rm ~/.profile
	rm -r ~/.config
test:
	echo $(PWD)/profile $(HOME)/.profile
