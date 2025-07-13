#!/bin/bash

#################################################################
#                                                               #
#              ██████╗██████╗ ███████╗███████╗                  #
#             ██╔════╝██╔══██╗██╔════╝██╔════╝                  #
#             ██║     ██████╔╝█████╗  ███████╗                  #
#             ██║     ██╔═══╝ ██╔══╝  ╚════██║                  #
#             ╚██████╗██║     ███████╗███████║                  #
#              ╚═════╝╚═╝     ╚══════╝╚══════╝                  #
#                                                               #
#                 Created by Ankit Sinha                        #
#                                                               #
#################################################################

usage() {
  echo "Usage:"
  echo "  $0 -i <ip>                # Single IP"
  echo "  $0 -I <ip_list.txt>       # List of IPs"
  echo "  $0 -u <url/domain>        # Single URL or domain"
  echo "  $0 -U <url_list.txt>      # List of URLs or domains"
  exit 1
}

recon_domain() {
  domain=$1
  echo "[*] Recon on domain: $domain"
  assetfinder -subs-only "$domain" >> assetfinder.txt
  subfinder -d "$domain" -all -recursive >> subfinder.txt
  waybackurls -host "$domain" >> wayback.txt
  dnsx -d "$domain" -w /usr/share/wordlists/seclists/Discovery/DNS/bitquark-subdomains-top100000.txt >> dns.txt
  gau "$domain" >> gau.txt
}

recon_ip() {
  ip=$1
  echo "[*] Recon on IP: $ip"
  echo "$ip" >> stored.txt
}

post_process() {
  echo "[*] Combining and checking alive hosts..."
  cat assetfinder.txt subfinder.txt crtsh.txt wayback.txt dns.txt 2>/dev/null | sort -u | anew stored.txt
  httpx-toolkit -l stored.txt -silent > alive.txt
  nuclei -l alive.txt -t /root/Desktop/tools/AllForOne/Templates/ -o nuclei.txt
  katana -u alive.txt -silent > katana.txt
}

# Cleanup old files
rm -f assetfinder.txt subfinder.txt wayback.txt dns.txt gau.txt stored.txt alive.txt nuclei.txt katana.txt

# Main logic
while getopts ":i:I:u:U:" opt; do
  case $opt in
    i)
      recon_ip "$OPTARG"
      ;;
    I)
      while read -r ip; do recon_ip "$ip"; done < "$OPTARG"
      ;;
    u)
      recon_domain "$OPTARG"
      ;;
    U)
      while read -r url; do recon_domain "$url"; done < "$OPTARG"
      ;;
    *)
      usage
      ;;
  esac
done

# Check if any flag was used
if [ $OPTIND -eq 1 ]; then
  usage
fi

post_process

