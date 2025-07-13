#!/bin/bash

echo "[*] Installing Go-based tools..."

go install github.com/tomnomnom/assetfinder@latest
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/tomnomnom/anew@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest

echo "[*] Installing SecLists..."
git clone https://github.com/danielmiessler/SecLists.git

echo "[+] All tools installed successfully. Make sure your GOPATH/bin is in PATH."
