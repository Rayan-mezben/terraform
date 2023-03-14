data "openstack_networking_network_v2" "public" {
  name = "public"
}

# Router for the whole project, linked to the public network
resource "openstack_networking_router_v2" "global" {
  name                = "global"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.public.id
}

# Internal Network
resource "openstack_networking_network_v2" "network" {
  name           = "haha-network"
  admin_state_up = "true"
}

# Network Subnet
resource "openstack_networking_subnet_v2" "subnet" {
  name            = "my-network-subnet"
  network_id      = openstack_networking_network_v2.network.id
  cidr            = "192.168.1.0/24"
  ip_version      = 4
}

# Interface between Router and Subnet
resource "openstack_networking_router_interface_v2" "interface" {
  router_id = openstack_networking_router_v2.global.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
}

# Security group

resource "openstack_networking_secgroup_v2" "my_security_group" {
  description = "Groupe de sécurite pour le port 22"
  name        = "sssh"
}

resource "openstack_networking_secgroup_rule_v2" "allow_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.my_security_group.id
  port_range_max = 22
  protocol = "tcp"
  port_range_min = 22
  remote_ip_prefix = "0.0.0.0/0"

}
resource "openstack_networking_secgroup_rule_v2" "allow_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.my_security_group.id
  port_range_max = 22
  protocol = "tcp"
  port_range_min = 22
  remote_ip_prefix = "0.0.0.0/0"

}

