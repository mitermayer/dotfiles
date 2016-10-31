#!/bin/bash

function confirm() {
    read -p "$1 ([y]es or [N]o): "
    case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
        y|yes) echo "yes" ;;
        *)     echo "no" ;;
    esac
}

echo "###########################################################################"
echo -e "\nIn order to emerge all the packages please answer the following questions: \n"
echo "--------------------------------------------------------------------------"

if [[ \
      "yes" == $(confirm "Are you root?") && \
      "yes" == $(confirm "Have you already configured your kernel drivers?") &&  \
      "yes" == $(confirm "Have you already setup the profile as 'HARDENED'?") &&  \
      "yes" == $(confirm "Have you already configured your global USE flags?") &&  \
      "yes" == $(confirm "Have you already run an emerge world update?") \
   ]]
then
  echo "--------------------------------------------------------------------------"
  echo -e "\ninstalling dependencies: \n"
  WORLD_PACKAGES=$(<./gentoo/world)
  # Installing dependencies
  emerge --ask --verbose $WORLD_PACKAGES
  exit
fi

echo -e "\nPlease review the above steps and try again\n"
