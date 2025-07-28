terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  # if running locally, authenticate via `gcloud auth application-default login`
}

resource "google_monitoring_alert_policy" "request_count_alert" {
  display_name = "Request count >10/s (Terraform-created)"

  combiner = "OR"

  conditions {
    display_name = "Cloud Run Revision - Request Count >10/s"

    condition_threshold {
      filter = "resource.type = \"cloud_run_revision\" AND resource.labels.service_name = \"travel-buddy2\" AND metric.type = \"run.googleapis.com/request_count\""

      comparison      = "COMPARISON_GT"
      threshold_value = 10
      duration        = "0s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }

      trigger {
        count = 1
      }
    }
  }

  documentation {
    content = "Alert: Travel Buddy is receiving more than 10 requests a second!"
  }

  enabled = true

  notification_channels = var.notification_channels

  user_labels = {
    severity = "warning"
  }
}
