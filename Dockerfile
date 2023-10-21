FROM balenalib/raspberrypi3-debian:latest as base

RUN apt update && apt-get install libsndfile1-dev libsoxr-dev

FROM base as builder

RUN apt-get install make g++

WORKDIR /app

COPY src .

RUN make

FROM base

RUN apt-get install ffmpeg

COPY --from=builder /app/pi_fm_adv ./pi_fm_adv
COPY stream_to_fm .
RUN chmod +x stream_to_fm

CMD ["bash", "./stream_to_fm"]
