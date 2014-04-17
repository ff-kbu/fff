tagname=$1
git tag -a $1 -m "Created by Jenkins build for $1"
git push origin $1
for  feed in packages luci fastd config_mode ath9k_watchdog routing
do
	cd feeds/$feed 
	git tag -a $1 -m "Created by Jenkins build for $1" 
	git push origin $1
	cd ../..
done

#Check out tags
sed s/elephants_dream/$1/g < feeds.conf.default > feeds.conf
git commit -m "Tagged feeds" feeds.conf
git push

