data "archive_file" "rewrite" {
  type = "zip"
  output_path = "${path.module}/.zip/rewrite.zip"
  source {
    filename = "index.js"
    content = "${file("${path.module}/../cloud/rewrite.js")}"
  }
}

resource "aws_lambda_function" "rewrite" {
  function_name = "${var.app_name}-rewrite"
  filename = "${data.archive_file.rewrite.output_path}"
  source_code_hash = "${data.archive_file.rewrite.output_base64sha256}"
  role = "${aws_iam_role.main.arn}"
  runtime = "nodejs6.10"
  handler = "index.handler"
  memory_size = 128
  timeout = 3
  publish = true
}
