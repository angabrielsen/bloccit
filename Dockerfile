FROM quay.octanner.io/base/oct-ruby/2.3.0-onbuild
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app
EXPOSE 3000
CMD [ "rails", "s" ]