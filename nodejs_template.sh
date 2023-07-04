#!/bin/bash

set -e # Exit immediately if any command fails

echo "nodejs template code is being created. Please wait..."

# Clone the repository
git clone https://github.com/Ashism766/nodejs-template.git || { echo "Failed to clone the repository."; exit 1; }

cd nodejs-template

echo "installing dependencies..."
npm install || { echo "Failed to install dependencies."; exit 1; }


echo "removing previous .git reference..."
rm -rf .git || { echo "Failed to remove previous .git reference."; exit 1; }

echo "removing the readme file"
rm readme.md

echo "initializing new git repo..."
git init || { echo "Failed to initialize new git repository."; exit 1; }

if ! command -v eslint &> /dev/null; then
    echo "ESLint is not installed. Installing ESLint..."
    sudo npm install -g eslint
fi

echo "running ESLint to fix code style issues..."
eslint --fix . || { echo "Failed to fix code style issues."; exit 1; }

echo "starting the template code in the background..."
npm start &

echo "waiting for the server to start..."
sleep 5

echo "testing the server at localhost:3000..."
if ! curl -s http://localhost:3000/ > /dev/null; then
    echo "Server test failed. Please check if the server is running correctly."
    exit 1
fi

echo "Template code setup completed successfully. Opening vs code....."
sleep 2

code .
