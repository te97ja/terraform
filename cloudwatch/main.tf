provider "aws" {
  region     = "us-west-2"
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "my-ubuntuec2-dashboard"

  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization",
            "InstanceId",
            "i-0934f2a818cf99ae0"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-west-2",
        "title": "EC2 Instance CPU"
      }
    },
    {
      "type": "text",
      "x": 0,
      "y": 7,
      "width": 3,
      "height": 3,
      "properties": {
        "markdown": "UbuntuEC2"
      }
    }
  ]
}
EOF
}
