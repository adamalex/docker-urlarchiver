## Use Docker to package a Node.js script with all its dependencies, including Node.

This repo serves double-duty as:

1. An example of using Docker to package a Node.js script with all dependencies, including Node. I hope both that this
is useful to someone and that I hear some suggestions for improvement from those more experienced with Docker.

1. _If you happen to need to save a URL's response body to Amazon S3_, a useful script that can be executed with Docker
or directly with Node.

## What is Docker?

If you're unfamiliar with Docker, please read [The Whole Story](http://www.docker.io/the_whole_story/) if you have a
few minutes. In short, it is a powerful new way to think about deploying software that decouples an application
and its dependencies from the various types of environments where it may be deployed.

## Example files

* `app.js` is a single-purpose Node.js script that takes its configuration from environment variables and saves the
response from a configurable URL to a configurable place on Amazon S3. It knows nothing about Docker.

* `Dockerfile` allows you to bundle app.js with all Node.js dependencies and OS dependencies, including Node itself!
With Docker, you can run this image even on a machine that doesn't have Node installed. The Dockerfile doesn't care
what's happening inside app.js, so it serves as a basic example of using Docker to create an image that contains the
desired version of Node to be used to execute a script.

## Configuration

In case you are interested in the example logic that saves a URL's response to Amazon S3, the following environment
variables are used for configuration:

* `AWS_ACCESS_KEY` Your IAM access key, for saving content to your S3 account.  Familiarize yourself with the
[IAM Best Practices](http://docs.aws.amazon.com/IAM/latest/UserGuide/IAMBestPractices.html) to limit your exposure when
using these credentials.

* `AWS_SECRET_KEY` The secret associated with the above key

* `S3_BUCKET` The target S3 bucket

* `S3_OBJECT` The target filename

* `TARGET_URL` The URL from which to download the response that will be saved in the above S3 location

* `SUCCESS_URL` An optional URL to GET when the script completes successfully. This is great if you use a service like
[Dead Man's Snitch](https://deadmanssnitch.com/) to alert you when your scheduled tasks stop working.

## Usage

### Run using Docker

As the primary use case, this is how you use Docker to run the example script. Note that the only dependency for this
is Docker itself.

```bash
# Pull the preconfigured image to speed things up the first time you run
$ docker pull adamalex/urlarchiver

# Execute the example script within a Docker container
$ docker run \
  -e "AWS_ACCESS_KEY=..." \
  -e "AWS_SECRET_KEY=..." \
  -e "S3_BUCKET=..." \
  -e "S3_OBJECT=..." \
  -e "TARGET_URL=..." \
  -e "SUCCESS_URL=..." \
  adamalex/urlarchiver
```

### Build a custom Docker image

Should you want to customize the Dockerfile or the script itself, or just feel safer using your own Docker image, you
can follow the below instructions to build your own image.

```bash
# Build the image
$ docker build -t="yourname/imagename" .

# Run the image. The environment variables will of course be different
# if you have replaced the example script with your own logic.

$ docker run \
  -e "AWS_ACCESS_KEY=..." \
  -e "AWS_SECRET_KEY=..." \
  -e "S3_BUCKET=..." \
  -e "S3_OBJECT=..." \
  -e "TARGET_URL=..." \
  -e "SUCCESS_URL=..." \
  yourname/imagename
```

### Run using Node.js

Although this example logic is not the primary focus of this repository, this is how you would run the script outside
of Docker by using Node.js directly.

```bash
$ npm install
$ export AWS_ACCESS_KEY="..."
$ export AWS_SECRET_KEY="..."
$ export S3_BUCKET="..."
$ export S3_OBJECT="..."
$ export TARGET_URL="..."
$ export SUCCESS_URL="..."
$ node app.js
```

## Next Steps

* [Learn more about Docker](http://www.docker.io/)
* [Tweet at me](https://twitter.com/adamalex) or [File an issue](https://github.com/adamalex/docker-urlarchiver/issues)
if you have questions or comments