provider "openstack" {
    user_name  = "${var.user_name}"
    tenant_name = "${var.tenant_name}"
    password  = "${var.password}"
    auth_url  = "${var.auth_url}"
}

resource "openstack_compute_floatingip_v2" "floatip_1" {
  pool = "ext-net"
}

data "template_file" "salt_bootstrap_elab_api" {
	template = "${file("salt_bootstrap.sh")}"
	vars {
		roles = "eLab_API"
		environment = "${var.environment}"
                salt_master = "${var.salt_master}"
	}
}

resource "openstack_compute_instance_v2" "api_node" {
    name = "${var.node_name}"
    image_id = "cf5974ec-0d3d-4206-8251-01d964efa20e"
    flavor_id = "4"
    key_pair = "jenkins_key"
    security_groups = ["default"]
    network {
        name = "CH-816772-net"
        floating_ip = "${openstack_compute_floatingip_v2.floatip_1.address}"
    }
    user_data = "${data.template_file.salt_bootstrap_elab_api.rendered}"

    provisioner "remote-exec" {
        connection {
            user = "ubuntu"
            private_key = "${file("/var/lib/jenkins/.ssh/id_rsa")}"
        }
        inline = [
            "while [ ! -f /tmp/signal ]; do sleep 2; done"
        ]
    }
}

output "public_ip" {
    value = "${openstack_compute_floatingip_v2.floatip_1.address}"
}
