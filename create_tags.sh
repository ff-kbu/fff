tagname=$1
git tag -a $1 -m "Created by Jenkins build for $1"
git push --tags
for  feed in packages luci fastd config_mode
do
	cd feeds/$feed 
	git tag -a $1 -m "Created by Jenkins build for $1" 
	git push --tags
	cd ../..
done