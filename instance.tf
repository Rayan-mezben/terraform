resource "openstack_compute_instance_v2" "instance" {
  name            = "basic"
  image_id        = "375ed21c-0c1e-45b8-8c83-a5556adcfff9"
  flavor_name       = "v2.m8.d10"
  security_groups = ["default", openstack_networking_secgroup_v2.my_security_group.name]
  user_data = file("./conf.yml")
  metadata = {
    this = "that"
  }

  network {
    name = openstack_networking_network_v2.network.name
  }

}
resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool = "public"

}
resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.floatip_1.address}"
  instance_id = "${openstack_compute_instance_v2.instance.id}"
}
