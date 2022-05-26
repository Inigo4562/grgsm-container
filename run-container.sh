# docker build -t grgsm-container .
docker run --rm -ti --privileged --name imsi-catcher --network host grgsm-container
