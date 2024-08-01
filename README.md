# trailer-viewer-generator
This Generator repo
* Installs and runs ubuntu on Docker
* Installs Python33.10 python3-pip and PyYAML
* Runs trailer.py to transform YAML to XML
* Runs xsltransformer.py to transform the generated XML to HTML using XSL technology and Python
* Runs entrypoint.sh to initiate and push to the trailer-viewer repo

``The Generator detects new commits in trailer-viewer repo and automatically deploy the changes using GitHub actions``
