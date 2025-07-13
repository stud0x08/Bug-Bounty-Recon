# 🔍 Recon.sh — Offensive Recon Automation Tool

**Created by Ankit Sinha**

`recon.sh` is a powerful Bash-based recon automation tool designed for offensive security professionals. It performs comprehensive reconnaissance on a given IP, list of IPs, domain, or list of domains using widely trusted tools.

---

## 📦 Features

- Subdomain enumeration using `assetfinder`, `subfinder`, `dnsx`
- Historical URLs extraction via `waybackurls` and `gau`
- Live host detection using `httpx-toolkit`
- Vulnerability scanning with `nuclei`
- Crawl and endpoint discovery via `katana`
- Output aggregation and deduplication using `anew`

---

## 🚀 Usage

```bash
./recon.sh [OPTION] <input>

Options:
  -i <ip>            : Single IP
  -I <ip_list.txt>   : List of IPs
  -u <url/domain>    : Single URL or domain
  -U <url_list.txt>  : List of URLs or domains

Example:

./recon.sh -u example.com
./recon.sh -U domains.txt
./recon.sh -i 1.2.3.4
./recon.sh -I ips.txt
