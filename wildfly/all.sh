#!/bin/bash

cd cluster
bash ./all.sh
cd ..

cd security
bash ./all.sh
cd ..

cd datasource
bash ./all.sh
cd ..

cd deployment
bash ./all.sh
cd ..

cd filter
bash ./all.sh
cd ..

cd listener
bash ./all.sh
cd ..

cd logging
bash ./all.sh
cd ..
