
packages-win:
	pip install --target ./packages -r requirements.txt
	powershell Compress-Archive -Path packages -Destination packages

packages-unix:
	pip install --target ./packages -r requirements.txt
	zip -r packages packages.zip

