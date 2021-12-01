mkdir Ghidra
cd Ghidra
wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.0.4_build/ghidra_10.0.4_PUBLIC_20210928.zip
unzip ghidra*
cd ghidra_10.0.4_PUBLIC
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt update
sudo apt install openjdk-11-jdk
chmod +x ghidraRun
./ghidraRun
