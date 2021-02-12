URL=https://discord.com/api/webhooks/809757377058177065/QisnxpHKiKo_LQqnFZ2GKUOwDwH374hwHmVw7hZqbYoBetZGjgVA93_7DhC5YY52cLWo

echo "\`\`\`\\\n" > /tmp/alp.txt
cat /var/log/apache2/access.log | /usr/local/bin/alp ltsv | sed -z 's/\n/\\n/g' >> /tmp/alp.txt
echo "\`\`\`" >> /tmp/alp.txt

alp_data=`cat /tmp/alp.txt`
curl -XPOST ${URL} \
	  -H "Content-Type: application/json" \
		  --data @- <<EOS
{	
  "content": "${alp_data}"
}
EOS

