# Testing IPv6 with casperjs

## Build

`docker build -t hasufell/phantomjs .`

## Run

`docker run -i --env TEST_ADDRESS=<address> -v "$(pwd)"/www:/var/www:ro hasufell/phantomjs`
