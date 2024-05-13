#!/bin/bash

CAMINHO=./$1
cd $CAMINHO

git remote update
git pull --all

BRANCHES=$(git branch -r | git branch -r | sed 's/origin\///')

echo "Conteúdo da variável branches:" $BRANCHES

for branch in $BRANCHES
do
	echo "Limpeza na branch: " $branch

	if ([ "$branch" != "master" ] && [ "$branch" != "origin/master" ] && [ "$branch" != "HEAD" ] &&  [ "$branch" != "->" ])
	then
		git checkout $branch
		if [ -f .env ]
		then
			echo "branch com .env" $branch
			rm .env
			echo '.env' >> .gitignore
			git rm -rf --cached --ignore-unmatch .env
			git add .
			git commit -m "Remove .env"
			git push --force origin $branch
		fi
	fi
done
