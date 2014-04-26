rm pages/*
i=1
while [ $i -le 5 ];
do
  curl -0 "http://www.mysocialist.com/concerts?page="$i -o "pages/"$i".txt"
  let i+=1
done
cd pages/
cat $(ls) > mysocialist.txt
cd ..
git add .
git commit -m "Update the list of shows"
git push
