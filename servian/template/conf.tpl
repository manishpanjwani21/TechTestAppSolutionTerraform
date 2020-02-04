#!/bin/bash
echo "\"DbUser\" = \"${DBUSER}\"
\"DbPassword\" = \"${DBPASS}\"
\"DbName\" = \"${DBNAME}\"
\"DbPort\" = \"5432\"
\"DbHost\" = \"${DBHOST}\"
\"ListenHost\" = \"NOTHING\"
\"ListenPort\" = \"3000\"" > /tmp/conf.toml
mkdir TechTestApp
cd TechTestApp
aws s3 cp s3://${S3BUCKET}/TechTestApp.zip .
unzip TechTestApp.zip
rm -f TechTestApp.zip
cp -f /tmp/conf.toml .
export apphost=$(curl -s http://169.254.169.254/latest/meta-data/local-hostname)
sed -i -e "s/NOTHING/$apphost/g" conf.toml
nohup ./TechTestApp serve &