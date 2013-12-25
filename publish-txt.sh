file=`grep ^fig.*txt$ MOSTRECENT`
cp -f $file exeter-precip/exeter-precip.txt
cd exeter-precip
git add .
git commit -m "latest commit"
git push origin master


