# Simpsons

This is a simple application of the method show here for using Recursive Neural Nets to generate new text from an example script. In this case, The Simpsons!

This is by no means new, there is an excellent tutorial [here](http://karpathy.github.io/2015/05/21/rnn-effectiveness/) on the method. But it was fun to do.

# Data

The kaggle dataset [The Simpsons by data](https://www.kaggle.com/wcukierski/the-simpsons-by-the-data) provides transcripts for 565 episodes. The ipython notebook [ExtractScripts.ipynb](ExtractScripts.ipynb) parses the csv, extracts the raw transcript, and transforms it into flat files. We then concatenate these episode transcripts into a single file, for ease of use with the RNN.

```
cat episodes_data/* > simpsons_data.txt
```

# Training the model

Training neural networks is expensive. We (@witchard) tried using a CPU to do so, and it was tedious. However, AWS GPUs are cheap (~$60/hour), making this silly project worth the pennies.

I'll detail the method for both CPU and GPU below. We've made heavy use of docker here, making our lives much much easier.

## GPU - Using AWS GPUs

To setup the nvidia aws instance, follow the instructions below.
* Use the Nvidia template in the AWS market place
* Install docker `sudo yum install docker`
* Start docker `sudo service docker start`
* Install [nvidia-docker](https://github.com/NVIDIA/nvidia-docker#other-distributions)

You're now ready to build the model. Pull down the git repo, and run the container
```
git clone https://github.com/okopac/simpsons.git
cd simpsons
nvidia-docker build -t simpsons -f Dockerfile.gpu .
```

This has build the basic container (basically the original container, with the new dataset inserted). You can now run the container, and kick of the training process, this will take a long time!
```
nvidia-docker run -ti --name simpsons simpsons bash
th train.lua -input_h5 data/simpson_data.h5 -input_json data/simpson_data.json
```

While its running, you can run this command to get an update of all generated text
```
nvidia-docker exec -ti $CONTAINER_NAME bash
for file in `ls -1tr cv/checkpoint_*.t7`; do echo; echo $file; th sample.lua -checkpoint $file -length 200 ; done
```

And then to get the current most accurate creation, run this

```
th sample.lua -checkpoint `ls -1t cv/*.t7 | head -n 1` -length 2000
```
