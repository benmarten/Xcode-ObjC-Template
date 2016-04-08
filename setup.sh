#!/bin/bash

echo "Patching files ..."

mv PRODUCT_NAME.xcodeproj/ NEW_PRODUCT_NAME.xcodeproj
mv NEW_PRODUCT_NAME/ PRODUCT_NAME

echo "Patching done."
