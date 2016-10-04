# public ssh key of the pair for EC2 instances
# replace this one with the pair you generated
resource "aws_key_pair" "admin-app" {
  key_name = "${lookup(var.key_name, var.env)}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrSrCMu4DqAXngybEK98R8a+RUW07QmpS5/1j8ycsFqHER0SMulkfniIkQuxotBDwub5M3yube/AXg3cR64FeMoQ+rw+VE1t5uyJO/jmfuTZsmLW3jZhEdwf06KgYhTgfOlmXuJtzOyJG2uKSbTe1dogoLWiqY83gF+WLVS5pcKNGeA281qzNWy4qqWCla9Hl+oMw+se7qlhZtbGOhQjdPAjWlV3cyUdPlK+cMAietQ2AFPd6jpmH8rQzX9abIi6oH0IrzmZl1iHMF76AucHdCSgyTUOBgZoFxeEwYC30I+pezpCw1KcryawB2BDNh8JIilfDHMBDsvXDDFeIunxxv jespada@Jorges-MacBook-Pro.local"
}
