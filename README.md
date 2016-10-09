# data

[The Simpsons by data](https://www.kaggle.com/wcukierski/the-simpsons-by-the-data)

# Setting up

* Install [Annaconda](https://www.continuum.io/downloads)

# Setting up on AWS

* Use the Nvidia template in the AWS market place
* Install docker
* Install [nvidia-docker](https://github.com/NVIDIA/nvidia-docker#other-distributions)
* Replace all further `docker` commands with `nvidia-docker`

# Running

* First Download the data, its [here](https://www.kaggle.com/wcukierski/the-simpsons-by-the-data)
* Then extract the scripts, using [ExtractScripts.ipynb](ExtractScripts.ipynb)
* Then concatenate together into a single file `cat episodes_data/* > simpsons_data.txt`

* Then train the model in a docker container (taken from [here](https://github.com/crisbal/docker-torch-rnn))
* Run `docker build -t simpsonnet .`
* This will build the docker container, and the model!
