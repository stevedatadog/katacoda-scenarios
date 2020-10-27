SOURCE=/Users/stephen.calnan/Code/LearningLabs/101v2/dd101-part2-6npm
DEST=/Users/stephen.calnan/Code/katacoda-scenarios/dd101-npm

rm -rf DEST/*
cp -r SOURCE/* DEST/

cd DEST
git add .
git commit -m "Another commit"
git push origin master
