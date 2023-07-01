#!/bin/bash
##author           :simon legah
#CopyRights        :Landmark Technologies
#Contact           : +1 437 215 2483
echo "Enter your Github Personal Access Token:"
read token
#echo $token >token.txt
#cat token.txt
cat ~/.ssh/id_rsa.pub
#if condition to validate weather ssh keys are already present or not
if [ $? -eq 0 ] 
then 
	 echo "SSH Keys are already present..." 
else
echo "SSH keys are not present..., Create the sshkeyes using ssh-keygen command"
ssh-keygen -t rsa 
echo "Key Successfully generated"
fi
sshkey= `cat ~/.ssh/id_rsa.pub`
if [ $? -eq 0 ]
then 
echo "Copying the key to Github account"
curl -x POST -H "Content-type: application/json" -d "{\"title\": \"SSHKEY\",\"KEY\": \$sshkey\"}" "
hhtps://api.github.com/user/keys?access_token=$token"
if [ $? -eq 0 ]
then 
echo "successfully copied the token to GitHub"
exit 0
else
echo "Failed"
exit 1
fi
else
echo "Failure in generating the key"
exit 1
fi
