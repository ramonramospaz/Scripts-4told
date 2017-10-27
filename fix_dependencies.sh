#!/bin/bash
# ------------------------------------------------------------------
# [Ramon Ramos] fix_dependencies 
#         Fix the problem of dependencies with the finapp-models and  
#         the finapp-backend
# ------------------------------------------------------------------

#Check is the command docker exist.
command -v mvn >/dev/null 2>&1 || {
        echo >&2 "I require mvn but it's not installed. Abortig.";
        exit 1;
}

#Do the script job.
echo "Move to the finapp-models project"
cd finapp-models
echo "create the finapp-models package and install it"
mvn install package 
echo "Move to the finapp-backend project"
cd ..
echo "install the package to the main project"
mvn install package
