

htopversion = htop-2.2.0
compress    = .tar.gz
pyname      = gelman
minicondaf  = Miniconda3-latest-MacOSX-x86_64.sh
minicondap  = ./miniconda3

all: htop miniconda message

pyenv:
	python3 -m venv $(pyname)

htop: pyenv
	curl -s -o $(htopversion)$(compress) 'https://hisham.hm/htop/releases/2.2.0/'$(htopversion)$(compress)
	tar -xf $(htopversion)$(compress)
	pushd $(htopversion); ./configure && make; popd
	rm $(htopversion)$(compress)
	install $(htopversion)/htop $(pyname)/bin

miniconda:
	curl -o $(minicondaf) https://repo.anaconda.com/miniconda/$(minicondaf)
	shasum $(minicondaf)
	bash $(minicondaf) -b -p $(minicondap)
	install $(minicondap)/bin/conda    $(pyname)/bin
	install $(minicondap)/bin/conda-env $(pyname)/bin
	install $(minicondap)/bin/activate $(pyname)/bin

message:
	echo "\nActivate with:\n" && echo 'source '$(pyname)'/bin/activate'

clean:
	rm -rf $(pyname)
	rm -rf $(htopversion)
	rm -rf $(minicondap)
	rm $(minicondaf)
