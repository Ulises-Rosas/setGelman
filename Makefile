

htopversion = htop-2.2.0
compress    = .tar.gz
pyname      = gelman

all: htop message

pyenv:
	python3 -m venv $(pyname)

htop: pyenv
	curl -s -o $(htopversion)$(compress) 'https://hisham.hm/htop/releases/2.2.0/'$(htopversion)$(compress)
	tar -xf $(htopversion)$(compress)
	pushd $(htopversion); ./configure && make; popd
	rm $(htopversion)$(compress)
	install $(htopversion)/htop $(pyname)/bin

message:
	echo "\nActivate with:\n" && echo 'source '$(pyname)'/bin/activate'

clean:
	rm -rf $(pyname)
	rm -rf $(htopversion)





