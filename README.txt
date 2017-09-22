In order to use this tool, clone it to a local directory. 
git clone git@github.com:bretttegart/treadmill-buildbox.git
cd treadmill-buildbox && git submodule init && git submodule update

Build the docker image (Tested with 17.07.0-ce): 
docker build -t tmbuild .

Create a folder to mount to the image- the treadmill binary and RPM will be written here:
mkdir /tmp/treadmill-binary

Run the docker container. If selinux is installed, flag the volume mount with :Z to label the content with the MCS label the container runs with. 
Tested against libselinux-2.6-7
docker run -v /tmp/treadmill-binary:/build/treadmill/dist:Z tmbuild

Upon completion, the treadmill PEX executible and an RPM containing the executible will be written in the mounted folder. To run:
/usr/bin/python3.4 /tmp/treadmill-binary/treadmill

To install permanently, install the RPM or move the Treadmill PEX file to /usr/bin. 
