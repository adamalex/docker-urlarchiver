var amazonS3 = require("awssum-amazon-s3");
var request = require("request");

// CONFIGURE OPTIONS
var targetUrl = process.env.TARGET_URL;
var successUrl = process.env.SUCCESS_URL;
var s3bucket = process.env.S3_BUCKET;
var s3object = process.env.S3_OBJECT;

// CONFIGURE S3
var s3 = new amazonS3.S3({
	"accessKeyId": process.env.AWS_ACCESS_KEY,
	"secretAccessKey" : process.env.AWS_SECRET_KEY,
	"region": amazonS3.US_EAST_1
});

// GET TARGET URL, SAVE TO S3, REPORT SUCCESS
request(targetUrl, function (error, response, data) {
	if (error) handleError(error);

	s3.PutObject({
		BucketName: s3bucket,
		ObjectName: s3object,
		ContentLength: Buffer.byteLength(data),
		Body: data
	}, function (error) {
		if (error) handleError(error);

		if (successUrl) request(successUrl);
	});
});

// COMMON ERROR HANDLER
function handleError(error) {
	console.log(error);
	throw error;
}
