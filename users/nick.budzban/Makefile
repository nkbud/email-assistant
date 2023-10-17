
# windows only
imperial:
	pip install --target ./packages -r requirements.txt
	powershell Compress-Archive -Path packages -Destination packages

# all others
metric:
	pip install --target ./packages -r requirements.txt
	zip -r packages packages.zip

