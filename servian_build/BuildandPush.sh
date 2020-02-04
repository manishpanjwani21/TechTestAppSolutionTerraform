#!/bin/bash
echo '
#!/bin/bash
# Update the bucketname

export s3bucketname="PLEASE ADD HERE"

echo "Installing golang, git, deb"
sudo yum install telnet telnet-server -y
sudo yum install golang -y

mkdir -p $HOME/go/bin
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
sudo yum install git -y
go get -d github.com/servian/TechTestApp

echo "WorkAround for deleting pg_default"
sed -i -e "s/TABLESPACE = pg_default//g" $HOME/go/src/github.com/servian/TechTestApp/db/db.go


echo "Builing application"
export PATH="$HOME/go/bin:$PATH";
cd $HOME/go/src/github.com/servian/TechTestApp/
./build.sh

cd $HOME/go/src/github.com/servian/TechTestApp/dist

echo "Creating Zip and pushing to s3"
zip -r TechTestApp.zip *
aws s3 cp TechTestApp.zip s3://${s3bucketname} ' > /tmp/BuildandPush.sh
chmod 755 /tmp/BuildandPush.sh
sudo /tmp/BuildandPush.sh >> /tmp/Build.log
sleep 180
