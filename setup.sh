#!/bin/bash

echo "Please enter the following information for setting up your project:"

# Read input
default="TestApp"
read -p "Product name [$default]: " PRODUCT_NAME
PRODUCT_NAME=${PRODUCT_NAME:-$default}

default="Leanplum Inc"
read -p "Organization name [$default]: " ORG_NAME
ORG_NAME=${ORG_NAME:-$default}

default="com.leanplum"
read -p "Organization domain [$default]: " ORG_ID
ORG_ID=${ORG_ID:-$default}

default="Ben Marten"
read -p "Author name [$default]: " AUTHOR_NAME
AUTHOR_NAME=${AUTHOR_NAME:-$default}

default=$(date +%m/%d/%Y)
read -p "Date Created [$default]: " AUTHOR_DATE
AUTHOR_DATE=${AUTHOR_DATE:-$default}

default=$(date +%Y)
read -p "Copyright Year [$default]: " COPY_YEAR
COPY_YEAR=${COPY_YEAR:-$default}

# Escape Slasheds in strings
PRODUCT_NAME=$(echo "$PRODUCT_NAME" | sed 's/\//\\\//g')
ORG_NAME=$(echo "$ORG_NAME" | sed 's/\//\\\//g')
ORG_ID=$(echo "$ORG_ID" | sed 's/\//\\\//g')
AUTHOR_NAME=$(echo "$AUTHOR_NAME" | sed 's/\//\\\//g')
AUTHOR_DATE=$(echo "$AUTHOR_DATE" | sed 's/\//\\\//g')
COPY_YEAR=$(echo "$COPY_YEAR" | sed 's/\//\\\//g')

echo "Applying patch ..."
find . -type f -not -path '*/\.*' -not -path './setup.sh' -exec sed -i '' "s/XYZPRODUCTNAME/$PRODUCT_NAME/g" {} \;
find . -type f -not -path '*/\.*' -not -path './setup.sh' -exec sed -i '' "s/XYZORGNAME/$ORG_NAME/g" {} \;
find . -type f -not -path '*/\.*' -not -path './setup.sh' -exec sed -i '' "s/XYZORGID/$ORG_ID/g" {} \;
find . -type f -not -path '*/\.*' -not -path './setup.sh' -exec sed -i '' "s/{{AUTHOR_NAME}}/$AUTHOR_NAME/g" {} \;
find . -type f -not -path '*/\.*' -not -path './setup.sh' -exec sed -i '' "s/{{AUTHOR_DATE}}/$AUTHOR_DATE/g" {} \;
find . -type f -not -path '*/\.*' -not -path './setup.sh' -exec sed -i '' "s/{{COPY_YEAR}}/$COPY_YEAR/g" {} \;

mv XYZPRODUCTNAME.xcodeproj/ "$PRODUCT_NAME".xcodeproj
mv XYZPRODUCTNAME/ "$PRODUCT_NAME"

rm ./README.md
rm ./LICENSE
rm ./setup.sh

echo "Patching done!"
