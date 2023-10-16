
Lambda layer for pip installed packages

```
pip install --target ./packages -r requirements.txt
zip -r packages.zip packages
```

All packages in packages.zip can be used in the lambda
