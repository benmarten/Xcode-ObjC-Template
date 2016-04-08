#!/bin/bash

echo "Please enter the following information for setting up your project:"

# These are the original values, used during project setup in Xcode
_PRODUCT_NAME=YB7PNZA3
_ORGANIZATION_NAME=YB7ONZA3
_ORGANIZATION_IDENTIFIER=YB7OIZA3
_AUTHOR_NAME=Ben
_AUTHOR_DATE=$(date +%m/%d/%Y)
_AUTHOR_DATE=$(echo "$_AUTHOR_DATE" | sed 's/\//\\\//g')
_COPYRIGHT_YEAR=$(date +%Y)

# Read input
read -p "Product name, e.g. 'MyApp': " PRODUCT_NAME
[[ -z "$PRODUCT_NAME" ]] && { echo "Cannot be empty." ; exit 1; }

read -p "Organization name, e.g. 'Apple' (no spaces!): " ORGANIZATION_NAME
[[ -z "$ORGANIZATION_NAME" ]] && { echo "Cannot be empty." ; exit 1; }

read -p "Organization domain, e.g. 'com.apple': " ORGANIZATION_IDENTIFIER
[[ -z "$ORGANIZATION_IDENTIFIER" ]] && { echo "Cannot be empty." ; exit 1; }

read -p "Author name, e.g. 'John Doe': " AUTHOR_NAME
[[ -z "$AUTHOR_NAME" ]] && { echo "Cannot be empty." ; exit 1; }

default=$(date +%m/%d/%Y)
read -p "Date Created [$default]: " AUTHOR_DATE
AUTHOR_DATE=${AUTHOR_DATE:-$default}

default=$(date +%Y)
read -p "Copyright Year [$default]: " COPYRIGHT_YEAR
COPYRIGHT_YEAR=${COPYRIGHT_YEAR:-$default}

# Escape Slasheds in strings
PRODUCT_NAME=$(echo "$PRODUCT_NAME" | sed 's/\//\\\//g')
ORGANIZATION_NAME=$(echo "$ORGANIZATION_NAME" | sed 's/\//\\\//g')
ORGANIZATION_IDENTIFIER=$(echo "$ORGANIZATION_IDENTIFIER" | sed 's/\//\\\//g')
AUTHOR_NAME=$(echo "$AUTHOR_NAME" | sed 's/\//\\\//g')
AUTHOR_DATE=$(echo "$AUTHOR_DATE" | sed 's/\//\\\//g')
COPYRIGHT_YEAR=$(echo "$COPYRIGHT_YEAR" | sed 's/\//\\\//g')

echo "Applying patch ..."
find . -type f -not -path '*/\.*' -not -path './setup.sh' -exec sed -i '' "s/$_PRODUCT_NAME/$PRODUCT_NAME/g" {} \;
find . -type f -not -path '*/\.*' -not -path './setup.sh' -exec sed -i '' "s/$_ORGANIZATION_NAME/$ORGANIZATION_NAME/g" {} \;
find . -type f -not -path '*/\.*' -not -path './setup.sh' -exec sed -i '' "s/$_ORGANIZATION_IDENTIFIER/$ORGANIZATION_IDENTIFIER/g" {} \;
find . -type f -not -path '*/\.*' -not -path './setup.sh' -exec sed -i '' "s/$_AUTHOR_NAME/$AUTHOR_NAME/g" {} \;
find . -type f -not -path '*/\.*' -not -path './setup.sh' -exec sed -i '' "s/$_AUTHOR_DATE/$AUTHOR_DATE/g" {} \;
find . -type f -not -path '*/\.*' -not -path './setup.sh' -exec sed -i '' "s/$_COPYRIGHT_YEAR/$COPYRIGHT_YEAR/g" {} \;

mv "$_PRODUCT_NAME".xcodeproj/ "$PRODUCT_NAME".xcodeproj
mv "$_PRODUCT_NAME"/ "$PRODUCT_NAME"

rm ./README.md
rm ./LICENSE
rm ./setup.sh

echo "Patching done!"

open ./"$PRODUCT_NAME".xcodeproj
