resource "local_file" "my_file" {
  filename = "rakesh.txt"
  content  = "Create my first file via terraform"
}
