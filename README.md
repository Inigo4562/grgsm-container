# grgsm-container
Container image built with GSM analysis tools, in case you do not want to install all the required packages.

Installation based on this post https://www.paladion.net/blogs/how-to-build-an-imsi-catcher-to-intercept-gsm-traffic

Includes GR-GSM, IMSI-catcher, Kalibrate and rtl-sdr

## Instructions

Running the container in privileged mode is necessary so that the container can have root acess to the usb connected
SDR device.

- Scan for available frequencies
```
$ grgsm_scanner -v -b <gsm-band>
```
or
```
$ kal -v -s <gsm-band>
```

- Run the gsm live monitoring with a selected frequency. Use the headless command
```
$ grgsm_livemon_headless -f <some-frequency>
```

- Open wireshark (on the host) and select the loopback interface
