# data

[The Simpsons by data](https://www.kaggle.com/wcukierski/the-simpsons-by-the-data)

# Setting up

* Install [Annaconda](https://www.continuum.io/downloads)

# Setting up on AWS

* Use the Nvidia template in the AWS market place
* Install docker `sudo yum install docker`
* Start docker `sudo service docker start`
* Install [nvidia-docker](https://github.com/NVIDIA/nvidia-docker#other-distributions)
* Replace all further `docker` commands with `nvidia-docker`

# Running

* First Download the data, its [here](https://www.kaggle.com/wcukierski/the-simpsons-by-the-data)
* Then extract the scripts, using [ExtractScripts.ipynb](ExtractScripts.ipynb)
* Then concatenate together into a single file `cat episodes_data/* > simpsons_data.txt`

* You can skip the above with this `aws s3 cp s3://okopac/simpsons/simpsons_full_text.txt simpson_data.txt`
* Then train the model in a docker container (taken from [here](https://github.com/crisbal/docker-torch-rnn))
* Run `docker build -t simpsonnet .`
* This will build the docker container, and the model!

* While its running, you can run this command to get an update of all generated text
```
nvidia-docker exec -ti $CONTAINER_NAME bash
for file in `ls -1tr cv/checkpoint_*.t7`; do echo; echo $file; th sample.lua -checkpoint $file -length 200 ; done
```
* To get the most accurate creation, run this
```
th sample.lua -checkpoint `ls -1t cv/*.t7 | head -n 1` -length 2000
```
