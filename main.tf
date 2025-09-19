# Create a custom VPC network
resource "google_compute_network" "vpc_network_1" {
  name                    = "terraform-network-1"
  auto_create_subnetworks = true
}

# Create a GCP virtual machine instance
resource "google_compute_instance" "vm_instance_1" {
  name         = "web-server-1"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  project      = "your-gcp-project-id"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network_1.id
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    "created-by" = "terraform-interview-1"
  }

  tags = ["web", "dev"]
}

# --- Artifact Registry Resource ---
module "artifact_registry_1" {
  source  = "GoogleCloudPlatform/artifact-registry/google"
  version = "~> 0.4"

  project_id    = "your-gcp-project-id"
  location      = "us-central1"
  format        = "DOCKER"
  repository_id = "my-docker-repo-1"
}

# --- Second set of resources ---
resource "google_compute_network" "vpc_network_2" {
  name                    = "terraform-network-2"
  auto_create_subnetworks = true
}

# Create a GCP virtual machine instance
resource "google_compute_instance" "vm_instance_2" {
  name         = "web-server-2"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  project      = "your-gcp-project-id"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network_2.id
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    "created-by" = "terraform-interview-2"
  }

  tags = ["web", "dev"]
}

# --- Artifact Registry Resource ---
module "artifact_registry_2" {
  source  = "GoogleCloudPlatform/artifact-registry/google"
  version = "~> 0.4"

  project_id    = "your-gcp-project-id"
  location      = "us-central1"
  format        = "DOCKER"
  repository_id = "my-docker-repo-2"
}
