FROM crisbal/torch-rnn:base

ADD simpson_data.txt data/

RUN python scripts/preprocess.py \
--input_txt data/simpson_data.txt \
--output_h5 data/simpson_data.h5 \
--output_json data/simpson_data.json

RUN th train.lua \
-input_h5 data/simpson_data.h5 \
-input_json data/simpson_data.json \
-gpu -1
